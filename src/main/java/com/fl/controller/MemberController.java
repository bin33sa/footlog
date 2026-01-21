package com.fl.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.mail.MailDTO;
import com.fl.mail.MailSender;
import com.fl.model.MatchDTO;
import com.fl.model.MatchHistoryDTO;
import com.fl.model.MemberDTO;
import com.fl.model.MercenaryDTO;
import com.fl.model.SessionInfo;
import com.fl.model.TeamDTO;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.annotation.ResponseBody;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.MatchService;
import com.fl.service.MatchServiceImpl;
import com.fl.service.MemberService;
import com.fl.service.MemberServiceImpl;
import com.fl.service.MyPageService;
import com.fl.service.MyPageServiceImpl;
import com.fl.service.TeamService;
import com.fl.service.TeamServiceImpl;
import com.fl.util.FileManager;
import com.fl.util.MyMultipartFile;
import com.fl.util.MyUtil;

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
   private MatchService matchService = new MatchServiceImpl();
   private FileManager fileManager = new FileManager();
   

   // ==========================================
   // 1. 로그인 및 로그아웃, 탈퇴 관련
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
         
         // dto가 없거나 is_deleted가 1(탈퇴)이면 로그인 실패 처리 
         if(dto == null || dto.getIs_deleted() == 1) {
            ModelAndView mav = new ModelAndView("member/login");
            
            if(dto != null && dto.getIs_deleted() == 1) {
               mav.addObject("message", "탈퇴한 회원입니다.\n복구를 원하시면 관리자에게 문의하세요.");   
            } else {
               mav.addObject("message", "아이디 또는 패스워드가 일치하지 않습니다.");
            }
            return mav;
         }
         List<TeamDTO> myTeams = matchService.listUserTeams(dto.getMember_code());
         session.setAttribute("myTeams", myTeams);
         
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
   
   // 로그아웃
   @GetMapping("logout")
   public ModelAndView logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      HttpSession session = req.getSession(false);
      if(session != null) {
         session.removeAttribute("member");
         session.invalidate();
      }
      return new ModelAndView("redirect:/main");
   }
   
   
   // 탈퇴 실행
   @GetMapping("delete")
   public ModelAndView deleteDo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       HttpSession session = req.getSession();
       SessionInfo info = (SessionInfo) session.getAttribute("member");

       try {
           Map<String, Object> map = new HashMap<>();
           map.put("member_id", info.getMember_id());
           map.put("member_code", info.getMember_code()); // DB 삭제 로직에 필요

           // 서비스 호출 (구단삭제 -> 회원탈퇴)
           service.deleteMember(map);

           // 로그아웃
           session.removeAttribute("member");
           session.invalidate();

           // 완료 알림 페이지로 이동
           ModelAndView mav = new ModelAndView("member/delete_complete");
           mav.addObject("message", "회원탈퇴가 완료되었습니다.");
           mav.addObject("url", req.getContextPath() + "/main");
           
           return mav;

       } catch (Exception e) {
           e.printStackTrace();
           // 에러 나면 다시 마이페이지
           return new ModelAndView("redirect:/member/mypage");
       }
   }
   
   
   // 탈퇴 버튼 누를 때 구단장인지 확인 (ajax)
   @ResponseBody
   @PostMapping("checkLeader")
   public Map<String, Object> checkLeader(HttpServletRequest req, HttpServletResponse resp) {
      
       HttpSession session = req.getSession();
       
       Map<String, Object> model = new HashMap<>();
       SessionInfo info = (SessionInfo) session.getAttribute("member");
       
       if (info == null) {
           model.put("isLogin", false);
           return model;
       }

       // 서비스 호출
       int leaderCount = service.countLeaderTeam(info.getMember_code());
       
       model.put("isLogin", true);
       model.put("leaderCount", leaderCount);
       
       return model;
   }
   

   // ==========================================
   // 2. 아이디 / 비밀번호 찾기
   // ==========================================

   @GetMapping("findInfo")
   public ModelAndView findInfoForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      return new ModelAndView("member/findUserInfo");
   }
   
   
   // 아이디 찾기 실행
   @PostMapping("findIdDo")
   public ModelAndView findIdDo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      
      String name = req.getParameter("name");
      String email = req.getParameter("email");
      
      Map<String, Object> map = new HashMap<>();
      map.put("member_name", name);
      map.put("email", email);
      
      // 서비스 호출
      MemberDTO dto = service.findId(map);
      
      ModelAndView mav = new ModelAndView("member/findUserInfo"); // 원래 페이지로 돌아감 (결과 보여주기 위해)
      
      if (dto != null) {
         
         String rawId = dto.getMember_id();
         String maskedId = rawId;

         // 아이디가 3글자 초과일 때만 뒤 3글자 마스킹 (예: yeonhwa -> yeon***)
         if(rawId.length() > 3) {
            maskedId = rawId.substring(0, rawId.length() - 3) + "***";
         } else {
            
            maskedId = "***"; 
         }
   
         // 메시지에 마스킹된 아이디(maskedId)를 넣음
         mav.addObject("message", "회원님의 아이디는 <b>" + maskedId + "</b> 입니다.");
         
         // 탭 유지를 위해 추가 
         mav.addObject("activeTab", "id"); 
      } else {
         // 못 찾았을 경우
         mav.addObject("message", "일치하는 회원 정보가 없습니다.");
         mav.addObject("activeTab", "id");
      }
      
      return mav;
   }
   
   

   @PostMapping("findPwDo")
    public ModelAndView findPwDo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
      // 처리가 끝나면 무조건 결과 페이지로 리다이렉트
        String url = "redirect:/member/findPwResult";
        
        HttpSession session = req.getSession();
        String userId = req.getParameter("userId");
        String email = req.getParameter("email");
        
        try {
            // 1. 회원 정보 확인
            MemberDTO dto = service.findById(userId);
            
            // 아이디가 없거나 이메일이 다르면 -> 실패 (파라미터 전달)
            if(dto == null || !dto.getEmail().equals(email)) {
                return new ModelAndView("redirect:/member/findPwResult?fail=notfound");
            }
            
            // 2. 임시 비밀번호 생성 및 DB 업데이트
            String tempPw = generateTempPassword(10);
            dto.setPassword(tempPw); 
            service.updateMemberPw(dto); // DB 업데이트
            
            // 3. 메일 발송 준비
            MailDTO mail = new MailDTO();
            mail.setSenderName("Footlog 관리자");
            mail.setSenderEmail("yeonhwa7992@gmail.com");
            mail.setReceiverEmail(email);
            mail.setSubject("[Footlog] 임시 비밀번호 안내입니다.");
           
            String homeUrl = "http://localhost:9090/footlog/main"; 
            
            String content = 
                "<div style='background-color: #f8f9fa; padding: 50px 0; font-family: sans-serif;'>"
              + "  <div style='width: 100%; max-width: 500px; margin: 0 auto; background-color: #ffffff; border-radius: 20px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); overflow: hidden; border: 1px solid #eee;'>"
              
              + "    "
              + "    <div style='padding: 30px; text-align: center; border-bottom: 1px solid #f1f1f1;'>"
              + "      <a href='" + homeUrl + "' target='_blank' style='font-size: 24px; font-weight: 900; font-style: italic; color: #000; text-decoration: none;'>Footlog</a>"
              + "    </div>"
              
              + "    "
              + "    <div style='padding: 40px 30px; text-align: center;'>"
              + "      <h2 style='color: #111; font-size: 20px; margin-bottom: 30px; font-weight: 800;'>임시 비밀번호 발급 안내</h2>"
              + "      <p style='color: #666; font-size: 14px; line-height: 1.5; margin-bottom: 30px;'>"
              + "        안녕하세요, 회원님.<br>"
              + "        요청하신 임시 비밀번호가 발급되었습니다.<br>"
              + "        아래 비밀번호로 로그인 후 반드시 변경해 주세요."
              + "      </p>"
              
              + "      "
              + "      <div style='background-color: #f8f9fa; padding: 20px; border-radius: 12px; margin-bottom: 30px; border: 1px solid #e9ecef;'>"
              + "        <span style='color: #000; font-size: 24px; font-weight: 800; letter-spacing: 2px; display: block;'>" 
              +            tempPw 
              + "        </span>"
              + "      </div>"
              
              + "      <a href='" + homeUrl + "/member/login' target='_blank' style='display: inline-block; padding: 15px 30px; background-color: #000; color: #fff; text-decoration: none; font-weight: bold; border-radius: 8px; font-size: 14px;'>로그인 하러 가기</a>"

              + "      <p style='color: #999; font-size: 12px; margin-top: 40px;'>"
              + "        본 메일은 발신 전용이며 회신되지 않습니다.<br>"
              + "        &copy; Footlog Team"
              + "      </p>"
              + "    </div>"
              + "  </div>"
              + "</div>";
              
            mail.setContent(content);

            // 4. 메일 전송
            MailSender sender = new MailSender();
            boolean b = sender.mailSend(mail);
            
            if(b) {
                // 성공 시 받는 사람 이메일을 세션에 잠깐 저장 (결과 페이지에서 보여주기 위함)
                session.setAttribute("receiverEmail", email);
            } else {
                // DB는 바꼈는데 메일 전송만 실패한 경우
                url += "?fail=send";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            url += "?fail=error";
        }
        
        return new ModelAndView(url);
    }
   
   // 이메일 전송 확인 
   @GetMapping("findPwResult")
    public ModelAndView findPwResult(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("member/findPwResult");
        HttpSession session = req.getSession();
        
        String fail = req.getParameter("fail");
        String receiver = (String)session.getAttribute("receiverEmail");
        
        // 세션 값 삭제 (새로고침 시 계속 남는 것 방지)
        session.removeAttribute("receiverEmail");
        
        String msg = "";
        boolean isSuccess = false;
        
        if(fail == null) {
            // 성공 케이스
            if(receiver != null) {
                isSuccess = true;
                msg = "<span style='color:blue; font-weight:bold;'>" + receiver + "</span>님에게<br>"
                    + "임시 비밀번호를 전송했습니다.<br>메일함을 확인해주세요.";
            } else {
                // 비정상 접근 (새로고침 등)
                return new ModelAndView("redirect:/member/login");
            }
        } else if("notfound".equals(fail)) {
            msg = "일치하는 회원 정보가 없습니다.<br>아이디와 이메일을 확인해주세요.";
        } else if("send".equals(fail)) {
            msg = "비밀번호는 재설정되었으나<br>메일 전송에 실패했습니다.";
        } else {
            msg = "시스템 오류가 발생했습니다.<br>잠시 후 다시 시도해주세요.";
        }
        
        mav.addObject("message", msg);
        mav.addObject("isSuccess", isSuccess); // JSP에서 아이콘 분기 처리용
        
        return mav;
    }
   

    // 임시 비밀번호 생성기 (영문+숫자)
    private String generateTempPassword(int length) {
        char[] charSet = new char[] { 
            '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 
            'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' 
        };
        
        StringBuilder sb = new StringBuilder();
        int idx = 0;
        for (int i = 0; i < length; i++) {
            idx = (int) (charSet.length * Math.random());
            sb.append(charSet[idx]);
        }
        return sb.toString();
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

   // 회원가입 정보 저장 (프로필 사진 기본값 처리)
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
   
   
   // 정보 수정 
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
   
   // 마이페이지
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
                  // 날짜 처리 
                  try {
                     String dateStr = m.getMatch_date(); 
                     if(dateStr.length() > 10) dateStr = dateStr.substring(0, 10); // 시간 자르고 날짜만
                     
                     LocalDate matchDate = LocalDate.parse(dateStr);
                     
                     // '예정된' 이번 달 경기 수 카운트
                     // 조건 1: 이번 달인가?
                     if(matchDate.getYear() == today.getYear() && matchDate.getMonth() == today.getMonth()) {
                        // 조건 2: 오늘 날짜거나 오늘보다 미래인가? (지난 경기는 제외)
                        if(matchDate.isEqual(today) || matchDate.isAfter(today)) {
                           monthMatchCount++;
                        }
                     }
                     
                     // 다가오는 가장 가까운 경기 (Next Match) 찾기
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
            stats.put("my_team_count", myTeams != null ? myTeams.size() : 0);
            
            if(nextMatch != null) {
               stats.put("next_match_dday", minDaysDiff == 0 ? "Day" : minDaysDiff); // D-Day
               stats.put("next_match_opponent", nextMatch.getAway_team_name()); // 상대팀
               stats.put("next_match_date", nextMatch.getMatch_date());
            }

            // 데이터 전송
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
   
  
   // 매치/용병 신청내역 가기 
   @GetMapping("history")
   public ModelAndView match_history(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       HttpSession session = req.getSession();
       SessionInfo info = (SessionInfo) session.getAttribute("member");
       MyUtil util = new MyUtil();
       
       if(info == null) return new ModelAndView("redirect:/member/login");
       
       ModelAndView mav = new ModelAndView("member/match_history");
       
       try {
    	   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
           String nowString = sdf.format(new Date());
    	   
           long size = 5; 
           String pageStr = req.getParameter("page");
           int current_page_int = (pageStr == null || pageStr.isEmpty()) ? 1 : Integer.parseInt(pageStr);
           
           // 현재 활성화된 탭 확인
           String activeTab = req.getParameter("tab");
           if(activeTab == null || activeTab.isEmpty()) activeTab = "match";

           // ==========================================
           // 1. 매치 신청 내역 (탭이 'match'일 때만 페이지 적용)
           // ==========================================
           int matchPage = activeTab.equals("match") ? current_page_int : 1;
           int matchCount = myPageService.dataCountMatch(info.getMember_code());
           int matchTotalPage = util.pageCount(matchCount, (int)size);
           if(matchPage > matchTotalPage) matchPage = matchTotalPage;
           
           Map<String, Object> matchMap = new HashMap<>();
           long matchOffset = (matchPage - 1) * size;
           if(matchOffset < 0) matchOffset = 0;
           
           matchMap.put("member_code", info.getMember_code());
           matchMap.put("offset", matchOffset); // long 타입
           matchMap.put("size", size);          // long 타입
           
           List<MatchHistoryDTO> matchApplyList = myPageService.listMatchApply(matchMap);
           
           String matchUrl = req.getContextPath() + "/member/history?tab=match";
           String matchPaging = util.paging(matchPage, matchTotalPage, matchUrl);

           // ==========================================
           // 2. 용병 활동 내역 (탭이 'mercenary'일 때만 페이지 적용)
           // ==========================================
           int mercenaryPage = activeTab.equals("mercenary") ? current_page_int : 1;
           int mercenaryCount = myPageService.dataCountMyMercenary(info.getMember_code());
           int mercenaryTotalPage = util.pageCount(mercenaryCount, (int)size);
           if(mercenaryPage > mercenaryTotalPage) mercenaryPage = mercenaryTotalPage;
           
           Map<String, Object> mercMap = new HashMap<>();
           long mercOffset = (mercenaryPage - 1) * size;
           if(mercOffset < 0) mercOffset = 0;
           
           mercMap.put("member_code", info.getMember_code());
           mercMap.put("offset", mercOffset); // long 타입
           mercMap.put("size", size);         // long 타입
           
           List<MercenaryDTO> myMercenaryList = myPageService.listMyMercenaryPosts(mercMap);
           
           String mercenaryUrl = req.getContextPath() + "/member/history?tab=mercenary";
           String mercenaryPaging = util.paging(mercenaryPage, mercenaryTotalPage, mercenaryUrl);
           
           // 데이터 전송
           mav.addObject("activeTab", activeTab);
           mav.addObject("nowString", nowString);
           
           mav.addObject("matchApplyList", matchApplyList);
           mav.addObject("matchPaging", matchPaging);
           
           mav.addObject("myMercenaryList", myMercenaryList);
           mav.addObject("mercenaryPaging", mercenaryPaging);
           
       } catch (Exception e) {
           e.printStackTrace();
       }
       
       return mav;
   }
  
}