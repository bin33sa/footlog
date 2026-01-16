package com.fl.controller;

import java.io.IOException;
import java.util.List;

import com.fl.model.MatchDTO;
import com.fl.model.MemberDTO;
import com.fl.model.SessionInfo;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.MyPageService;
import com.fl.service.MyPageServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/admin/*")
public class MypageAdminController {

	private MyPageService myPageService = new MyPageServiceImpl();
	
	@GetMapping("mypage")
	public ModelAndView myPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView("admin/mypage");
		
		try {
			if(info != null) {
				MemberDTO myInfo = myPageService.readMember(info.getMember_code());
				List<MatchDTO> matchList = myPageService.listMyMatch(info.getMember_code());
				
				mav.addObject("dto", myInfo);
				mav.addObject("matchList", matchList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	
	
}
