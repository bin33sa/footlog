package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.MatchApplyDTO;
import com.fl.model.MatchDTO;
import com.fl.model.SessionInfo;
import com.fl.model.StadiumDTO;
import com.fl.model.TeamDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.annotation.ResponseBody;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.MatchService;
import com.fl.service.MatchServiceImpl;
import com.fl.service.StadiumService;
import com.fl.service.StadiumServiceImpl;
import com.fl.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@Controller
@RequestMapping("/match/*")
public class MatchController {
	private MatchService service = new MatchServiceImpl();
	private StadiumService stadiumservice = new StadiumServiceImpl();
	private MyUtil util = new MyUtil();
	
	@GetMapping("list")
	public ModelAndView matchList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("match/list");
		HttpSession session  = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		if(info!=null) {
			List<TeamDTO> myTeams = service.listUserTeams(info.getMember_code());
			mav.addObject("myTeams", myTeams);
		}
		
		return mav;
	}
	
	@GetMapping("listAjax")
	public ModelAndView matchListAjax(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("match/listAjax");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		
		try {
			String page = req.getParameter("page");
			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			//검색
			String kwd = req.getParameter("kwd");
			String region = req.getParameter("region");
			String match_date = req.getParameter("matchDate");
			
			if(kwd == null) {
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			service.updateExpiredMatchStatus();
			
			int size = 6;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("kwd", kwd);
			map.put("region", region);
			map.put("match_date", match_date);
			
			dataCount = service.dataCount(map);
			
			total_page = util.pageCount(dataCount, size);
			current_page = Math.min(total_page, current_page);
			
			int offset = (current_page - 1 ) * size;
			if(offset<0) offset=0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MatchDTO> list = service.listMatch(map);
			
			if(info!=null) {
				List<TeamDTO> myTeams = service.listUserTeams(info.getMember_code());
				mav.addObject("myTeams", myTeams);
			}
			
			String query = "";
			String cp = req.getContextPath();
			String articleUrl = cp + "/match/article?page=" + current_page;
			if(! kwd.isBlank()) {
				query = "&kwd="+util.encodeUrl(kwd);
				articleUrl += "&" + query;
			}
			
			mav.addObject("list", list);
			mav.addObject("size", size);
			mav.addObject("dataCount", dataCount);
			mav.addObject("total_page", total_page);
			mav.addObject("page", current_page);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("kwd", kwd);

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	
	
	@GetMapping("article")
	public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String page = req.getParameter("page");
		String query = "page="+page;
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			long match_code = Long.parseLong(req.getParameter("match_code"));
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			
			if(schType ==null) {
				schType = "";
				kwd = "";
			}
			kwd = util.decodeUrl(kwd);
			
			if(!kwd.isBlank()) {
				query += "&schType="+schType+"&kwd="+util.encodeUrl(kwd);
			}
			
			service.updateHitCount(match_code);
			
			MatchDTO dto = service.findById(match_code);
			if(dto==null) {
				return new ModelAndView("redirect:/match/list?"+query);
			}
			
			dto.setContent(util.htmlSymbols(dto.getContent()));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType",schType);
			map.put("kwd",kwd);
			map.put("match_code",match_code);
			
			List<MatchApplyDTO> applicantList = service.listApplicant(map);
			
			
			ModelAndView mav = new ModelAndView("match/article");
			
			
			long myTeamRole = 0;
			
			if(info != null) {
				map.put("member_code",info.getMember_code());
				
				Map<String, Object> roleMap = new HashMap<String, Object>();
				roleMap.put("member_code", info.getMember_code());
				roleMap.put("team_code", dto.getHome_code());
				
				myTeamRole = service.getUserTeamRole(roleMap);
				
				List<TeamDTO> myTeams = service.listUserTeams(info.getMember_code());
				mav.addObject("myTeams", myTeams);
            }else {
            	map.put("member_code",0);
            }
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("applicantList", applicantList);
			mav.addObject("myTeamRole", myTeamRole);
			
			return mav;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/match/list?"+query);
	}
	
	@GetMapping("write")
	public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("match/write");
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		try {
			
			List<TeamDTO> myTeams = service.listUserTeams(info.getMember_code());
			boolean hasPermission = false;
			
			if(myTeams!=null) {
				for(TeamDTO team:myTeams) {
					if(team.getRole_level()>=10) {
						hasPermission = true;
						break;
					}
				}
			}
			
			List<StadiumDTO> list = stadiumservice.listStadiumAll();
			mav.addObject("stadiumList", list);
			mav.addObject("myTeams", myTeams);
			mav.addObject("mode", "write");
			
			return mav;
			
		} catch (Exception e) {
		e.printStackTrace();
		}
		return mav;
	}
	
	@ResponseBody
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			MatchDTO dto = new MatchDTO();
			
			long home_code = Long.parseLong(req.getParameter("home_code"));
			
			dto.setHome_code(home_code);
			
			List<TeamDTO> myTeams = service.listUserTeams(info.getMember_code());
			boolean hasPermission = false;
			
			if(myTeams!=null) {
				for(TeamDTO team:myTeams) {
					if(team.getRole_level()>=10) {
						hasPermission = true;
						break;
					}
				}
			}
			
			//long memberCode = Long.parseLong(info.getMember_code());
			dto.setMember_code(info.getMember_code());
			
			dto.setTitle(req.getParameter("title"));
			dto.setStadium_code(Integer.parseInt(req.getParameter("stadium_code")));
			dto.setContent(req.getParameter("content"));
			dto.setMatch_date(req.getParameter("match_date"));
			dto.setMatchType(req.getParameter("matchType"));
			dto.setGender(req.getParameter("gender"));
			dto.setFee(Long.parseLong(req.getParameter("fee")));
			dto.setMatchLevel(req.getParameter("matchLevel"));
		
			service.insertMatch(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/match/list");
	}
	
	
	@GetMapping("delete")
	public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
			
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String page = req.getParameter("page");
		String query = "page=" + page;
		
		try {
			long match_code = Long.parseLong(req.getParameter("match_code"));
			
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType==null) {
				schType="";
				kwd="";
			}
			kwd = util.decodeUrl(kwd);
			
			if(!kwd.isBlank()) {
				query += "&schType="+schType+"&kwd="+util.decodeUrl(kwd);
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("match_code", match_code);
			map.put("member_code", info.getMember_code());
			map.put("userLevel", info.getRole_level());
			
			service.deleteMatch(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/match/list?"+query);
	}
	
	@GetMapping("update")
	public ModelAndView update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String page = req.getParameter("page");
		
		try {
			long match_code = Long.parseLong(req.getParameter("match_code"));
			MatchDTO dto = service.findById(match_code);
			
			long member_code = info.getMember_code();
			List<TeamDTO> myTeams = service.listUserTeams(member_code);
			List<StadiumDTO> list = stadiumservice.listStadiumAll();
			
			ModelAndView mav = new ModelAndView("match/write");
			
			mav.addObject("page", page);
			mav.addObject("dto", dto);
			mav.addObject("mode", "update");
			mav.addObject("stadiumList", list);
			mav.addObject("myTeams", myTeams);
			
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/match/list?page="+page);
	}
	
	@PostMapping("update")
	public ModelAndView updateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String page = req.getParameter("page");
		
		try {
			MatchDTO dto = new MatchDTO();
			
			dto.setMatch_code(Long.parseLong(req.getParameter("match_code")));
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			dto.setMatch_date(req.getParameter("match_date"));
			dto.setHome_code(Long.parseLong(req.getParameter("home_code")));
			dto.setFee(Long.parseLong(req.getParameter("fee")));
			dto.setGender(req.getParameter("gender"));
			dto.setMatchLevel(req.getParameter("matchLevel"));
			dto.setMatchType(req.getParameter("matchType"));
			dto.setStatus(req.getParameter("status"));
			dto.setStadium_code(Integer.parseInt(req.getParameter("stadium_code")));
			dto.setMember_code(info.getMember_code());
			
			service.updateMatch(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/match/list?page="+page);
	}
	
	@ResponseBody
	@PostMapping("insertApply")
	public Map<String, Object> insertApply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> model = new HashMap<String, Object>();
		
		try {
			MatchApplyDTO dto = new MatchApplyDTO();
			
			long match_code = Long.parseLong(req.getParameter("match_code"));
			long team_code = Long.parseLong(req.getParameter("team_code"));
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("match_code", match_code);
			map.put("team_code", team_code);
			
			int count = service.countMatchApply(map);
			
			if(count>0) {
				model.put("state", "duplicated");
				return model;
			}
			
			dto.setMatch_code(match_code);
			dto.setTeam_code(team_code);
			dto.setMember_code(info.getMember_code());
			
			
			service.insertMatchApply(dto);
			
			model.put("state", "true");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return model;
	}
	
	@ResponseBody
	@PostMapping("confirmMatch")
	public Map<String, Object> confirmMatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			
			if(info==null) {
				map.put("state","login_required");
			}
			
			long match_code = Long.parseLong(req.getParameter("match_code"));
			long team_code = Long.parseLong(req.getParameter("team_code"));
			
			map.put("match_code", match_code);
			map.put("away_code", team_code);
			map.put("team_code", team_code);
			map.put("post_status", "매칭완료");
		
		    service.updateMatchStatus(map);
			

			result.put("state", "true");
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("state","false");
		}
		return result;
	}
	
	@GetMapping("myMatch")
	public ModelAndView myMatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    ModelAndView mav = new ModelAndView("match/myMatch");
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");

	    if (info == null) {
	        return new ModelAndView("redirect:/member/login");
	    }

	    try {
	        String page = req.getParameter("page");
	        int current_page = 1;
	        if (page != null) {
	            current_page = Integer.parseInt(page);
	        }

	        String tab = req.getParameter("tab");
	        if (tab == null || tab.isBlank()) {
	            tab = "future"; 
	        }

	        String kwd = req.getParameter("kwd");
	        String match_date = req.getParameter("match_date");
	        String region = req.getParameter("region");

	        if (kwd == null) kwd = "";
	        kwd = util.decodeUrl(kwd);

	        int size = 5; 
	        int dataCount = 0;

	        Map<String, Object> map = new HashMap<>();
	        map.put("member_code", info.getMember_code());
	        map.put("tab", tab);     
	        map.put("kwd", kwd);
	        map.put("match_date", match_date);
	        map.put("region", region);

	        dataCount = service.dataCountMyMatch(map); 

	        int total_page = util.pageCount(dataCount, size);
	        if (current_page > total_page) current_page = total_page;

	        int offset = (current_page - 1) * size;
	        if (offset < 0) offset = 0;

	        map.put("offset", offset);
	        map.put("size", size);

	        List<MatchDTO> list = service.listMyMatch(map); 

	        String cp = req.getContextPath();
	        String listUrl = cp + "/match/myMatch?tab=" + tab; 

	        String query = "";
	        if (!kwd.isBlank()) query += "&kwd=" + util.encodeUrl(kwd);
	        if (match_date != null && !match_date.isBlank()) query += "&matchDate=" + match_date;
	        if (region != null && !region.isBlank()) query += "&region=" + util.encodeUrl(region);

	        if (!query.isBlank()) listUrl += query;

	        String paging = util.paging(current_page, total_page, listUrl);

	        mav.addObject("list", list);
	        mav.addObject("dataCount", dataCount);
	        mav.addObject("page", current_page);
	        mav.addObject("total_page", total_page);
	        mav.addObject("paging", paging); 
	        
	        mav.addObject("tab", tab);
	        mav.addObject("kwd", kwd);
	        mav.addObject("match_date", match_date);
	        mav.addObject("region", region);
	        
	        List<TeamDTO> myTeams = service.listUserTeams(info.getMember_code());
	         mav.addObject("myTeams", myTeams);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return mav;
	}

	@PostMapping("updateScore")
	public ModelAndView updateScore(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");

	    if (info == null) {
	        return new ModelAndView("redirect:/member/login");
	    }

	    try {
	        MatchDTO dto = new MatchDTO();
	        dto.setMatch_code(Long.parseLong(req.getParameter("match_code")));
	        dto.setHome_score(Integer.parseInt(req.getParameter("home_score")));
	        dto.setAway_score(Integer.parseInt(req.getParameter("away_score")));

	        int result = service.updateMatchResult(dto);
	        if (result == 0) {
	            service.insertMatchResult(dto);
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return new ModelAndView("redirect:/match/myMatch?tab=past");
	}
}