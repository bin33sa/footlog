package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.BoardQnaDTO;
import com.fl.model.MemberDTO;
import com.fl.model.SessionInfo;
import com.fl.model.StadiumDTO;
import com.fl.model.TeamDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.AdminMypageService;
import com.fl.service.AdminMypageServiceImpl;
import com.fl.service.BoardQnaService;
import com.fl.service.BoardQnaServiceImpl;
import com.fl.service.MyPageService;
import com.fl.service.MyPageServiceImpl;
import com.fl.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/admin/*")
public class MypageAdminController {

	private MyPageService myPageService = new MyPageServiceImpl();
	private AdminMypageService AdminService = new AdminMypageServiceImpl();
	
	
	private MyUtil util = new MyUtil();
	private BoardQnaService qnaService = new BoardQnaServiceImpl();
	
	@GetMapping("mypage")
	public ModelAndView myPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView("admin/mypage");
		
		try {
			if(info != null) {
				MemberDTO myInfo = myPageService.readMember(info.getMember_code());
				mav.addObject("dto", myInfo);
			}

			List<TeamDTO> team = AdminService.CountTeamAll();
			List<TeamDTO> teamList = AdminService.ListTeamAll();
			
			List<StadiumDTO> stadium = AdminService.CountStadiumAll();
			List<MemberDTO> member = AdminService.CountMemberAll();
			mav.addObject("team", team);
			mav.addObject("stadium", stadium);
			mav.addObject("member", member);
			mav.addObject("teamList", teamList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//문의게시판
		 try {
	            String page = req.getParameter("page");
	            int current_page = (page == null) ? 1 : Integer.parseInt(page);

	            String schType = req.getParameter("schType");
	            String kwd = req.getParameter("kwd");

	            if (schType == null) {
	                schType = "all";
	                kwd = "";
	            }
	            kwd = util.decodeUrl(kwd);

	            int size = 10;
	            Map<String, Object> map = new HashMap<>();
	            map.put("schType", schType);
	            map.put("kwd", kwd);

	            int dataCount = qnaService.dataCount(map);
	            int total_page = util.pageCount(dataCount, size);
	            current_page = Math.min(current_page, total_page);

	            int offset = (current_page - 1) * size;
	            map.put("offset", Math.max(offset, 0));
	            map.put("size", size);

	            List<BoardQnaDTO> list = qnaService.listQna(map);

	            String cp = req.getContextPath();
	            String query = "";
	            if (!kwd.isBlank()) {
	                query = "schType=" + schType + "&kwd=" + util.encodeUrl(kwd);
	            }

	            String listUrl = cp + "/qna/list";
	            if (!query.isEmpty()) {
	                listUrl += "?" + query;
	            }

	            String paging = util.paging(current_page, total_page, listUrl);

	            mav.addObject("list", list);
	            mav.addObject("dataCount", dataCount);
	            mav.addObject("page", current_page);
	            mav.addObject("total_page", total_page);
	            mav.addObject("paging", paging);
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

		return mav;
	}
	
	
	
}
