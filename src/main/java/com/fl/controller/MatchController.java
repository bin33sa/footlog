package com.fl.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.MatchDTO;
import com.fl.model.SessionInfo;
import com.fl.model.StadiumDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
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
		
		try {
			
			String page = req.getParameter("page");

			int current_page = 1;
			if(page != null) {
				current_page = Integer.parseInt(page);
			}
			
			//검색
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			if(schType == null) {
				schType = "all";
				kwd = "";
			}
			
			kwd = util.decodeUrl(kwd);
			
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			
			total_page = util.pageCount(dataCount, size);
			current_page = Math.min(total_page, current_page);
			
			int offset = (current_page -1 ) * size;
			if(offset<0) offset=0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MatchDTO> list = service.listMatch(map);
			
			String query = "";
			String cp = req.getContextPath();
			String listUrl = cp + "/match/list";
			String articleUrl = cp + "/match/article?page=" + current_page;
			if(! kwd.isBlank()) {
				query = "schType=" + schType + "&kwd="+util.encodeUrl(kwd);
				
				listUrl += "?" + query;
				articleUrl += "&" + query;
			}
			
			String paging = util.paging(current_page, total_page, listUrl);
			
			
			mav.addObject("list", list);
			mav.addObject("dataCount", dataCount);
			mav.addObject("total_page", total_page);
			mav.addObject("size", size);
			mav.addObject("page", current_page);
			mav.addObject("articleUrl", articleUrl);
			mav.addObject("schType", schType);
			mav.addObject("kwd", kwd);
			mav.addObject("paging", paging);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@GetMapping("article")
	public ModelAndView matchBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String page = req.getParameter("page");
		String query = "page="+page;
		
		//HttpSession session = req.getSession();
		//SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			long match_code = Long.parseLong(req.getParameter("match_code"));
			String schType = req.getParameter("schType");
			String kwd = req.getParameter("kwd");
			
			if(schType ==null) {
				schType = "all";
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
			
			MatchDTO prevDto = service.findByPrev(map);
			MatchDTO nextDto = service.findByNext(map);
			
			ModelAndView mav = new ModelAndView("match/article");
			
			//map.put("member_code",info.getMember_id());
			
			//if(info != null) {
            //    map.put("member_code", info.getMember_id());
                // 필요하다면 mav에 로그인 정보 추가
            //}
			
			mav.addObject("dto", dto);
			mav.addObject("page", page);
			mav.addObject("query", query);
			mav.addObject("prevDto", prevDto);
			mav.addObject("nextDto", nextDto);
			
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
		if(info == null || (info.getRole_level()!=1 && info.getRole_level()!=60)) {
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('권한이 없습니다.'); location.href='"+req.getContextPath()+"/match/list';</script>");
			out.flush();
			out.close();
			return null;
		}
		
		List<StadiumDTO> list = stadiumservice.listStadiumAll();
		mav.addObject("stadiumList", list);
		mav.addObject("mode", "write");
		
		return mav;
	}
	
	@PostMapping("write")
	public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			MatchDTO dto = new MatchDTO();
			long myTeamCode = service.getUserTeamCode(info.getMember_code());
			
			if (info == null || (info.getRole_level() != 1 && info.getRole_level() != 60)) {
		        return new ModelAndView("redirect:/match/list");
		    }
			
			//long memberCode = Long.parseLong(info.getMember_code());
			dto.setMember_code(info.getMember_code());
			
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			dto.setHome_code(myTeamCode);
			dto.setMatch_date(req.getParameter("matchDate"));
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
	
	
	@RequestMapping("myMatch")
	public ModelAndView myMatch(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("match/myMatch");
		
		return mav;
	}
}
