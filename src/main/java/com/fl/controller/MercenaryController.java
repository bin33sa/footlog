package com.fl.controller;

import java.io.IOException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.MercenaryDTO;
import com.fl.model.MercenaryReplyDTO;
import com.fl.model.SessionInfo;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.annotation.ResponseBody;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.MercenaryService;
import com.fl.service.MercenaryServiceImpl;
import com.fl.util.MyUtil;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/mercenary/*")
public class MercenaryController {

    // MemberController 스타일대로 서비스 직접 생성
    private MercenaryService service = new MercenaryServiceImpl();
    private MyUtil util = new MyUtil();
    
    // ==========================================
    // 1. 게시글 목록 관련
    // ==========================================
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        
        ModelAndView mav = new ModelAndView("mercenary/list");
        
        
        try {
           
            String page = req.getParameter("page");
            int current_page = (page == null) ? 1 : Integer.parseInt(page);
            
            String category = req.getParameter("category"); 
            String schType = req.getParameter("schType");   
            String kwd = req.getParameter("kwd");           
            
            if(schType == null) {
                schType = "all";
                kwd = "";
            }
            kwd = util.decodeUrl(kwd);

            // 2. 기본 설정
            int size = 10;
            int total_page = 0;
            int dataCount = 0;

            Map<String, Object> map = new HashMap<>();
            map.put("category", category);
            map.put("schType", schType);
            map.put("kwd", kwd);

            // 3. 전체 데이터 개수 및 총 페이지 수 계산
            dataCount = service.dataCount(map);
            total_page = util.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);

            
            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;

            map.put("offset", offset);
            map.put("size", size);

            // 5. 리스트 가져오기
            List<MercenaryDTO> list = service.listMercenary(map);

            // 6. 페이징 URL 처리
            String cp = req.getContextPath();
            String query = "";
            if(category != null && !category.isEmpty()) {
                query = "category=" + category;
            }
            if(!kwd.isBlank()) {
                if(!query.isEmpty()) query += "&";
                query += "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
            }

            String listUrl = cp + "/mercenary/list";
            String articleUrl = cp + "/mercenary/article?page=" + current_page;
            if(!query.isEmpty()) {
                listUrl += "?" + query;
                articleUrl += "&" + query;
            }

            String paging = util.paging(current_page, total_page, listUrl);

            // 7. JSP 전달
            mav.addObject("list", list);
            mav.addObject("dataCount", dataCount);
            mav.addObject("page", current_page);
            mav.addObject("total_page", total_page);
            mav.addObject("paging", paging);
            mav.addObject("category", category);
            mav.addObject("articleUrl", articleUrl);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }

    // ==========================================
    // 2. 게시글 등록 관련
    // ==========================================
    @GetMapping("write")
    public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) {
    	HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        try {
        	ModelAndView mav = new ModelAndView("mercenary/write");
        	
        	Map<String, Object> map = new HashMap<>();
        	map.put("member_code", info.getMember_code());
        	
        	List<MercenaryDTO> listTeam = service.listTeam(map);
        	
        	mav.addObject("listTeam", listTeam);
    		mav.addObject("mode", "write");
    		return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
        
		return new ModelAndView("redirect:/mercenary/list");
        
    }

    @PostMapping("write")
    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        if (info == null) return new ModelAndView("redirect:/member/login");

        try {
            MercenaryDTO dto = new MercenaryDTO();
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setMember_code(info.getMember_code());
            
            String teamStr = req.getParameter("team_code");
            if(teamStr != null && !teamStr.isEmpty()) {
                long team_code = Long.parseLong(teamStr);
                dto.setTeam_code(team_code);

                // [핵심 로직] 해당 팀에서의 역할 레벨 조회
                Map<String, Object> map = new HashMap<>();
                map.put("member_code", info.getMember_code());
                map.put("team_code", team_code);
                
                // service에 해당 유저의 팀내 레벨을 가져오는 메서드 호출 (아래 2번 참고)
                int teamLevel = service.getUserTeamLevel(map);

                // 이미지 기준: 매니저(10) 이상이면 RECRUIT(구인), 아니면 SEEK(구직)
                if (teamLevel >= 10) {
                    dto.setCategory("RECRUIT"); 
                } else {
                    dto.setCategory("SEEK");    
                }
            } else {
                // 팀 선택 없이 개인으로 글을 쓸 경우 기본적으로 SEEK(구직) 처리
                dto.setCategory("SEEK");
            }

            service.insertMercenary(dto);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/mercenary/list");
    }
    
    // ==========================================
    // 3. 게시글 상세보기 관련
    // ==========================================
    @GetMapping("article")
    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        ModelAndView mav = new ModelAndView("mercenary/article");
        
        try {
        	long recruit_id = Long.parseLong(req.getParameter("recruit_id"));
            // 조회수 증가 및 상세 데이터 조회
        	 String page = req.getParameter("page");
        	 
        	 service.updateHitCount(recruit_id);
        	 
             MercenaryDTO dto = service.findById(recruit_id);
        	
            if (dto == null) {
                return new ModelAndView("redirect:/mercenary/list");
            }
            
            mav.addObject("dto", dto);
            mav.addObject("page", page);
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/error");
        }
        
        return mav;
        
    }
    
    @GetMapping("update")
	public ModelAndView updateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		try {
			long recruit_id = Long.parseLong(req.getParameter("recruit_id"));
			
			MercenaryDTO dto = service.findById(recruit_id);
			if(dto == null || ! info.getMember_code().equals(dto.getMember_code())) {
				return new ModelAndView("redirect:/mercenary/list?page=" + page);
			}
			
			ModelAndView mav = new ModelAndView("mercenary/write");
			
			Map<String, Object> map = new HashMap<>();
	        map.put("member_code", info.getMember_code());
	        List<MercenaryDTO> listTeam = service.listTeam(map);
	        mav.addObject("listTeam", listTeam);
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("mode", "update");
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/mercenary/list?page=" + page);
	}
	
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		try {
			MercenaryDTO dto = new MercenaryDTO();
			
			dto.setRecruit_id(Long.parseLong(req.getParameter("recruit_id")));
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			
			dto.setTeam_code(Long.parseLong(req.getParameter("team_code")));
			
			dto.setMember_code(info.getMember_code());
			
			service.updateMercenary(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/mercenary/list?page=" + page);
	}
	
	@GetMapping("delete")
	public ModelAndView deleteMercenary(HttpServletRequest req, HttpServletResponse resp) {
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    
	    String page = req.getParameter("page");
	    try {
	        long recruit_id = Long.parseLong(req.getParameter("recruit_id"));
	        
	        Map<String, Object> map = new HashMap<>();
	        map.put("recruit_id", recruit_id);
	        map.put("member_code", info.getMember_code()); // 로그인한 사용자의 코드
	        
	        service.deleteMercenary(map);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return new ModelAndView("redirect:/mercenary/list?page=" + page);
	}
    
	// 댓글 및 댓글의 답글 저장 : AJAX - JSON
	@ResponseBody
	@PostMapping("insertReply")
	public Map<String, Object> insertReply(HttpServletRequest req, HttpServletResponse resp) { // 파라미터 형식을 통일
	    Map<String, Object> model = new HashMap<>();
	    
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    
	    if (info == null) {
	        model.put("state", "loginFail");
	        return model;
	    }

	    try {
	        // DTO를 메서드 파라미터가 아닌 내부에서 직접 생성 및 세팅
	        MercenaryReplyDTO dto = new MercenaryReplyDTO();
	        
	        // 파라미터 수동 바인딩
	        dto.setRecruit_id(Long.parseLong(req.getParameter("recruit_id")));
	        dto.setContent(req.getParameter("content"));
	        
	        String parentId = req.getParameter("parent_comment_id");
	        if(parentId != null && !parentId.isEmpty()) {
	            dto.setParent_comment_id(Integer.parseInt(parentId));
	        }
	        
	        dto.setMember_code(info.getMember_code()); 
	        
	        service.insertReply(dto);
	        model.put("state", "true");
	    } catch (Exception e) {
	        e.printStackTrace(); // 에러 로그 확인용
	        model.put("state", "false");
	    }
	    
	    return model;
	}
		
		// 댓글 리스트 : AJAX - JSON
		@GetMapping("listReply")
		@ResponseBody // 반드시 추가해야 함 
		public Map<String, Object> listReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		    HttpSession session = req.getSession();
		    SessionInfo info = (SessionInfo)session.getAttribute("member");
		    
		    // 비로그인 시에도 댓글 목록은 보여줘야 하므로 403 에러 제거 
		    try {
		        Map<String, Object> model = new HashMap<>();
		        long recruit_id = Long.parseLong(req.getParameter("recruit_id"));
		        String pageNo = req.getParameter("pageNo");
		        int current_page = (pageNo != null) ? Integer.parseInt(pageNo) : 1;
		        
		        int size = 5; 
		        Map<String, Object> map = new HashMap<>();
		        map.put("recruit_id", recruit_id);
		        
		        // 로그인 정보가 있을 때만 본인 확인용 코드 추가
		        if(info != null) {
		            map.put("member_code", info.getMember_code());
		            map.put("userLevel", info.getRole_level());
		        }

		        int replyCount = service.replyCount(map);
		        int total_page = util.pageCount(replyCount, size);
		        current_page = Math.min(current_page, total_page);
		        
		        int offset = (current_page - 1) * size;
		        map.put("offset", Math.max(offset, 0));
		        map.put("size", size);
		        
		        List<MercenaryReplyDTO> listReply = service.listReply(map);
		        
		        // 페이징 처리 (JS의 loadContent 호출)
		        String paging = util.pagingMethod(current_page, total_page, "loadContent");
		        
		        model.put("listReply", listReply);
		        model.put("replyCount", replyCount);
		        model.put("paging", paging);
		        
		        return model;
		    } catch (Exception e) {
		        e.printStackTrace();
		        resp.sendError(406);
		        return null;
		    }
		}

	// 댓글 삭제 - AJAX (JSON 반환)
	@PostMapping("deleteReply")
	@ResponseBody
	public Map<String, Object> deleteReply(HttpServletRequest req) {
	    Map<String, Object> model = new HashMap<>();
	    
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    
	    if (info == null) {
	        model.put("state", "loginFail");
	        return model;
	    }

	    try {
	        int comment_id = Integer.parseInt(req.getParameter("comment_id"));
	        
	        Map<String, Object> map = new HashMap<>();
	        map.put("comment_id", comment_id);
	        map.put("member_code", info.getMember_code()); 
	        map.put("role_level", info.getRole_level());     // 관리자 확인용 (필요시)

	        service.deleteReply(map);
	        model.put("state", "true");
	    } catch (Exception e) {
	        model.put("state", "false");
	    }
	    
	    return model;
	}
	
	
}