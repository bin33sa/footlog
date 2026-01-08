package com.fl.controller;

import java.io.IOException;

import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/myteam/*")
public class MyTeamController {
	
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
}
