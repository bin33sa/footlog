package com.fl.controller;

import java.io.File;
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
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.AdminMypageService;
import com.fl.service.AdminMypageServiceImpl;
import com.fl.service.BoardQnaService;
import com.fl.service.BoardQnaServiceImpl;
import com.fl.service.MyPageService;
import com.fl.service.MyPageServiceImpl;
import com.fl.util.FileManager;
import com.fl.util.MyMultipartFile;
import com.fl.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;



@Controller
@RequestMapping("/admin/*")
public class MypageAdminController {
	
	private FileManager fileManager = new FileManager();
	
	
	private MyPageService myPageService = new MyPageServiceImpl();
	private AdminMypageService AdminService = new AdminMypageServiceImpl();
	
	
	private MyUtil util = new MyUtil();
	private BoardQnaService qnaService = new BoardQnaServiceImpl();
	
	@GetMapping("mypage")
	public ModelAndView myPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView("admin/mypage");
		
		//마이페이지
		try {
			if(info != null) {
				MemberDTO myInfo = myPageService.readMember(info.getMember_code());
				mav.addObject("dto", myInfo);
			}

			List<TeamDTO> team = AdminService.CountTeamAll();
			List<TeamDTO> teamList = AdminService.ListTeamAll();
			
			List<StadiumDTO> stadium = AdminService.CountStadiumAll();
			List<StadiumDTO> stadiumList = AdminService.ListStadiumAll();
			
			List<MemberDTO> member = AdminService.CountMemberAll();
			List<MemberDTO> memberList = AdminService.ListMemberAll();
			mav.addObject("team", team);
			mav.addObject("stadium", stadium);
			mav.addObject("member", member);
			
			mav.addObject("teamList", teamList);
			mav.addObject("stadiumList", stadiumList);
			mav.addObject("memberList", memberList);
			
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
	
	
	@GetMapping("insertStadium")
	public ModelAndView insertStadiumForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("admin/mypage/updateStadium");
		mav.addObject("mode", "insert");
		return mav;
	}
	
	@GetMapping("updateStadium")
	public ModelAndView updateStadiumForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		long stadiumCode = Long.parseLong(req.getParameter("stadiumCode"));

		
		StadiumDTO dto = new StadiumDTO();
	    dto.setStadiumCode(stadiumCode); 

	    ModelAndView mav = new ModelAndView("admin/mypage/updateStadium");
	    
	    mav.addObject("dto", dto);   // ★ 이 한 줄이 핵심
		mav.addObject("mode", "update");
		return mav;
	}
	
	@PostMapping("deleteStadium")
	public ModelAndView deleteStadium(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		long stadiumCode = Long.parseLong(req.getParameter("stadiumCode"));

		try {
			AdminService.DeleteStadium(stadiumCode);
			
			
			// 페이지 이동
	        return new ModelAndView("redirect:/admin/mypage?menu=stadium");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/admin/mypage?menu=stadium");
	    
	}
	
	
	@PostMapping("updateDo")
	public ModelAndView updateStadium(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 	HttpSession session = req.getSession();
		    
		    String root = session.getServletContext().getRealPath("/");
		    String pathname = root + "uploads" + File.separator + "stadium";

		    try {
		    	
		        StadiumDTO dto = new StadiumDTO();
		        dto.setStadiumName(req.getParameter("stadiumName"));
		        dto.setRegion(req.getParameter("region"));
		        dto.setPhoneNumber(req.getParameter("phoneNumber"));
		        dto.setDescription(req.getParameter("description"));
		        dto.setRating(Long.parseLong(req.getParameter("rating")));
		        dto.setPrice(Long.parseLong(req.getParameter("price")));
		        dto.setStadium_image(req.getParameter("stadiumImage"));
		        
		        // 파일 처리
		        String imageDeleted = req.getParameter("imageDeleted");
		        Part p = req.getPart("selectFile");
		        
		        //새 파일 업로드
		        MyMultipartFile mp = fileManager.doFileUpload(p, pathname);
		        
		        if(mp != null) {
		            if(dto.getStadium_image() != null && !dto.getStadium_image().equals("avatar.png")) {
		                fileManager.doFiledelete(pathname, dto.getStadium_image());
		            }
		            
		            dto.setStadium_image(mp.getSaveFilename());
		        } else if("true".equals(imageDeleted)) {
		            if(dto.getStadium_image() != null && !dto.getStadium_image().equals("avatar.png")) {
		                fileManager.doFiledelete(pathname, dto.getStadium_image());
		            }
		            dto.setStadium_image("avatar.png");
		        }
		        
		    
		        //인서트 or 업데이트 실행
		        String mode = req.getParameter("mode");
		        
		        if("insert".equals(mode)) {
		        AdminService.InsertStadium(dto);
		        } else {
		        	dto.setStadiumCode(Long.parseLong(req.getParameter("stadiumCode")));
		        AdminService.UpdateStadium(dto);
		        }
		        // 페이지 이동
		        return new ModelAndView("redirect:/admin/mypage?menu=stadium");

		    } catch (Exception e) {
		        e.printStackTrace();
		        ModelAndView mav = new ModelAndView("member/updateInfo");
		        mav.addObject("message", "회원 정보 수정 중 오류가 발생했습니다.");
		        return mav;
		    }
		    
	}
		
}
