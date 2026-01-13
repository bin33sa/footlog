package com.fl.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.MatchDTO;
import com.fl.model.MemberDTO;
import com.fl.model.SessionInfo;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;

import com.fl.mvc.view.ModelAndView;
import com.fl.service.MemberService;
import com.fl.service.MemberServiceImpl;
import com.fl.service.MyPageService;
import com.fl.service.MyPageServiceImpl;
import com.fl.util.FileManager;
import com.fl.util.MyMultipartFile;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private MemberService service = new MemberServiceImpl();
	private MyPageService myPageService = new MyPageServiceImpl();
	private FileManager fileManager = new FileManager();
	

	// ==========================================
	// 1. 로그인 및 로그아웃 관련
	// ==========================================

	@GetMapping("login")
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("member/login");
	}

	@PostMapping("login")
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		try {
			String userId = req.getParameter("userId");
			String password = req.getParameter("password");

			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("password", password);
			
			MemberDTO dto = service.loginMember(map);
			
			if(dto == null) {
				ModelAndView mav = new ModelAndView("member/login");
				mav.addObject("message", "아이디 또는 패스워드가 일치하지 않습니다.");
				return mav;
			}
			
			// 로그인 성공 처리
			session.setMaxInactiveInterval(20 * 60); // 20분

			SessionInfo info = new SessionInfo();
			info.setMember_code(dto.getMember_code());
			info.setMember_id(dto.getMember_id());
			info.setMember_name(dto.getMember_name());
			info.setRole_level(dto.getRole_level());
			info.setProfile_image(dto.getProfile_image());
			
			session.setAttribute("member", info);

			String preLoginURI = (String)session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");

			if(preLoginURI != null) {
				if(preLoginURI.contains("/login")) {
					return new ModelAndView("redirect:/main");
				}
				return new ModelAndView(preLoginURI);
			}

			return new ModelAndView("redirect:/main");
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("member/login");
		}
	}

	@GetMapping("logout")
	public ModelAndView logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		if(session != null) {
			session.removeAttribute("member");
			session.invalidate();
		}
		return new ModelAndView("redirect:/main");
	}

	// ==========================================
	// 2. 아이디 / 비밀번호 찾기
	// ==========================================

	@GetMapping("findInfo")
	public ModelAndView findInfoForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("member/findUserInfo");
	}

	// ==========================================
	// 3. 회원가입 관련
	// ==========================================
		
		// 아이디 중복 검사 
		@PostMapping("userIdCheck")
		public void userIdCheck(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
			String member_id = req.getParameter("member_id");
			
			MemberDTO dto = null;
			try {
				dto = service.findById(member_id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String passed = "false";
			if(dto == null) {
				passed = "true";
			}
			
			
			resp.setContentType("application/json; charset=UTF-8");
			
			
			resp.getWriter().write("{\"passed\": \"" + passed + "\"}");
		}
	
	// 패스워드 확인 폼
	@GetMapping("pwd")
	public ModelAndView pwdForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("member/pwd");
		String mode = req.getParameter("mode");
		mav.addObject("mode", mode);
		return mav;
	}
	
	@PostMapping("pwd")
	public ModelAndView pwdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			MemberDTO dto = service.findById(info.getMember_id());
			
			if(dto == null) {
				session.invalidate();
				return new ModelAndView("redirect:/");
			}
			
			String password = req.getParameter("password");
			String mode = req.getParameter("mode");
			
			if(! dto.getPassword().equals(password)) {
				ModelAndView mav = new ModelAndView("member/pwd");
				mav.addObject("mode", mode);
				mav.addObject("message", "패스워드가 일치하지 않습니다.");
				return mav;
			}
			
			if(mode.equals("delete")) {
				// 회원 탈퇴 처리 (구현 필요)
				session.removeAttribute("member");
				session.invalidate();
			} else if(mode.equals("update")) {
				ModelAndView mav = new ModelAndView("member/member");
				mav.addObject("dto", dto);
				mav.addObject("mode", "update");
				return mav;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ModelAndView("redirect:/");
	}

	
	// 회원가입 폼
	@GetMapping("signup")
	public ModelAndView signupForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("member/signup");
		mav.addObject("mode", "sign");
		return mav;
	}

	// 회원가입 정보 저장 (프로필 사진 기본값 처리 추가)
	@PostMapping("signup")
	public ModelAndView signupSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		// 파일 저장 경로 
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "member";
		
		String message = "";
		
		try {
			MemberDTO dto = new MemberDTO();
			
			dto.setMember_id(req.getParameter("member_id")); 
			dto.setPassword(req.getParameter("password")); 
			dto.setMember_name(req.getParameter("member_name")); 
			dto.setPhone_number(req.getParameter("phone_number")); 
			dto.setEmail(req.getParameter("email")); 
			dto.setRegion(req.getParameter("region")); 
			dto.setPreferred_position(req.getParameter("preferred_position")); 
			
			// 프로필 사진파일 업로드 처리
			Part p = req.getPart("selectFile");
			MyMultipartFile mp = fileManager.doFileUpload(p, pathname);
			
			if(mp != null) {
				// 1. 파일이 업로드 되었을 때
				dto.setProfile_image(mp.getSaveFilename());
			} else {
				// 2. 파일이 없을 때 기본 이미지 설정 
				dto.setProfile_image("avatar.png");
			}
			
			service.insertMember(dto);
			
			session.setAttribute("mode", "signup");
			session.setAttribute("member_name", dto.getMember_name());
			
			return new ModelAndView("redirect:/member/signupSuccess");
			
		} catch (SQLException e) {
			if(e.getErrorCode() == 1) {
				message = "아이디 중복으로 회원가입이 실패했습니다.";
			} else if(e.getErrorCode() == 1400) {
				message = "필수사항을 입력하지 않았습니다.";
			} else {
				message = "회원 가입이 실패했습니다.";
			}
			e.printStackTrace();
		} catch (Exception e) {
			message = "회원 가입이 실패했습니다.";
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView("member/signup");
		mav.addObject("mode", "signup");
		mav.addObject("message", message);
		
		return mav;
	}

	@GetMapping("signupSuccess")
	public ModelAndView signupSuccess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		String mode = (String)session.getAttribute("mode");
		String member_name = (String)session.getAttribute("member_name");
		
		// 세션에서 사용한 값 삭제 (새로고침 시 중복 방지)
		session.removeAttribute("mode");
		session.removeAttribute("member_name");
		
		if(mode == null) {
			return new ModelAndView("redirect:/main");
		}
		
	
		String message = "<b>" + member_name + "</b>님의 회원가입이<br>성공적으로 완료되었습니다.";
		
		ModelAndView mav = new ModelAndView("member/signup_success");
		mav.addObject("message", message);
		
		return mav;
	}

	// ==========================================
	// 4. 마이페이지 및 정보 수정
	// ==========================================

	@GetMapping("mypage")
	public ModelAndView myPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		ModelAndView mav = new ModelAndView("member/mypage");
		
		try {
			if(info != null) {
				MemberDTO myInfo = myPageService.readMember(info.getMember_code());
				List<MatchDTO> matchList = myPageService.listMyMatch(info.getMember_code());
				
				mav.addObject("dto", myInfo);
				mav.addObject("matchList", matchList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mav;
	}
	
	// 일단 쓸지말지 보류.. (안쓸듯)
	@GetMapping("profile")
	public ModelAndView profileForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("member/profile");
	}
	
	// 매치/용병 신청내역 가기 
	@GetMapping("history")
	public ModelAndView match_history(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("/member/history");
	}
	

	@GetMapping("updateInfo")
	public ModelAndView updateInfoForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info == null) {
	        return new ModelAndView("redirect:/member/login");
	    }
	    
	    ModelAndView mav = new ModelAndView("member/updateInfo");
	    
	    try {
	        // 회원 아이디로 전체 정보를 조회
	        MemberDTO dto = service.findById(info.getMember_id());
	        
	        // 조회한 데이터를 "dto"라는 이름으로 추가
	        mav.addObject("dto", dto);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return mav;
	}
	
	@PostMapping("updateDo")
	public ModelAndView updateInfoSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    
	    String root = session.getServletContext().getRealPath("/");
	    String pathname = root + "uploads" + File.separator + "member";

	    try {
	        MemberDTO dto = service.findById(info.getMember_id());
	        
	        dto.setMember_name(req.getParameter("member_name"));
	        dto.setPhone_number(req.getParameter("phone_number"));
	        dto.setEmail(req.getParameter("email"));
	        dto.setRegion(req.getParameter("region"));
	        dto.setPreferred_position(req.getParameter("preferred_position"));
	        
	        // 비밀번호 수정 (입력했을 때만)
	        String pwd = req.getParameter("password");
	        if(pwd != null && !pwd.trim().isEmpty()) {
	            dto.setPassword(pwd);
	        }

	        // 파일 처리
	        String imageDeleted = req.getParameter("imageDeleted");
	        Part p = req.getPart("selectFile");
	        MyMultipartFile mp = fileManager.doFileUpload(p, pathname);
	        
	        if(mp != null) {
	            if(dto.getProfile_image() != null && !dto.getProfile_image().equals("avatar.png")) {
	                fileManager.doFiledelete(pathname, dto.getProfile_image());
	            }
	            dto.setProfile_image(mp.getSaveFilename());
	        } else if("true".equals(imageDeleted)) {
	            if(dto.getProfile_image() != null && !dto.getProfile_image().equals("avatar.png")) {
	                fileManager.doFiledelete(pathname, dto.getProfile_image());
	            }
	            dto.setProfile_image("avatar.png");
	        }
	    
	        service.updateMember(dto);
	        
	        info.setMember_name(dto.getMember_name()); // 이름 변경 대비
	        info.setProfile_image(dto.getProfile_image()); // 수정된 새 이미지 파일명 저장
	        session.setAttribute("member", info); // 갱신된 info 객체를 세션에 다시 덮어쓰기

	        // 성공 플래그와 함께 다시 이동
	        ModelAndView mav = new ModelAndView("member/updateInfo");
	        mav.addObject("updateComplete", "true");
	        return mav;

	    } catch (Exception e) {
	        e.printStackTrace();
	        ModelAndView mav = new ModelAndView("member/updateInfo");
	        mav.addObject("dto", info); 
	        mav.addObject("message", "회원 정보 수정 중 오류가 발생했습니다.");
	        return mav;
	    }
	}
}