package com.fl.controller;

import java.io.IOException;
import java.util.List;

import com.fl.model.PageResult;
import com.fl.model.StadiumDTO;
import com.fl.model.StadiumTimeSlotDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.StadiumService;
import com.fl.service.StadiumServiceImpl;
import com.fl.service.TimeSlotService;
import com.fl.service.TimeSlotServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/field/*")
public class FieldController {

	private StadiumService Stadiumservice = new StadiumServiceImpl();
	private TimeSlotService TimeSlotservice = new TimeSlotServiceImpl();

	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int pageNo = 1;
		int size = 4;
		String keyword = req.getParameter("keyword");
		String sort = req.getParameter("sort");

		PageResult<StadiumDTO> result = Stadiumservice.listStadium(pageNo, size, keyword, sort);

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
		
		StadiumDTO dto = Stadiumservice.findById(stadiumCode);
		
		
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
		
		PageResult<StadiumDTO> result = Stadiumservice.listStadium(pageNo, size, keyword, sort);

		ModelAndView mav = new ModelAndView("field/stadiumList");
		
		mav.addObject("list", result.getList());
		mav.addObject("pageNo", result.getPageNo());
		mav.addObject("totalPage", result.getTotalPage());
		
		mav.addObject("keyword", keyword);
		mav.addObject("sort", sort);

		return mav;
	}
	
	
	
	//날짜에 따른 타임슬롯
	@GetMapping("timeSlot")
	public ModelAndView timeSlot(HttpServletRequest req, HttpServletResponse resp) 
				throws ServletException, IOException{
			
		int stadiumCode = Integer.parseInt(req.getParameter("stadiumCode"));
		String playDate = req.getParameter("date");
		
	    // 날짜 평일/주말 판단
	    String dayType = TimeSlotservice.isWeekend(playDate) ? "WEEKEND" : "WEEKDAY" ;
	    
	    List<StadiumTimeSlotDTO> result = TimeSlotservice.TimeSlots(stadiumCode, playDate, dayType);

	    ModelAndView mav = new ModelAndView("field/timeSlot");
	    mav.addObject("list", result);

	    return mav;
	}

}
