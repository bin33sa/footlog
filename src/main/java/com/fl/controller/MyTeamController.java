package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.JoinRequestDTO;
import com.fl.model.SessionInfo;
import com.fl.model.TeamDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
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
	
	private int getMyRoleLevel(long memberCode, long teamCode) {
        return service.readMemberRoleLevel(memberCode, teamCode);
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
	
	@GetMapping("requestList")
    public ModelAndView requestList(HttpServletRequest req, HttpServletResponse resp) {
        ModelAndView mav = new ModelAndView("myteam/requestList");
        try {
            HttpSession session = req.getSession();
            SessionInfo info = (SessionInfo) session.getAttribute("member");

            if (info == null) {
                return new ModelAndView("redirect:/member/login");
            }

            long memberCode = info.getMember_code(); 
            List<TeamDTO> myTeams = service.listMyTeam(memberCode);
            
            if (myTeams == null || myTeams.isEmpty()) {
                return new ModelAndView("redirect:/main?msg=noteam");
            }
            
            if (myTeams == null || myTeams.isEmpty()) {
                return new ModelAndView("redirect:/myteam/main?msg=no_team");
            }

            long teamCode = myTeams.get(0).getTeam_code();

            List<JoinRequestDTO> list = service.listJoinRequest(teamCode);

            mav.addObject("list", list);
            mav.addObject("team_code", teamCode);

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/main");
        }

        return mav;
    }
	
	@PostMapping("processJoin")
	public ModelAndView processJoin(HttpServletRequest req, HttpServletResponse resp) {

		try {

			long requestCode = Long.parseLong(req.getParameter("request_code"));
			long teamCode = Long.parseLong(req.getParameter("team_code"));
			long memberCode = Long.parseLong(req.getParameter("member_code"));
			int status = Integer.parseInt(req.getParameter("status"));
			String preferredPosition = req.getParameter("preferred_position");

			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("request_code", requestCode);
			paramMap.put("team_code", teamCode);
			paramMap.put("member_code", memberCode);
			paramMap.put("position", preferredPosition); 

			if (status == 2) {
				service.processJoinAccept(paramMap);
			} else {
				service.processJoinReject(paramMap);
			}

			return new ModelAndView("redirect:/team/myPage?team_code=" + teamCode);

		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("team/error");
		}
	}
	
}
