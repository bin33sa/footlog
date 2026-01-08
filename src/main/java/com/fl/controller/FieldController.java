package com.fl.controller;

import java.io.IOException;

import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/field/*")
public class FieldController {
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("field/list");
		
		return mav;
	}
	@RequestMapping("detail")
	public ModelAndView detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("field/detail");
		
		return mav;
	}
}
