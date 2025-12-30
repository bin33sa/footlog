package com.fl.controller.admin;

import java.io.IOException;

import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class HomeManageController {
	@RequestMapping("/admin")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/home/main");
		return mav;
	}
}
