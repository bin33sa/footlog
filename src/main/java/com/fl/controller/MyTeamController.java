package com.fl.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.GalleryDTO;
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
import com.fl.util.FileManager;
import com.fl.util.MyMultipartFile;
import com.fl.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/myteam/*")
public class MyTeamController {

    private MyTeamService service = new MyTeamServiceImpl();
    private FileManager fileManager = new FileManager();
    private MyUtil util = new MyUtil();
    
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
            
  
            mav.addObject("myRoleLevel", myRoleLevel);
            mav.addObject("myTeamName", currentTeam.getTeam_name());
            mav.addObject("myTeam", currentTeam); 
            mav.addObject("teamCode", teamCode);
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

        session.setAttribute("currentTeamCode", teamCode);

        mav.addObject("teamCode", teamCode);

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

    @GetMapping("match")
    public ModelAndView manageMatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("myteam/match");
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
    
    @PostMapping("updateSquad")
	public ModelAndView updateSquad(HttpServletRequest req, HttpServletResponse resp) {

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
    
    @GetMapping("teamUpdate") 
    public ModelAndView teamUpdateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("myteam/teamUpdate"); 
        
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
     
        try {
            String teamCodeStr = req.getParameter("teamCode");
            if(teamCodeStr == null || teamCodeStr.isEmpty()) {
                 return new ModelAndView("redirect:/myteam/main");
            }
            long teamCode = Long.parseLong(teamCodeStr);

            Map<String, Object> map = new HashMap<>();
            map.put("team_code", teamCode);
            map.put("member_code", info.getMember_code());
            
            TeamMemberDTO myStatus = service.readMyTeamStatus(map);
            
            if(myStatus == null) return new ModelAndView("redirect:/myteam/main?teamCode=" + teamCode);

            mav.addObject("myRoleLevel", myStatus.getRole_level());

            TeamDTO teamInfo = service.readTeamInfo(teamCode);
            mav.addObject("dto", teamInfo); 
            
            mav.addObject("teamCode", teamCode);
            mav.addObject("mode", "update");

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("redirect:/myteam/main");
        }
        return mav;
    }

 
    @PostMapping("teamUpdate")
    public ModelAndView teamUpdateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();

        String teamCodeStr = req.getParameter("team_code");
        String teamName = req.getParameter("team_name");
        String description = req.getParameter("description");
        String region = req.getParameter("region");

        if(teamCodeStr == null || teamCodeStr.isEmpty()) {
            return new ModelAndView("redirect:/myteam/main");
        }
        long teamCode = Long.parseLong(teamCodeStr);

        TeamDTO dto = new TeamDTO();
        dto.setTeam_code(teamCode);
        dto.setTeam_name(teamName);
        dto.setDescription(description);
        dto.setRegion(region);

        String root = session.getServletContext().getRealPath("/");
        String pathname = root + "uploads" + File.separator + "team"; // 저장 폴더: uploads/team

        try {
            TeamDTO oldDto = service.readTeamInfo(teamCode);
            if(oldDto == null) {
                return new ModelAndView("redirect:/myteam/main");
            }

            Part p = req.getPart("selectFile"); 
            MyMultipartFile mp = fileManager.doFileUpload(p, pathname);
            
            if(mp != null) {
                String saveFilename = mp.getSaveFilename();
                dto.setEmblem_image(saveFilename); 

                if(oldDto.getEmblem_image() != null && oldDto.getEmblem_image().length() != 0) {
                    fileManager.doFiledelete(pathname, oldDto.getEmblem_image());
                }
            } else {
                dto.setEmblem_image(oldDto.getEmblem_image());
            }

            service.updateTeamInfo(dto);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/myteam/main?teamCode=" + teamCode);
    }
    
    @GetMapping("deleteMember")
    public ModelAndView deleteMember(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        String teamCodeStr = req.getParameter("teamCode");
        String memberCodeStr = req.getParameter("memberCode");

        try {
            if(teamCodeStr == null || memberCodeStr == null) {
                return new ModelAndView("redirect:/myteam/main");
            }

            long teamCode = Long.parseLong(teamCodeStr);
            long targetMemberCode = Long.parseLong(memberCodeStr); 
            long myMemberCode = info.getMember_code();            

            if(targetMemberCode == myMemberCode) {
                ModelAndView mav = new ModelAndView("redirect:/myteam/squad?teamCode=" + teamCode);
                mav.addObject("msg", "자기 자신은 내보낼 수 없습니다. '구단 탈퇴' 메뉴를 이용하세요.");
                return mav;
            }

            int myRole = service.readMemberRoleLevel(myMemberCode, teamCode);
            int targetRole = service.readMemberRoleLevel(targetMemberCode, teamCode);

            if(targetRole >= myRole) {
                ModelAndView mav = new ModelAndView("redirect:/myteam/squad?teamCode=" + teamCode);
                return mav;
            }

            Map<String, Object> map = new HashMap<>();
            map.put("team_code", teamCode);
            map.put("member_code", targetMemberCode);

            service.leaveTeam(map);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/myteam/squad?teamCode=" + teamCodeStr);
    }
    
    @GetMapping("selfLeave")
    public ModelAndView selfLeave(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if(info == null) return new ModelAndView("redirect:/member/login");

        String teamCodeStr = req.getParameter("teamCode");
        if(teamCodeStr == null) return new ModelAndView("redirect:/myteam/main");

        long teamCode = Long.parseLong(teamCodeStr);
        long myMemberCode = info.getMember_code();

        try {
            int myRole = service.readMemberRoleLevel(myMemberCode, teamCode);
            if(myRole >= 99) {
                 return new ModelAndView("redirect:/myteam/main?teamCode=" + teamCode); 
            }

            Map<String, Object> map = new HashMap<>();
            map.put("team_code", teamCode);
            map.put("member_code", myMemberCode);

            service.leaveTeam(map);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/"); 
    }
    
 	@GetMapping("gallery")
 	public ModelAndView gallery(HttpServletRequest req, HttpServletResponse resp) throws Exception {
 		ModelAndView mav = new ModelAndView("myteam/gallery"); 

 		HttpSession session = req.getSession();
 		SessionInfo info = (SessionInfo) session.getAttribute("member");

 		String teamCodeStr = req.getParameter("teamCode");
 		if (teamCodeStr == null) {
 			return new ModelAndView("redirect:/myteam/main");
 		}
 		long teamCode = Long.parseLong(teamCodeStr);

 		String page = req.getParameter("page");
 		int current_page = 1;
 		if (page != null) {
 			try {
 				current_page = Integer.parseInt(page);
 			} catch (Exception e) {
 			}
 		}

 		int rows = 12; 
 		
 		Map<String, Object> map = new HashMap<>();
 		map.put("team_code", teamCode);

 		int dataCount = service.galleryDataCount(map); 

 		int total_page = util.pageCount(dataCount, rows);
 		
 		if (current_page > total_page) {
 			current_page = total_page;
 		}

 		int offset = (current_page - 1) * rows;
 		if(offset < 0) offset = 0;

 		map.put("offset", offset);
 		map.put("size", rows);

 		List<GalleryDTO> list = service.listGallery(map); 

 		String cp = req.getContextPath();
 		String listUrl = cp + "/myteam/gallery?teamCode=" + teamCode;
 		
 		String paging = util.pagingUrl(current_page, total_page, listUrl);

 		mav.addObject("list", list);
 		mav.addObject("dataCount", dataCount);
 		mav.addObject("page", current_page);
 		mav.addObject("total_page", total_page);
 		mav.addObject("paging", paging);
 		mav.addObject("teamCode", teamCode);
 		
 		if(info != null) {
 			int myRoleLevel = service.readMemberRoleLevel(info.getMember_code(), teamCode);
 			mav.addObject("myRoleLevel", myRoleLevel);
 		}

 		return mav;
 	}
    
 	@GetMapping("update")
	public ModelAndView profileUpdate(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		ModelAndView mav = new ModelAndView("myteam/update");

		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		String teamCodeStr = req.getParameter("teamCode");
		if (teamCodeStr == null || teamCodeStr.isEmpty()) {
			return new ModelAndView("redirect:/myteam/main");
		}
		long teamCode = Long.parseLong(teamCodeStr);

		Map<String, Object> map = new HashMap<>();
		map.put("team_code", teamCode);
		map.put("member_code", info.getMember_code());

		TeamMemberDTO dto = service.readMyTeamStatus(map);
		
		if (dto == null) {
			return new ModelAndView("redirect:/myteam/main?teamCode=" + teamCode);
		}

		mav.addObject("dto", dto);
		mav.addObject("teamCode", teamCode);
		mav.addObject("myRoleLevel", dto.getRole_level());

		return mav;
	}

 	@PostMapping("update")
	public ModelAndView profileUpdateSubmit(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		String teamCodeStr = req.getParameter("teamCode");
		long teamCode = Long.parseLong(teamCodeStr);
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "profile";
		
		FileManager fileManager = new FileManager();
		
		try {
			Part part = req.getPart("selectFile");
			MyMultipartFile uploadedFile = fileManager.doFileUpload(part, pathname);
			
			if (uploadedFile != null) {
				TeamMemberDTO dto = new TeamMemberDTO();
				dto.setTeam_code(teamCode);
				dto.setMember_code(info.getMember_code());
				
				String saveFilename = uploadedFile.getSaveFilename();
				dto.setProfile_image(saveFilename);
				
				service.updateTeamMember(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ModelAndView("redirect:/myteam/main?teamCode=" + teamCode);
	}
 	
 	
}