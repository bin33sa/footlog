package com.fl.controller;

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
            String page = req.getParameter("page");
            int current_page = (page == null) ? 1 : Integer.parseInt(page);

            String category = req.getParameter("category"); // 1:공지, 2:자유 등
            
            
            String schType = req.getParameter("schType");
            String kwd = req.getParameter("kwd");

            if (schType == null) {
                schType = "all";
                kwd = "";
            }
            kwd = util.decodeUrl(kwd);

            int size = 10;
            Map<String, Object> map = new HashMap<>();
            map.put("category", category);
            map.put("schType", schType);
            map.put("kwd", kwd);
            
            int categoryNum = (category == null || category.isEmpty()) ? 0 : Integer.parseInt(category);
            map.put("category", categoryNum);
            
            int dataCount = service.dataCount(map);
            int total_page = util.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);

            int offset = (current_page - 1) * size;
            map.put("offset", Math.max(offset, 0));
            map.put("size", size);

            List<BoardDTO> list = service.listBoard(map);

            String cp = req.getContextPath();
            String query = "";
            if (category != null && !category.isEmpty()) {
                query = "category=" + category;
            }
            if (!kwd.isBlank()) {
                if (!query.isEmpty()) query += "&";
                query += "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
            }

            String listUrl = cp + "/bbs/list";
            if (!query.isEmpty()) listUrl += "?" + query;

            String paging = util.paging(current_page, total_page, listUrl);

            mav.addObject("list", list);
            mav.addObject("dataCount", dataCount);
            mav.addObject("page", current_page);
            mav.addObject("total_page", total_page);
            mav.addObject("paging", paging);
            mav.addObject("category", category);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }

	// 2. 글쓰기 폼 이동
    @GetMapping("write")
    public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) {
        String category = req.getParameter("category");
        ModelAndView mav = new ModelAndView("bbs/write");
        mav.addObject("mode", "write");
        mav.addObject("category", category);
        return mav;
    }

 // 3. 글 등록
    @PostMapping("write")
    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        try {
            BoardDTO dto = new BoardDTO();
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setCategory(Integer.parseInt(req.getParameter("category")));
            dto.setVideo_url(req.getParameter("video_url"));
            dto.setMember_code(info.getMember_code());

            service.insertBoard(dto);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/bbs/list?category=" + req.getParameter("category"));
    }

 // 4. 상세 보기
    @GetMapping("article")
    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) {
        ModelAndView mav = new ModelAndView("bbs/article");

        try {
            long board_main_code = Long.parseLong(req.getParameter("board_main_code"));
            String page = req.getParameter("page");
            String category = req.getParameter("category");

            // ServiceImpl 내부에서 updateHitCount 호출됨
            BoardDTO dto = service.findById(board_main_code);

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