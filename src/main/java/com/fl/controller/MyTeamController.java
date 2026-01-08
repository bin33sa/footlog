package com.fl.controller;

import java.io.IOException;
import java.util.List;

import com.fl.model.JoinRequestDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.MyTeamService;
import com.fl.service.MyTeamServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/myteam/*")
public class MyTeamController {
	
	private MyTeamService service = new MyTeamServiceImpl();
	
	@RequestMapping("main")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("myteam/main");
		
		return mav;
	}
	
	@RequestMapping("squad")
	public ModelAndView squad(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("myteam/squad");
		
		return mav;
	}
	
	@RequestMapping("match")
	public ModelAndView match(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("myteam/match");
		
		return mav;
	}
	@RequestMapping("matchdetail")
	public ModelAndView matchdetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("myteam/matchdetail");
		
		return mav;
	}
	

	/*
	@PostMapping("processJoin")
	public String processJoin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    try {
	        
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return ; 
	}
	*/
}
