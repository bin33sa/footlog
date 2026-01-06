package com.fl.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// bbs 로 시작하는 모든 요청을 처리
@WebServlet("/bbs/*")
public class BbsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action(request, response);
	}

	private void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = uri.substring(contextPath.length()); // "/bbs/list", "/bbs/write" 등으로 잘림

		// 1. 게시판 목록
		if (command.equals("/bbs/list")) {
			// TODO: DB에서 게시글 리스트 조회 (List<BbsDTO>)
			// request.setAttribute("list", list);
			request.getRequestDispatcher("/WEB-INF/views/bbs/list.jsp").forward(request, response);
		}
		
		// 2. 글쓰기 폼 이동
		else if (command.equals("/bbs/write")) {
			// 로그인 체크 필요
			request.getRequestDispatcher("/WEB-INF/views/bbs/write.jsp").forward(request, response);
		}
		
		// 3. 글 저장 (Action)
		else if (command.equals("/bbs/writeDo")) {
			// TODO: DB 저장 로직
			response.sendRedirect(contextPath + "/bbs/list");
		}
		
		// 4. 글 상세보기
		else if (command.equals("/bbs/view")) {
			// String seq = request.getParameter("seq");
			// TODO: DB에서 상세 내용 조회
			request.getRequestDispatcher("/WEB-INF/views/bbs/view.jsp").forward(request, response);
		}
	}
}