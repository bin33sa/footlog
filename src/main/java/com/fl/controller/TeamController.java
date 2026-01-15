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
            mav.addObject("myTeams", myTeams); // 변수명 myTeam -> myTeams (복수형)
        }
        return mav;
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
        
        ModelAndView mav = new ModelAndView("team/teamList"); // JSP 조각 반환
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
        
        // 상세 정보 가져오기 (좋아요 여부 포함)
        TeamDTO dto = service.readTeam(team_code, member_code);
        
        if(dto == null) {
            return new ModelAndView("redirect:/team/list");
        }

        ModelAndView mav = new ModelAndView("team/view");
        mav.addObject("dto", dto);
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
    
    // [핵심] 좋아요 등록/취소 AJAX 처리
    @ResponseBody
    @PostMapping("insertTeamLike")
    public Map<String, Object> insertTeamLike(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, Object> model = new HashMap<>();
        
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        
        // 1. 로그인 체크
        if (info == null) {
            model.put("state", "login_required");
            return model;
        }
        
        try {
            long team_code = Long.parseLong(req.getParameter("team_code"));
            String user_Liked = req.getParameter("user_Liked"); // "true" or "false"
            
            Map<String, Object> map = new HashMap<>();
            map.put("team_code", team_code);
            map.put("member_code", info.getMember_code());
            map.put("user_Liked", user_Liked); // 서비스에서 처리하도록 전달
            
            // 2. 서비스 호출 (삭제 or 추가 결정은 서비스에서)
            service.insertTeamLike(map);
            
            // 3. 갱신된 좋아요 개수 가져오기
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