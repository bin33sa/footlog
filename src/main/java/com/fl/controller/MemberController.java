package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.fl.model.MemberDTO;
import com.fl.model.SessionInfo;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.MemberService;
import com.fl.service.MemberServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private MemberService service = new MemberServiceImpl();

	// ==========================================
	// 1. 로그인 및 로그아웃 관련
	// ==========================================

	@GetMapping("login")
	public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 폼 페이지 이동
		return new ModelAndView("member/login");
	}

	@PostMapping("login")
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 로그인 처리 로직
		HttpSession session = req.getSession();
		
		try {
			String userId = req.getParameter("userId");
			String userPwd = req.getParameter("userPwd");

			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("userPwd", userPwd);
			
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

			session.setAttribute("member", info);

			// 이전 페이지 리다이렉트 처리
			String preLoginURI = (String)session.getAttribute("preLoginURI");
			session.removeAttribute("preLoginURI");

			if(preLoginURI != null) {
				if(preLoginURI.contains("/login")) {
					return new ModelAndView("redirect:/main");
				}
				return new ModelAndView("redirect:" + preLoginURI);
			}

			return new ModelAndView("redirect:/main");
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("redirect:/error");
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

	@PostMapping("findIdDo")
	public ModelAndView findIdSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 현재는 로직 없이 로그인 페이지로 이동
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/member/login");
	}

	@PostMapping("findPwDo")
	public ModelAndView findPwSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// TODO: 파라미터 수집 후 서비스 호출 (예: service.findPw(map))
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/member/login");
	}

	// ==========================================
	// 3. 회원가입 관련
	// ==========================================

	@GetMapping("signup")
	public ModelAndView signupForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("member/signup");
	}

	@PostMapping("signup")
	public ModelAndView signupSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// [수정] 회원가입 데이터 수집 시 새 DTO의 setter 사용
			MemberDTO dto = new MemberDTO();
			
			// JSP의 name="userId" 값을 DTO의 memberId에 저장
			dto.setMember_id(req.getParameter("userId"));     
			
			// JSP의 name="userPwd" 값을 DTO의 password에 저장
			dto.setPassword(req.getParameter("userPwd"));    
			
			// JSP의 name="userName" 값을 DTO의 memberName에 저장
			dto.setMember_name(req.getParameter("userName")); 
			
			// TODO: 서비스 호출 (service.insertMember(dto))
			
			return new ModelAndView("redirect:/member/signupSuccess");
			
		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("member/signup");
			mav.addObject("message", "회원가입 실패");
			return mav;
		}
	}

	@GetMapping("signupSuccess")
	public ModelAndView signupSuccess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("member/signup_success");
	}

	// ==========================================
	// 4. 마이페이지 및 정보 수정
	// ==========================================

	@GetMapping("mypage")
	public ModelAndView myPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}
		
		
		return new ModelAndView("member/mypage");
	}

	@GetMapping("profile")
	public ModelAndView profileForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 프로필 사진 변경 폼
		return new ModelAndView("member/profile");
	}

	@PostMapping("profileUpdate")
	public ModelAndView profileUpdateSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// TODO: 파일 업로드 처리 및 DB 업데이트 로직 구현
			// Part part = req.getPart("uploadFile"); ...
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/member/mypage");
	}

	@GetMapping("updateInfo")
	public ModelAndView updateInfoForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 회원정보 수정 폼 (기존 정보를 가져와서 뿌려줘야 함)
	
		return new ModelAndView("member/updateInfo");
	}

	@PostMapping("updateDo")
	public ModelAndView updateInfoSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// TODO: 수정된 정보 수집 후 서비스 호출
			// service.updateMember(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/member/mypage");
	}
}