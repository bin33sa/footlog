package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.StadiumDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.StadiumService;
import com.fl.service.StadiumServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/field/*")
public class FieldController {
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		StadiumService service = new StadiumServiceImpl();
		
		Map<String,Object> map = new HashMap<>();
		List<StadiumDTO> list = service.listStadium(map);
		
		ModelAndView mav = new ModelAndView("field/list");
		
		mav.addObject("list", list);
		
		
		
		return mav;
	}
	@RequestMapping("view")
	public ModelAndView detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("field/view");
		
		return mav;
	}
}
