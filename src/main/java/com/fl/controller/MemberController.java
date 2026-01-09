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
			String password = req.getParameter("password"); // userPwd -> password 변경

			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);

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
				return new ModelAndView(preLoginURI);
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

	// 회원가입 폼
	@GetMapping("signup")
	public ModelAndView signupForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ModelAndView mav = new ModelAndView("member/signup");
		
		mav.addObject("mode", "sign");
		
		return mav;
	}

	// 회원가입 정보 저장
	@PostMapping("signup")
	public ModelAndView signupSubmit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		// 파일 저장 경로 
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "member";
		
		String message = "";
		
		try {
			MemberDTO dto = new MemberDTO();
			
			dto.setMember_id(req.getParameter("member_id")); // 아이디
			dto.setPassword(req.getParameter("password")); // 비번
			dto.setMember_name(req.getParameter("member_name")); // 이름
			dto.setPhone_number(req.getParameter("phone_number")); // 전번
			dto.setEmail(req.getParameter("email")); // 이메일 
			dto.setRegion(req.getParameter("region")); // 활동 지역
			dto.setPreferred_position(req.getParameter("preferred_position")); // 선호 포지션
			
			// 프로필 사진파일 업로드 
			Part p = req.getPart("selectFile");
			MyMultipartFile mp = fileManager.doFileUpload(p, pathname);
			if(mp != null) {
				dto.setProfile_image(mp.getSaveFilename());
			}
			
			service.insertMember(dto);
			
			session.setAttribute("mode", "signup");
			session.setAttribute("member_Name", dto.getMember_name());
			
			
			return new ModelAndView("redirect:/member/signupSuccess");
			
		} catch (SQLException e) {
			if(e.getErrorCode() == 1) {
				message = "아이디 중복으로 회원가입이 실패했습니다.";
			} else if(e.getErrorCode() == 1400) {
				message = "필수사항을 입력하지 않았습니다.";
			} else {
				message = "회원 가입이 실패했습니다.";
			}
			
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
		
		session.removeAttribute("mode");
		session.removeAttribute("member_name");
		
		if(mode == null) {
			return new ModelAndView("redirect:/main");
		}
		
		String title;
		String message = "<b>" + member_name + "</b>님";
		if(mode.equals("account")) {
			title = "회원가입";
			message += "회원가입이 완료 되었습니다.";
		} else {
			title = "정보수정";
			message += "회원정보가 수정 되었습니다.";
		}
		
		ModelAndView mav = new ModelAndView("member/signup_success");
		
		mav.addObject("title", title);
		mav.addObject("message", message);
		
		return mav; // 여기까지함 !!! 1월 9일 금욜 
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
			
			MemberDTO myInfo = myPageService.readMember(info.getMember_code());
			
			List<MatchDTO> matchList = myPageService.listMyMatch(info.getMember_code());
			
			mav.addObject("dto", myInfo);
			mav.addObject("matchList", matchList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 마이페이지 메인에는 보통 내 정보 요약이나 최근 활동 내역 등을 보여줌
		// 필요하다면 여기서 service 호출해서 데이터 가져감

		return mav;
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