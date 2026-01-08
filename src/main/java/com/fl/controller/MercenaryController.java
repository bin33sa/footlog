package com.fl.controller;

import java.io.IOException;
<<<<<<< HEAD
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

            mav.addObject("list", list);
            //mav.addObject("dataCount", dataCount);
            mav.addObject("page", current_page);
            
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
    public ModelAndView writeForm(HttpSession session) {
        // 로그인 여부 체크
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }

        return new ModelAndView("mercenary/write");
    }

    @PostMapping("write")
    public ModelAndView writeSubmit(MercenaryDTO dto, HttpSession session) {
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }

        try {
            // MemberController 스타일: 세션의 member_code를 DTO에 저장
            // DTO의 필드명이 recruitId, memberCode(카멜케이스)인지 확인하세요.
            dto.setMember_code(info.getMember_code()); 
            dto.setStatus("RECRUITING");

            //service.insertMercenary(dto);
            
            return new ModelAndView("redirect:/mercenary/list");
            
        } catch (Exception e) {
            e.printStackTrace();
            ModelAndView mav = new ModelAndView("mercenary/write");
            mav.addObject("message", "등록 중 오류가 발생했습니다.");
            return mav;
        }
    }

    // ==========================================
    // 3. 게시글 상세보기 관련
    // ==========================================
    @GetMapping("article")
    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        ModelAndView mav = new ModelAndView("mercenary/article");
        /*
        try {
        	long recruitId = Long.parseLong(req.getParameter("recruitId"));
            // 조회수 증가 및 상세 데이터 조회
           // service.updateHitCount(recruitId);
            //MercenaryDTO dto = service.findById(recruitId);
            
        	
            if (dto == null) {
                return new ModelAndView("redirect:/mercenary/list");
            }
            
            mav.addObject("dto", dto);
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/error");
        }
        */
        return mav;
        
    }
    
}
=======

import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/mercenary/*")
public class MercenaryController {
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("mercenary/list");
		
		return mav;
	}
}
>>>>>>> branch 'main' of https://github.com/bin33sa/footlog
