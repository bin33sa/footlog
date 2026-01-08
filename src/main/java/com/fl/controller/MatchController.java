package com.fl.controller;

import java.io.IOException;

import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@Controller
@RequestMapping("/match/*")
public class MatchController {
	@RequestMapping("article")
	public ModelAndView matchBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("match/article");
		
		return mav;
	}
	
	@RequestMapping("list")
	public ModelAndView matchList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("match/list");
		
		return mav;
	}
	
	@RequestMapping("write")
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("match/write");
		
		return mav;
	}
	
	@RequestMapping("myMatch")
	public ModelAndView myMatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("match/myMatch");
		
		return mav;
	}
}
