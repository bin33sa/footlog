package com.fl.controller;

import java.io.IOException;

import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/bbs/*")
public class BbsController {

	// 1. 게시판 목록
	@RequestMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("bbs/list");
		
		return mav;
	}

	// 2. 글쓰기 폼 이동
	@RequestMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 체크 로직이 필요하다면 여기서 수행
		
		ModelAndView mav = new ModelAndView("bbs/write");
		return mav;
	}

	// 3. 글 저장 (Action)
	@RequestMapping("writeDo")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ModelAndView mav = new ModelAndView("redirect:/bbs/list");
		return mav;
	}

	// 4. 글 상세보기
	@RequestMapping("article")
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		ModelAndView mav = new ModelAndView("bbs/article");
		
		return mav;
	}
}