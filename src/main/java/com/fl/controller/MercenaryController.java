package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.MercenaryDTO;
import com.fl.model.SessionInfo;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
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
            // 1. 페이지 번호 및 검색/카테고리 파라미터 받기
            String page = req.getParameter("page");
            int current_page = (page == null) ? 1 : Integer.parseInt(page);
            
            String category = req.getParameter("category"); // 구인(1)/구직(2)
            String schType = req.getParameter("schType");   // 검색타입
            String kwd = req.getParameter("kwd");           // 검색어
            
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

            // 4. 강사님 방식: offset 계산 (MySQL/MariaDB 기준이면 그대로 사용, Oracle이면 아래 Mapper 참고)
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
 
        try {
        	MercenaryDTO dto = new MercenaryDTO();
        	
			dto.setTitle(req.getParameter("title"));
			dto.setTeam_code(Long.parseLong(req.getParameter("team_code")));
            dto.setContent(req.getParameter("content"));
        	dto.setMember_code(info.getMember_code()); 
            

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
        	// service.updateHitCount(recruit_id);
             MercenaryDTO dto = service.findById(recruit_id);
             String page = req.getParameter("page");
        	
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
    
}