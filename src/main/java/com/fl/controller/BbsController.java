package com.fl.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.BoardDTO;
import com.fl.model.BoardReplyDTO;
import com.fl.model.SessionInfo;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.annotation.ResponseBody;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.BoardService;
import com.fl.service.BoardServiceImpl;
import com.fl.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/bbs/*")
public class BbsController {
	
	private BoardService service = new BoardServiceImpl();
    private MyUtil util = new MyUtil();
    
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("bbs/list");

        try {
            String cp = req.getContextPath();
            
            // 1. 페이지 번호 설정
            String page = req.getParameter("page");
            int current_page = (page == null) ? 1 : Integer.parseInt(page);

            // 2. 카테고리 설정 (기본값: 2 - 자유게시판)
            String category = req.getParameter("category");
            if (category == null || category.isEmpty()) {
                category = "2"; 
            }
            int categoryNum = Integer.parseInt(category);

            // 3. 게시판 이름 및 설명 동적 설정
            String boardName = "";
            String boardDesc = ""; // 서브 타이틀 추가
            
            // 갤러리는 한 페이지에 9개(3x3), 나머지는 10개씩 출력
            int size = 10; 

            if (category.equals("1")) {
                boardName = "NOTICE";
                boardDesc = "Footlog의 주요 소식과 업데이트를 확인하세요.";
            } else if (category.equals("2")) {
                boardName = "FREE BOARD";
                boardDesc = "축구 팬들과 자유롭게 소통하세요.";
            } else if (category.equals("3")) {
                boardName = "EVENT / NEWS";
                boardDesc = "진행 중인 이벤트와 새로운 뉴스를 만나보세요.";
            } else if (category.equals("4")) {
                boardName = "GALLERY";
                boardDesc = "활동 사진을 공유하고 추억을 남겨보세요.";
                size = 9; // 갤러리는 가로 3개씩 배치를 위해 9개로 설정
            } else {
                boardName = "BOARD";
            }

            // 4. 검색 조건 설정
            String schType = req.getParameter("schType");
            String kwd = req.getParameter("kwd");
            if (schType == null) {
                schType = "all";
                kwd = "";
            }
            kwd = util.decodeUrl(kwd);

            // 5. DB 조회를 위한 Map 세팅
            Map<String, Object> map = new HashMap<>();
            map.put("category", categoryNum);
            map.put("schType", schType);
            map.put("kwd", kwd);
            
            // 6. 페이징 로직
            int dataCount = service.dataCount(map);
            int total_page = util.pageCount(dataCount, size);
            if (current_page > total_page) current_page = total_page;

            int offset = (current_page - 1) * size;
            map.put("offset", Math.max(offset, 0));
            map.put("size", size);

            // 7. 게시글 리스트 조회
            List<BoardDTO> list = service.listBoard(map);

            // 8. 쿼리 스트링 구성
            String query = "category=" + category;
            if (!kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
            }

            String listUrl = cp + "/bbs/list?" + query;
            String paging = util.paging(current_page, total_page, listUrl);

            // 9. 결과 데이터 전달
            mav.addObject("list", list);
            mav.addObject("dataCount", dataCount);
            mav.addObject("page", current_page);
            mav.addObject("total_page", total_page);
            mav.addObject("paging", paging);
            mav.addObject("category", category);
            mav.addObject("boardName", boardName); 
            mav.addObject("boardDesc", boardDesc); // 추가된 설명문

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }

    
    // 파일 이름을 추출하기 위한 보조 메서드
    private String getOriginalFilename(jakarta.servlet.http.Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
    
    @PostMapping("write")
    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        String category = req.getParameter("category");
        
        if (info == null) return new ModelAndView("redirect:/member/login");
        
        if (category != null && category.equals("1") && info.getRole_level() < 51) {
            return new ModelAndView("redirect:/bbs/list?category=1");
        }
        
        try {
            BoardDTO dto = new BoardDTO();
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setCategory(Integer.parseInt(category));
            dto.setVideo_url(req.getParameter("video_url"));
            dto.setMember_code(info.getMember_code());

            // [갤러리(category=4) 파일 처리 추가]
            if (category.equals("4")) {
                // 1. 저장 경로 설정
                String root = session.getServletContext().getRealPath("/");
                String pathname = root + "uploads" + File.separator + "gallery";
                
                File dir = new File(pathname);
                if(!dir.exists()) dir.mkdirs(); // 폴더가 없으면 생성

                // 2. 파일 추출 (MultipartHttpServletRequest 대신 서블릿 Part 사용)
                // write.jsp의 input name이 "selectFile"이어야 합니다.
                jakarta.servlet.http.Part part = req.getPart("selectFile");
                
                if (part != null && part.getSize() > 0) {
                    // 파일 확장자 추출 및 고유 파일명 생성
                    String originalFilename = getOriginalFilename(part);
                    String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                    String saveFilename = System.currentTimeMillis() + ext; // 현재시간 기반 이름 변경
                    
                    // 파일 물리적 저장
                    part.write(pathname + File.separator + saveFilename);
                    
                    // DTO에 파일명 세팅 (DB 입력용)
                    dto.setImageFilename(saveFilename);
                }

                // 3. 갤러리 전용 서비스 호출
                service.insertGallery(dto);
                
            } else {
                // 일반 게시판 등록
                service.insertBoard(dto);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return new ModelAndView("redirect:/bbs/list?category=" + category);
    }

    
    @GetMapping("write")
    public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }

        String category = req.getParameter("category");
        if (category == null || category.isEmpty()) {
            category = "2"; 
        }

        // [추가] 공지사항(1)은 관리자만 작성 가능
        if (category.equals("1") && info.getRole_level() < 51) {
            // 관리자가 아니면 자유게시판으로 튕겨내거나 에러 페이지로 이동
            return new ModelAndView("redirect:/bbs/list?category=1");
        }

        ModelAndView mav = new ModelAndView("bbs/write");
        mav.addObject("category", category);
        mav.addObject("mode", "write");
        return mav;
    }
    
    @GetMapping("update")
    public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) return new ModelAndView("redirect:/member/login");

        String page = req.getParameter("page");
        String category = req.getParameter("category");
        long board_main_code = Long.parseLong(req.getParameter("board_main_code"));

        try {
            // 1. MyBatis 전달용 Map 생성
            Map<String, Object> map = new HashMap<>();
            map.put("board_main_code", board_main_code);
            map.put("category", Integer.parseInt(category)); // category 정보를 반드시 포함
       
            // 2. 서비스 호출 시 Map 전달 (수정된 부분)
            // 이제 파라미터 타입 불일치 에러가 사라집니다.
            BoardDTO dto = service.findById(map);

            if (dto == null || dto.getMember_code() != info.getMember_code()) {
                return new ModelAndView("redirect:/bbs/list?page=" + page + "&category=" + category);
            }

            // 갤러리/일반글 모두 'write.jsp'를 공유하므로 경로는 유지
            ModelAndView mav = new ModelAndView("bbs/write"); 
            mav.addObject("dto", dto);
            mav.addObject("page", page);
            mav.addObject("category", category);
            mav.addObject("mode", "update");
            return mav;
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/bbs/list?page=" + page + "&category=" + category);
        }
    }
    
    @PostMapping("update")
    public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        String category = req.getParameter("category");
        String page = req.getParameter("page");
        
        try {
            BoardDTO dto = new BoardDTO();
            dto.setBoard_main_code(Long.parseLong(req.getParameter("board_main_code")));
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setMember_code(info.getMember_code());
            dto.setCategory(Integer.parseInt(category));

            // [갤러리 이미지 수정 로직]
            if (category.equals("4")) {
                jakarta.servlet.http.Part part = req.getPart("selectFile");
                if (part != null && part.getSize() > 0) {
                    // 새로운 파일이 업로드 된 경우
                    String root = session.getServletContext().getRealPath("/");
                    String pathname = root + "uploads" + File.separator + "gallery";
                    
                    String originalFilename = getOriginalFilename(part);
                    String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                    String saveFilename = System.currentTimeMillis() + ext;
                    
                    part.write(pathname + File.separator + saveFilename);
                    
                    // DTO에 새로운 파일명 세팅 (이게 있어야 Mapper에서 인식함)
                    dto.setImageFilename(saveFilename);
                }
            }
            
            service.updateBoard(dto);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/bbs/list?page=" + page + "&category=" + category);
    }
    
 // 4. 상세 보기
    @GetMapping("article")
    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) {
        ModelAndView mav = new ModelAndView("bbs/article");

        try {
            // 파라미터 받기
            long board_main_code = Long.parseLong(req.getParameter("board_main_code"));
            String page = req.getParameter("page");
            int category = Integer.parseInt(req.getParameter("category")); // int로 변환

            // 핵심: MyBatis 전달용 Map 생성
            Map<String, Object> map = new HashMap<>();
            map.put("board_main_code", board_main_code);
            map.put("category", category); // 이 값이 있어야 갤러리/일반 게시판 분기가 작동함

            // 이제 에러 없이 실행될 것입니다.
            service.updateHitCount(map); 
            BoardDTO dto = service.findById(map);

            if (dto == null) {
                return new ModelAndView("redirect:/bbs/list?page=" + page + "&category=" + category);
            }

            mav.addObject("dto", dto);
            mav.addObject("page", page);
            mav.addObject("category", category);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }
    
 // 5. 삭제
    @GetMapping("delete")
    public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        String page = req.getParameter("page");
        String category = req.getParameter("category");

        try {
            long board_main_code = Long.parseLong(req.getParameter("board_main_code"));
            Map<String, Object> map = new HashMap<>();
            map.put("board_main_code", board_main_code);
            map.put("member_code", info.getMember_code());
            map.put("category", Integer.parseInt(category)); // 이 부분이 반드시 추가되어야 합니다!

            service.deleteBoard(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/bbs/list?page=" + page + "&category=" + category);
    }
    
 // 6. 댓글 리스트 (AJAX)
    @GetMapping("listReply")
    @ResponseBody
    public Map<String, Object> listReply(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> model = new HashMap<>();
        try {
            long board_main_code = Long.parseLong(req.getParameter("board_main_code"));
            String pageNo = req.getParameter("pageNo");
            int current_page = (pageNo != null) ? Integer.parseInt(pageNo) : 1;

            int size = 5;
            Map<String, Object> map = new HashMap<>();
            map.put("board_main_code", board_main_code);

            int replyCount = service.replyCount(map);
            int total_page = util.pageCount(replyCount, size);
            current_page = Math.min(current_page, total_page);

            map.put("offset", Math.max((current_page - 1) * size, 0));
            map.put("size", size);

            List<BoardReplyDTO> listReply = service.listReply(map);
            String paging = util.pagingMethod(current_page, total_page, "loadContent");

            model.put("listReply", listReply);
            model.put("replyCount", replyCount);
            model.put("paging", paging);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }
    
 // 7. 댓글 등록 (AJAX - Post)
    @PostMapping("insertReply")
    @ResponseBody
    public Map<String, Object> insertReplySubmit(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> model = new HashMap<>();
        
        // 1. 세션 확인
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            model.put("state", "loginFail");
            return model;
        }

        String state = "false";
        try {
            // 2. 전달받은 값 콘솔 출력 (디버깅용)
            String boardCodeStr = req.getParameter("board_main_code");
            String content = req.getParameter("content");
            
            System.out.println(">>> 전달받은 게시글 번호: " + boardCodeStr);
            System.out.println(">>> 전달받은 내용: " + content);
            System.out.println(">>> 작성자 코드: " + info.getMember_code());

            if(boardCodeStr == null || content == null || content.trim().isEmpty()) {
                 System.out.println("!!! 오류: 파라미터가 비어있습니다 !!!");
                 model.put("state", "false");
                 return model;
            }

            BoardReplyDTO dto = new BoardReplyDTO();
            dto.setBoard_main_code(Long.parseLong(boardCodeStr));
            dto.setContent(content);
            dto.setMember_code(info.getMember_code());

            service.insertReply(dto);
            state = "true";
            System.out.println(">>> 댓글 저장 성공!");
            
        } catch (Exception e) {
            System.out.println(">>> 댓글 저장 중 에러 발생!");
            e.printStackTrace(); // 3. 에러 발생 시 콘솔에 빨간 글씨로 원인이 나옵니다.
        }

        model.put("state", state);
        return model;
    }
}