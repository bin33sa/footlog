package com.fl.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.FileDTO;
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
    
    private long setTeamInfoAndRole(HttpServletRequest req, HttpSession session, ModelAndView mav) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) return -1;
            
            long memberCode = info.getMember_code();

            List<TeamDTO> myTeams = service.listMyTeam(memberCode);
            if (myTeams == null || myTeams.isEmpty()) return -1;

            long currentTeamCode = -1;
            String paramCode = req.getParameter("teamCode");
            
            if (paramCode != null && !paramCode.isEmpty()) {
                try {
                    currentTeamCode = Long.parseLong(paramCode);
                } catch (NumberFormatException e) {
                    currentTeamCode = -1;
                }
            }
            
            if (currentTeamCode == -1) {
                Long sessionTeamCode = (Long) session.getAttribute("currentTeamCode");
                if (sessionTeamCode != null) {
                    currentTeamCode = sessionTeamCode;
                }
            }

            TeamDTO currentTeam = null;
            int currentIndex = 0;
            boolean found = false;

            for(int i=0; i<myTeams.size(); i++) {
                if(myTeams.get(i).getTeam_code() == currentTeamCode) {
                    currentTeam = myTeams.get(i);
                    currentIndex = i;
                    found = true;
                    break;
                }
            }

            if(!found) {
                currentTeam = myTeams.get(0);
                currentTeamCode = currentTeam.getTeam_code();
                currentIndex = 0;
            }
            
            session.setAttribute("currentTeamCode", currentTeamCode);

            long prevTeamCode = -1;
            long nextTeamCode = -1;
            int teamCount = myTeams.size();

            if (teamCount > 1) {
                int prevIndex = (currentIndex - 1 + teamCount) % teamCount;
                prevTeamCode = myTeams.get(prevIndex).getTeam_code();

                int nextIndex = (currentIndex + 1) % teamCount;
                nextTeamCode = myTeams.get(nextIndex).getTeam_code();
            }

            int myRoleLevel = service.readMemberRoleLevel(memberCode, currentTeamCode);
            
            mav.addObject("team_code", currentTeamCode);
            mav.addObject("teamCode", currentTeamCode);
            mav.addObject("myRoleLevel", myRoleLevel);
            mav.addObject("myTeamName", currentTeam.getTeam_name());
            mav.addObject("myTeam", currentTeam);
            
            mav.addObject("myTeamsCount", teamCount);
            if (teamCount > 1) {
                mav.addObject("prevTeamCode", prevTeamCode);
                mav.addObject("nextTeamCode", nextTeamCode);
            }

            return currentTeamCode;

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    @GetMapping("main")
    public ModelAndView main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("myteam/main");
        HttpSession session = req.getSession();

        long teamCode = setTeamInfoAndRole(req, session, mav);

        if (teamCode == -1) {
            return new ModelAndView("redirect:/team/list?msg=noteam"); 
        }

        return mav;
    }

    @GetMapping("requestList")
    public ModelAndView requestList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("myteam/requestList");
        HttpSession session = req.getSession();
        
        long teamCode = setTeamInfoAndRole(req, session, mav);
        
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

        long teamCode = setTeamInfoAndRole(req, session, mav);
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

        long teamCode = setTeamInfoAndRole(req, session, mav);
        
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
        
        long teamCode = setTeamInfoAndRole(req, session, mav);
        if(teamCode == -1) return new ModelAndView("redirect:/myteam/main");

        SessionInfo info = (SessionInfo) session.getAttribute("member");
     
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("team_code", teamCode);
            map.put("member_code", info.getMember_code());
            
            TeamMemberDTO myStatus = service.readMyTeamStatus(map);
            if(myStatus == null) return new ModelAndView("redirect:/myteam/main");

            if(myStatus.getRole_level() < 10) {
                 return new ModelAndView("redirect:/myteam/main?msg=unauthorized");
            }

            TeamDTO teamInfo = service.readTeamInfo(teamCode);
            mav.addObject("dto", teamInfo); 
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
        String pathname = root + "uploads" + File.separator + "team"; 

        try {
            TeamDTO oldDto = service.readTeamInfo(teamCode);
            if(oldDto == null) return new ModelAndView("redirect:/myteam/main");

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
                mav.addObject("msg", "self_error");
                return mav;
            }

            int myRole = service.readMemberRoleLevel(myMemberCode, teamCode);
            int targetRole = service.readMemberRoleLevel(targetMemberCode, teamCode);

            if(targetRole >= myRole) {
                return new ModelAndView("redirect:/myteam/squad?teamCode=" + teamCode);
            }

            Map<String, Object> map = new HashMap<>();
            map.put("team_code", teamCode);
            map.put("member_code", targetMemberCode);

            service.kickMember(map); 

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

        long teamCode = setTeamInfoAndRole(req, session, mav);
        if (teamCode == -1) return new ModelAndView("redirect:/myteam/main");

        String page = req.getParameter("page");
        int current_page = 1;
        if (page != null) {
            try {
                current_page = Integer.parseInt(page);
            } catch (Exception e) { }
        }

        int rows = 12; 
        
        Map<String, Object> map = new HashMap<>();
        map.put("team_code", teamCode);

        int dataCount = service.galleryDataCount(map); 

        int total_page = util.pageCount(dataCount, rows);
        if (current_page > total_page) current_page = total_page;

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
        
        return mav;
    }
    
    @GetMapping("update")
    public ModelAndView profileUpdate(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView mav = new ModelAndView("myteam/update");
        HttpSession session = req.getSession();

        long teamCode = setTeamInfoAndRole(req, session, mav);
        if(teamCode == -1) return new ModelAndView("redirect:/myteam/main");
        
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        Map<String, Object> map = new HashMap<>();
        map.put("team_code", teamCode);
        map.put("member_code", info.getMember_code()); 

        TeamMemberDTO dto = service.readMyTeamStatus(map);
        if (dto == null) return new ModelAndView("redirect:/myteam/main?teamCode=" + teamCode);

        mav.addObject("dto", dto);
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
    
    @GetMapping("gallery_write")
    public ModelAndView galleryWriteForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        ModelAndView mav = new ModelAndView("myteam/gallery_write");
        HttpSession session = req.getSession();

        long teamCode = setTeamInfoAndRole(req, session, mav);
        if (teamCode == -1) return new ModelAndView("redirect:/myteam/main");

        mav.addObject("mode", "write");
        return mav;
    }

    @PostMapping("gallery_write")
    public ModelAndView galleryWriteSubmit(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) return new ModelAndView("redirect:/member/login");

        String teamCodeStr = req.getParameter("teamCode");
        long teamCode = Long.parseLong(teamCodeStr);

        String root = session.getServletContext().getRealPath("/");
        String pathname = root + "uploads" + File.separator + "gallery";

        try {
            GalleryDTO dto = new GalleryDTO();
            dto.setTeam_code(teamCode);
            dto.setMember_code(info.getMember_code());
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));

            Part part = req.getPart("selectFile");
            MyMultipartFile uploadedFile = fileManager.doFileUpload(part, pathname);

            if (uploadedFile != null) {
                String saveFilename = uploadedFile.getSaveFilename();
                String originalFilename = uploadedFile.getOriginalFilename();
                long fileSize = uploadedFile.getSize();

                dto.setTitle_image(saveFilename); 
                
                FileDTO fileDto = new FileDTO();
                fileDto.setFile_name(originalFilename);      
                fileDto.setFile_server_name(saveFilename);    
                fileDto.setFile_size(fileSize);               
                
                List<FileDTO> listFile = new ArrayList<>();
                listFile.add(fileDto);
                
                dto.setListFile(listFile);
            }
            service.insertGallery(dto);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/myteam/gallery?teamCode=" + teamCode);
    }
}