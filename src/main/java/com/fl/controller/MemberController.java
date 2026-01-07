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
		return new ModelAndView("member/login");
	}

	@PostMapping("login")
	public ModelAndView loginSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		try {
			// [수정 1] JSP의 name="userId", name="password" 와 일치시켜야 함
			String userId = req.getParameter("userId");
			String password = req.getParameter("password"); // userPwd -> password 변경

			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			
			// [수정 2] Mapper XML의 #{password} 와 일치시켜야 함
			map.put("password", password); // 키값 userPwd -> password 변경
			
			MemberDTO dto = service.loginMember(map);
			
			if(dto == null) {
				ModelAndView mav = new ModelAndView("member/login");
				mav.addObject("message", "아이디 또는 패스워드가 일치하지 않습니다.");
				return mav;
			}
			
			// 로그인 성공 처리
			session.setMaxInactiveInterval(20 * 60); // 20분

			SessionInfo info = new SessionInfo();
			// [참고] MemberDTO 변수명이 스네이크 표기법으로 바뀌었으므로 getter도 바뀜
			info.setMember_code(dto.getMember_code());
			info.setMember_id(dto.getMember_id());
			info.setMember_name(dto.getMember_name());
			info.setRole_level(dto.getRole_level());

			session.setAttribute("member", info);

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
			// 에러 발생 시 다시 로그인 폼으로
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

	// ... (아이디/비번 찾기 POST는 생략 - 구현 시 파라미터명 주의) ...

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
			MemberDTO dto = new MemberDTO();
			
			// [수정 3] 회원가입 JSP의 name 속성도 확인 필요!
			// 만약 signup.jsp에서도 name="password"로 했다면 아래처럼 받아야 함
			dto.setMember_id(req.getParameter("userId"));
			dto.setPassword(req.getParameter("password")); // userPwd -> password
			dto.setMember_name(req.getParameter("userName"));
			
			// 나머지 필드 (전화번호, 이메일 등)도 필요하면 추가 수집
			// dto.setPhone_number(req.getParameter("tel"));
			// dto.setEmail(req.getParameter("email"));

			service.insertMember(dto);
			
			return new ModelAndView("redirect:/member/signupSuccess");
			
		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("member/signup");
			mav.addObject("message", "회원가입 실패 (입력 정보를 확인해주세요)");
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
		
		// 마이페이지 메인에는 보통 내 정보 요약이나 최근 활동 내역 등을 보여줌
		// 필요하다면 여기서 service 호출해서 데이터 가져감
		
		return new ModelAndView("member/mypage");
	}

	@GetMapping("profile")
	public ModelAndView profileForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		return new ModelAndView("member/profile");
	}

	@GetMapping("updateInfo")
	public ModelAndView updateInfoForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}

	
		
		ModelAndView mav = new ModelAndView("member/updateInfo");
		return mav;
	}

	@PostMapping("updateDo")
	public ModelAndView updateInfoSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		if(info == null) {
			return new ModelAndView("redirect:/member/login");
		}

		try {
			MemberDTO dto = new MemberDTO();
			
			// 수정 불가능한 ID는 세션에서 가져오거나 hidden 필드에서 가져옴
			dto.setMember_id(info.getMember_id());
			
			// 수정할 정보들 수집 (password, email, phone 등)
			dto.setPassword(req.getParameter("password"));
			// dto.setEmail(req.getParameter("email"));
			// ...
			
			service.updateMember(dto);
			
			// 정보가 바뀌었으면 세션 정보(이름 등)도 갱신해주는 것이 좋음
			info.setMember_name(dto.getMember_name()); // 이름이 바뀌었다면
			session.setAttribute("member", info);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("redirect:/member/mypage");
	}
}