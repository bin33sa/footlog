package com.fl.controller;

import java.io.IOException;

import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {

	// 1. 공지사항 리스트 화면
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리스트 조회 로직
		ModelAndView mav = new ModelAndView("notice/list");
		return mav;
	}

	// 2. 공지사항 글쓰기 (GET: 폼, POST: 처리)
	@RequestMapping("write")
	public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getMethod().equalsIgnoreCase("GET")) {
			// GET: 글쓰기 폼으로 이동
			ModelAndView mav = new ModelAndView("notice/write");
			return mav;
		} else {
			// POST: DB 저장 로직 (나중에 추가)
			
			// 저장 후 리스트로 리다이렉트
			ModelAndView mav = new ModelAndView("redirect:/notice/list");
			return mav;
		}
	}

	// 3. 공지사항 상세보기
	@RequestMapping("article")
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 상세 조회 로직 (나중에 추가)
		ModelAndView mav = new ModelAndView("notice/article");
		return mav;
	}

	// 4. 공지사항 삭제
	@RequestMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제 로직 (나중에 추가)
		
		ModelAndView mav = new ModelAndView("redirect:/notice/list");
		return mav;
	}
}