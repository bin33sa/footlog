package com.fl.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/main")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 한글 인코딩 설정
		req.setCharacterEncoding("UTF-8");
		
		// 1. 메인 페이지에 필요한 데이터가 있다면 여기서 준비
		// 예: 최신 게시글 5개 가져오기, 배너 이미지 목록 가져오기 등
		// List<NoticeDTO> notices = noticeService.getLatestList();
		// req.setAttribute("notices", notices);
		
		// 2. 뷰 페이지(JSP)로 포워딩
		String viewPage = "/WEB-INF/views/home/main.jsp";
		req.getRequestDispatcher(viewPage).forward(req, resp);
	}
}