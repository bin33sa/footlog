package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.fl.model.JoinRequestDTO;
import com.fl.model.SessionInfo;
import com.fl.model.TeamMemberDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.MyTeamService;
import com.fl.service.MyTeamServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/myteam/*")
public class MyTeamController {
	
	private MyTeamService service = new MyTeamServiceImpl();
	
	@RequestMapping("main")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("myteam/main");
		
		return mav;
	}
	
	@RequestMapping("squad")
	public ModelAndView squad(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("myteam/squad");
		
		return mav;
	}
	
	@RequestMapping("match")
	public ModelAndView match(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("myteam/match");
		
		return mav;
	}
	@RequestMapping("matchdetail")
	public ModelAndView matchdetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("myteam/matchdetail");
		
		return mav;
	}
	
	/*
	@PostMapping("processJoin")
	public ModelAndView processJoin(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member"); // 세션에서 정보 가져오기

		try {
			long teamCode = Long.parseLong(req.getParameter("team_code"));
			long memberCode = Long.parseLong(req.getParameter("member_code"));
			int status = Integer.parseInt(req.getParameter("status"));
			String preferredPosition = req.getParameter("preferred_position");

			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("team_code", teamCode);
			paramMap.put("member_code", memberCode);
			paramMap.put("status", status);

			service.updateJoinRequestStatus(paramMap);

			if (status == 2) {
				TeamMemberDTO memberDto = new TeamMemberDTO();
				memberDto.setTeam_code(teamCode);
				memberDto.setMember_code(memberCode);
				memberDto.setPosition(preferredPosition);

				service.insertTeamMember(memberDto);
				service.updateTeamMemberCountUp(teamCode);
			}

			return new ModelAndView("redirect:/team/myPage?team_code=" + teamCode);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	*/
}
