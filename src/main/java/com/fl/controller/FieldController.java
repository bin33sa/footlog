package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.StadiumDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
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
	
	
	private StadiumService service = new StadiumServiceImpl();

	
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		StadiumService service = new StadiumServiceImpl();

		int pageNo = 1;   // ⭐ 초기 페이지
		int size   = 6;   // ⭐ 한 페이지 개수

		Map<String,Object> map = new HashMap<>();
		map.put("pageNo", pageNo);
		map.put("size", size);

		List<StadiumDTO> list = service.listStadium(map);

		int dataCount = service.stadiumCount(map);
		int totalPage = (int)Math.ceil((double)dataCount / size);

		ModelAndView mav = new ModelAndView("field/list");
		mav.addObject("list", list);
		mav.addObject("pageNo", pageNo);
		mav.addObject("totalPage", totalPage);

		return mav;
	}
	@RequestMapping("view")
	public ModelAndView detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("field/view");
		
		return mav;
	}
	
	
	@GetMapping("listMore")
	public ModelAndView listMore(int pageNo) {

		int size = 6; // list()와 반드시 동일

		Map<String, Object> map = new HashMap<>();
		map.put("pageNo", pageNo);
		map.put("size", size);

		List<StadiumDTO> list = service.listStadium(map);

		ModelAndView mav = new ModelAndView("field/stadiumListFragment");
		mav.addObject("list", list);

		return mav;
	}


}
