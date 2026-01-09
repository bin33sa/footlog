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

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/mercenary/*")
public class MercenaryController {

    // MemberController 스타일대로 서비스 직접 생성
    private MercenaryService service = new MercenaryServiceImpl();

    // ==========================================
    // 1. 게시글 목록 관련
    // ==========================================
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        
        ModelAndView mav = new ModelAndView("mercenary/list");
        
        try {
        	String page = req.getParameter("page");
            int current_page = (page == null) ? 1 : Integer.parseInt(page);
        	
            Map<String, Object> map = new HashMap<>();
            // 페이징 로직 등이 필요하면 여기에 추가
            
            List<MercenaryDTO> list = service.listMercenary(map);
            //int dataCount = service.dataCount(map);
            
            String cp = req.getContextPath();          
            String articleUrl = cp + "/mercenary/article?page=" + current_page;
            
            mav.addObject("list", list);
            // mav.addObject("dataCount", dataCount);
            mav.addObject("page", current_page);
            mav.addObject("articleUrl", articleUrl);
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/error");
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
        return new ModelAndView("/mercenary/list");
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
			
			dto.setMember_code(info.getMember_code());
			
			service.updateMercenary(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/mercenary/list?page=" + page);
	}
    
}