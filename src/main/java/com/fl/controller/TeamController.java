package com.fl.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.PageResult;
import com.fl.model.SessionInfo;
import com.fl.model.TeamDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.annotation.ResponseBody;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.TeamService;
import com.fl.service.TeamServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/team/*")
public class TeamController {
    
    private TeamService service = new TeamServiceImpl();
    
    // 리스트 페이지
    @RequestMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        long member_code = (info != null) ? info.getMember_code() : 0;

        int pageNo = 1;
        try {
            pageNo = Integer.parseInt(req.getParameter("pageNo"));
        } catch (NumberFormatException e) { }
        
        int size = 4;
        String keyword = req.getParameter("keyword");
        String sort = req.getParameter("sort");
        
        PageResult<TeamDTO> result = service.listTeam(pageNo, size, keyword, sort, member_code); 
        
        ModelAndView mav = new ModelAndView("team/list");
        mav.addObject("list", result.getList());
        mav.addObject("pageNo", result.getPageNo());
        mav.addObject("totalPage", result.getTotalPage());
        mav.addObject("keyword", keyword);
        mav.addObject("sort", sort);
        
        if(member_code != 0) {
            List<TeamDTO> myTeams = service.readMyTeam(member_code);
            mav.addObject("myTeams", myTeams); 
        }
        return mav;
    }
    
    // 헤더전용) 내 구단 가기 모달 
    @GetMapping("myList")
    public void myList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        // 1. 데이터 가져오기
        List<TeamDTO> list = null;
        if(info != null) {
            list = service.readMyTeam(info.getMember_code());
        }
        
        // 2. JSON 직접 만들기 (StringBuilder 사용)
        StringBuilder sb = new StringBuilder();
        sb.append("["); // 리스트 시작
        
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                TeamDTO dto = list.get(i);
                
                sb.append("{");
                // 숫자값
                sb.append("\"team_code\": " + dto.getTeam_code() + ",");
                
                // 문자열값 (특수문자 " 처리)
                String name = (dto.getTeam_name() == null) ? "" : dto.getTeam_name().replace("\"", "\\\"");
                sb.append("\"team_name\": \"" + name + "\",");
                
                String region = (dto.getRegion() == null) ? "" : dto.getRegion().replace("\"", "\\\"");
                sb.append("\"region\": \"" + region + "\",");
                
                String emblem = (dto.getEmblem_image() == null) ? "" : dto.getEmblem_image().replace("\"", "\\\"");
                sb.append("\"emblem_image\": \"" + emblem + "\"");
                
                sb.append("}");
                
                // 마지막 데이터가 아니면 콤마(,) 추가
                if (i < list.size() - 1) {
                    sb.append(",");
                }
            }
        }
        
        sb.append("]"); // 리스트 끝
        
        // 3. 응답 전송
        resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().write(sb.toString());
    }
    
    
    // 더보기(AJAX)
    @RequestMapping("listMore")
    public ModelAndView listMore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        long member_code = (info != null) ? info.getMember_code() : 0;

        int pageNo = Integer.parseInt(req.getParameter("pageNo"));
        int size = 4;
        String keyword = req.getParameter("keyword");
        String sort = req.getParameter("sort");
        
        PageResult<TeamDTO> result = service.listTeam(pageNo, size, keyword, sort, member_code);
        
        ModelAndView mav = new ModelAndView("team/teamList");
        mav.addObject("list", result.getList());
        mav.addObject("pageNo", result.getPageNo());
        mav.addObject("totalPage", result.getTotalPage());
        
        return mav;
    }
    
    // 상세 보기
    @GetMapping("view")
    public ModelAndView view(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        long member_code = (info != null) ? info.getMember_code() : 0;
        long team_code = Long.parseLong(req.getParameter("team_code"));
        
        TeamDTO dto = service.readTeam(team_code, member_code);
        
        if(dto == null || dto.getStatus() == 0) {
            return new ModelAndView("redirect:/team/list");
        }

        ModelAndView mav = new ModelAndView("team/view");
        mav.addObject("dto", dto);

        boolean isLeader = service.isLeader(team_code, member_code);
        mav.addObject("isLeader", isLeader);

        // 가입 상태 확인 (필수 유지)
        if(member_code != 0) {
            int joinStatus = service.checkJoinStatus(team_code, member_code);
            mav.addObject("joinStatus", joinStatus);
        }
        
        return mav;
    }
    
    // 구단 생성 폼
    @GetMapping("write")
    public ModelAndView write(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        return new ModelAndView("team/write");
    }
    
    // 구단 생성 처리
    @PostMapping("write")
    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        String root = session.getServletContext().getRealPath("/");
        String path = root + "uploads" + File.separator + "team";
        
        File f = new File(path);
        if(!f.exists()) f.mkdirs();

        TeamDTO dto = new TeamDTO();
        try {
            dto.setTeam_name(req.getParameter("team_name"));
            dto.setRegion(req.getParameter("region"));
            dto.setDescription(req.getParameter("description"));
            dto.setContact_number(req.getParameter("contact_number"));
            dto.setIntro_video_url(req.getParameter("intro_video_url"));
            dto.setTeam_url("pending");
            
            Part part = req.getPart("uploadFile");
            if(part != null && part.getSize() > 0) {
                String originalFilename = part.getSubmittedFileName();
                String ext = originalFilename.substring(originalFilename.lastIndexOf("."));
                String saveFilename = System.currentTimeMillis() + "_" + (int)(Math.random() * 1000) + ext;
                part.write(path + File.separator + saveFilename);
                dto.setEmblem_image(saveFilename);
            }

            service.insertTeam(dto, info.getMember_code());

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("team/write");
        }

        return new ModelAndView("redirect:/team/list");
    }
    
    // 가입 신청 기능 (필수 유지)
    @ResponseBody
    @PostMapping("joinRequest")
    public Map<String, Object> joinRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> model = new HashMap<>();
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if(info == null) {
            model.put("state", "login_required");
            return model;
        }
        
        try {
            long team_code = Long.parseLong(req.getParameter("team_code"));
            long member_code = info.getMember_code();

            // 1. 이미 가입했거나 신청했는지 미리 확인
            int currentStatus = service.checkJoinStatus(team_code, member_code);
            
            if(currentStatus != 0) { 
                model.put("state", "duplicate");
                return model;
            }

            // 2. 가입 신청 insert 실행
            Map<String, Object> map = new HashMap<>();
            map.put("team_code", team_code);
            map.put("member_code", member_code);
            service.insertJoinRequest(map);
            
            model.put("state", "true");
        } catch (Exception e) {
            e.printStackTrace();
            model.put("state", "error");
        }
        return model;
    }
    
  

    // 구단 삭제 처리
    @GetMapping("delete")
    public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        long team_code = Long.parseLong(req.getParameter("team_code"));
        
        if(info != null && service.isLeader(team_code, info.getMember_code())) {
            service.deleteTeam(team_code);
        }
        
        return new ModelAndView("redirect:/team/list");
    }
    
    // 좋아요 처리
    @ResponseBody
    @PostMapping("insertTeamLike")
    public Map<String, Object> insertTeamLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> model = new HashMap<>();
        
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        if (info == null) {
            model.put("state", "login_required");
            return model;
        }
        
        try {
            long team_code = Long.parseLong(req.getParameter("team_code"));
            String user_Liked = req.getParameter("user_Liked");
            
            Map<String, Object> map = new HashMap<>();
            map.put("team_code", team_code);
            map.put("member_code", info.getMember_code());
            map.put("user_Liked", user_Liked);
            
            service.insertTeamLike(map);
            int teamLikeCount = service.teamLikeCount(team_code);
            
            model.put("state", "true");
            model.put("teamLikeCount", teamLikeCount);
            
        } catch (Exception e) {
            e.printStackTrace();
            model.put("state", "false");
        }
        
        return model;
    }
}