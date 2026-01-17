package com.fl.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.MatchDTO;
import com.fl.model.MatchHistoryDTO;
import com.fl.model.MemberDTO;
import com.fl.model.SessionInfo;
import com.fl.model.TeamDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.MemberService;
import com.fl.service.MemberServiceImpl;
import com.fl.service.MyPageService;
import com.fl.service.MyPageServiceImpl;
import com.fl.service.TeamService;
import com.fl.service.TeamServiceImpl;
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
	private TeamService teamService = new TeamServiceImpl();
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

	
	// 회원가입 
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
				// 기본 정보 조회
				MemberDTO myInfo = myPageService.readMember(info.getMember_code());
				List<MatchDTO> matchList = myPageService.listMyMatch(info.getMember_code());
				List<TeamDTO> myTeams = teamService.readMyTeam(info.getMember_code());
				
				// 대시보드 통계 계산 로직 추가
				Map<String, Object> stats = new HashMap<>();
				int monthMatchCount = 0;
				MatchDTO nextMatch = null;
				long minDaysDiff = Long.MAX_VALUE;
				
				LocalDate today = LocalDate.now();
				
				if(matchList != null) {
					for(MatchDTO m : matchList) {
						// 날짜 처리 (String -> LocalDate 변환, 예외처리 포함)
						try {
							// DB에서 가져온 날짜 문자열 (예: "2026-01-23 16:24")
							String dateStr = m.getMatch_date(); 
							if(dateStr.length() > 10) dateStr = dateStr.substring(0, 10); // 시간 자르고 날짜만
							
							LocalDate matchDate = LocalDate.parse(dateStr);
							
							// A. 이번 달 경기 수 카운트
							if(matchDate.getYear() == today.getYear() && matchDate.getMonth() == today.getMonth()) {
								monthMatchCount++;
							}
							
							// B. 다가오는 가장 가까운 경기 (Next Match) 찾기
							// 경기가 오늘 이후이고, 가장 가까운 날짜인지 확인
							if( (matchDate.isEqual(today) || matchDate.isAfter(today)) && !m.getStatus().equals("완료")) {
								long daysDiff = ChronoUnit.DAYS.between(today, matchDate);
								if(daysDiff < minDaysDiff) {
									minDaysDiff = daysDiff;
									nextMatch = m;
								}
							}
						} catch (Exception e) {
							// 날짜 파싱 에러나면 무시하고 다음 거 진행
						}
					}
				}
				
				// 통계 맵에 담기
				stats.put("month_match_count", monthMatchCount);
				stats.put("total_point", 0); // 공격 포인트는 아직 DB 컬럼 없으면 0으로 처리
				
				if(nextMatch != null) {
					stats.put("next_match_dday", minDaysDiff == 0 ? "Day" : minDaysDiff); // D-Day
					stats.put("next_match_opponent", nextMatch.getAway_team_name()); // 상대팀
					stats.put("next_match_date", nextMatch.getMatch_date());
				}

				// 3. JSP로 데이터 전송
				mav.addObject("dto", myInfo);
				mav.addObject("matchList", matchList);
				mav.addObject("myTeams", myTeams);
				mav.addObject("stats", stats); // 통계 데이터 추가
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
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");
	    
	    if(info == null) return new ModelAndView("redirect:/member/login");
	    
	    ModelAndView mav = new ModelAndView("member/match_history");
	    
	    try {
	        // 하나의 DTO 클래스로 두 가지 리스트 모두 처리!
	        List<MatchHistoryDTO> matchApplyList = myPageService.listMatchApply(info.getMember_code());
	        List<MatchHistoryDTO> mercenaryApplyList = myPageService.listMercenaryApply(info.getMember_code());
	        
	        mav.addObject("matchApplyList", matchApplyList);
	        mav.addObject("mercenaryApplyList", mercenaryApplyList);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return mav;
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