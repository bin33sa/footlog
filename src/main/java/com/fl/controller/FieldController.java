package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.PageResult;
import com.fl.model.StadiumDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.annotation.ResponseBody;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.StadiumService;
import com.fl.service.StadiumServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/field/*")
public class FieldController {

	private StadiumService service = new StadiumServiceImpl();

	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int pageNo = 1;
		int size = 4;
		String keyword = req.getParameter("keyword");
		String sort = req.getParameter("sort");

		PageResult<StadiumDTO> result = service.listStadium(pageNo, size, keyword, sort);

		ModelAndView mav = new ModelAndView("field/list");
		mav.addObject("list", result.getList());
		mav.addObject("pageNo", result.getPageNo());
		mav.addObject("totalPage", result.getTotalPage());
		
		mav.addObject("keyword", keyword);
		mav.addObject("sort", sort);

		return mav;
	}

	@RequestMapping("view")
	public ModelAndView detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		int stadiumCode = Integer.parseInt(req.getParameter("stadiumCode"));
		
		StadiumDTO dto = service.findById(stadiumCode);
		
		
		ModelAndView mav = new ModelAndView("field/view");
		
		mav.addObject("dto", dto);
		
		return mav;
	}

	@GetMapping("listMore")
	public ModelAndView listMore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

		int pageNo = Integer.parseInt(req.getParameter("pageNo"));
		int size = 4; // list()와 반드시 동일
		String keyword = req.getParameter("keyword");
		String sort = req.getParameter("sort");
		
		PageResult<StadiumDTO> result = service.listStadium(pageNo, size, keyword, sort);

		ModelAndView mav = new ModelAndView("field/stadiumList");
		
		mav.addObject("list", result.getList());
		mav.addObject("pageNo", result.getPageNo());
		mav.addObject("totalPage", result.getTotalPage());
		
		mav.addObject("keyword", keyword);
		mav.addObject("sort", sort);

		return mav;
	}
	
	
	
	//날짜에 따른 타임슬롯
	@GetMapping("times")
	@ResponseBody
	public Map<String, Object> times(HttpServletRequest req, HttpServletResponse resp) 
				throws ServletException, IOException{
			
		int stadiumCode = Integer.parseInt(req.getParameter("stadiumCode"));
	    String date = req.getParameter("date");
		
		  Map<String, Object> map = new HashMap<>();
		    map.put("available", List.of("12:00", "14:00"));
		    map.put("reserved", List.of("10:00", "16:00"));

		    System.out.println(stadiumCode);
		    
		    return map;
	}

}
