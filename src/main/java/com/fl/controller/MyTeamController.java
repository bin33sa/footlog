package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.JoinRequestDTO;
import com.fl.model.SessionInfo;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;
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

    private long setTeamInfoAndRole(HttpSession session, ModelAndView mav) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) return -1;
            
            long memberCode = info.getMember_code();

            List<TeamDTO> myTeams = service.listMyTeam(memberCode);

            if (myTeams == null || myTeams.isEmpty()) return -1;

            TeamDTO currentTeam = myTeams.get(0);
            long teamCode = currentTeam.getTeam_code();
            
            int myRoleLevel = service.readMemberRoleLevel(memberCode, teamCode);
            
            mav.addObject("team_code", teamCode);
            mav.addObject("myRoleLevel", myRoleLevel);
            mav.addObject("myTeamName", currentTeam.getTeam_name());

            return teamCode;

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    @GetMapping("main")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("myteam/main");
        HttpSession session = req.getSession();
        
        long teamCode = setTeamInfoAndRole(session, mav);
        
        if (teamCode == -1) {
            return new ModelAndView("redirect:/team/list?msg=noteam"); 
        }

        return mav;
    }

    @GetMapping("requestList")
    public ModelAndView requestList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("myteam/requestList");
        HttpSession session = req.getSession();
        
        long teamCode = setTeamInfoAndRole(session, mav);
        
        if (teamCode == -1) {
            return new ModelAndView("redirect:/team/list?msg=noteam");
        }

        SessionInfo info = (SessionInfo) session.getAttribute("member");
        int myRoleLevel = service.readMemberRoleLevel(info.getMember_code(), teamCode);
        
        if (myRoleLevel < 10) {
            return new ModelAndView("redirect:/myteam/main?msg=unauthorized");
        }

        List<JoinRequestDTO> list = service.listJoinRequest(teamCode);
        mav.addObject("list", list);

        return mav;
    }
    
    @PostMapping("processJoin")
    public ModelAndView processJoin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            long teamCode = Long.parseLong(req.getParameter("team_code"));
            long memberCode = Long.parseLong(req.getParameter("member_code"));
            int status = Integer.parseInt(req.getParameter("status"));
            String preferredPosition = req.getParameter("preferred_position");

            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("team_code", teamCode);
            paramMap.put("member_code", memberCode);
            paramMap.put("position", preferredPosition);

            if (status == 2) {
                service.processJoinAccept(paramMap);
            } else {
                service.processJoinReject(paramMap);
            }

            return new ModelAndView("redirect:/myteam/requestList");

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/myteam/requestList?error=true");
        }
    }

    @GetMapping("manage/match")
    public ModelAndView manageMatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("myteam/manage/match");
        HttpSession session = req.getSession();

        long teamCode = setTeamInfoAndRole(session, mav);
        if (teamCode == -1) {
            return new ModelAndView("redirect:/team/list?msg=noteam");
        }

        SessionInfo info = (SessionInfo) session.getAttribute("member");
        int myRoleLevel = service.readMemberRoleLevel(info.getMember_code(), teamCode);
        
        if (myRoleLevel < 10) return new ModelAndView("redirect:/myteam/main?msg=unauthorized");

        return mav;
    }
    
    @GetMapping("squad")
    public ModelAndView squad(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("myteam/squad");
        HttpSession session = req.getSession();

        long teamCode = setTeamInfoAndRole(session, mav);
        
        if (teamCode == -1) {
            return new ModelAndView("redirect:/team/list?msg=noteam");
        }

        try {
            Map<String, Object> map = new HashMap<>();
            map.put("team_code", teamCode);

            map.put("start", 1);
            map.put("end", 100); 
            map.put("keyword", ""); 

            List<TeamMemberDTO> list = service.listTeamMember(map);
            mav.addObject("list", list);
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        return mav;
    }
    
    @PostMapping("updateMember")
	public ModelAndView updateMember(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {

			String teamCode = req.getParameter("team_code"); 
			String memberCode = req.getParameter("member_code");
			String position = req.getParameter("position");
			String backNumber = req.getParameter("back_number");

			String roleLevel = req.getParameter("role_level");

			Map<String, Object> map = new HashMap<>();
			map.put("team_code", teamCode);
			map.put("member_code", memberCode);
			map.put("position", position);
			map.put("back_number", backNumber);

			map.put("role_level", roleLevel); 

			service.updateMemberRole(map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/myteam/squad");
	}
    
}