package com.fl.controller;

import java.io.IOException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.BoardCalDTO;
import com.fl.model.SessionInfo;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.annotation.ResponseBody;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.BoardCalService;
import com.fl.service.BoardCalServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/calendar/*")
public class BoardCalController {

	private BoardCalService service = new BoardCalServiceImpl();
	
	@RequestMapping("match_calendar")
	public ModelAndView matchCalendar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    return new ModelAndView("calendar/match_calendar");
	}
	
	// 1. 캘린더 메인 화면 이동
	@GetMapping("list")
	public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// calendar/list.jsp로 이동
		return new ModelAndView("calendar/match_calendar");
	}

	// 2. 일정 데이터를 JSON으로 반환 (AJAX - FullCalendar 호출용)
	
	@GetMapping("load")
	public ModelAndView load(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    String start = req.getParameter("start");
	    String end = req.getParameter("end");

	    Map<String, Object> map = new HashMap<>();
	    map.put("start", start);
	    map.put("end", end);

	    List<BoardCalDTO> list = service.listCalendar(map);

	    // [중요] 반드시 ModelAndView를 리턴해야 에러가 나지 않습니다.
	    // calendar/data.jsp 라는 이름의 뷰를 생성하여 list를 넘겨줍니다.
	    ModelAndView mav = new ModelAndView("calendar/data"); 
	    mav.addObject("list", list);
	    return mav; 
	}

	// 3. 일정 등록 (AJAX - Post)
	@PostMapping("insert")
	@ResponseBody
	public Map<String, Object> insertSubmit(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> model = new HashMap<>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			model.put("state", "loginFail");
			return model;
		}

		String state = "false";
		try {
			BoardCalDTO dto = new BoardCalDTO();
			
			dto.setMember_code(info.getMember_code());
			dto.setTitle(req.getParameter("title"));
			dto.setContent(req.getParameter("content"));
			dto.setStart_date(req.getParameter("start_date"));
			dto.setEnd_date(req.getParameter("end_date"));
			
			// team_code나 match_code가 파라미터로 넘어올 경우 처리
			String teamStr = req.getParameter("team_code");
			if(teamStr != null && !teamStr.isEmpty()) {
				dto.setTeam_code(Long.parseLong(teamStr));
			}

			service.insertCalendar(dto);
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("state", state);
		return model;
	}
	
	@PostMapping("update")
	@ResponseBody
	public Map<String, Object> updateSubmit(HttpServletRequest req, HttpServletResponse resp) {
	    Map<String, Object> model = new HashMap<>();
	    
	    HttpSession session = req.getSession();
	    SessionInfo info = (SessionInfo) session.getAttribute("member");

	    if (info == null) {
	        model.put("state", "loginFail");
	        return model;
	    }

	    String state = "false";
	    try {
	        BoardCalDTO dto = new BoardCalDTO();
	        
	        // JS에서 formData.id로 보낸 값을 받아서
	        String idStr = req.getParameter("id");
	        if(idStr != null && !idStr.isEmpty()) {
	            // DTO의 실제 필드명인 board_cal_code에 넣어줍니다.
	            dto.setBoard_cal_code(Long.parseLong(idStr)); 
	        }

	        dto.setMember_code(info.getMember_code());
	        dto.setTitle(req.getParameter("title"));
	        dto.setContent(req.getParameter("content"));
	        dto.setStart_date(req.getParameter("start_date"));
	        dto.setEnd_date(req.getParameter("end_date"));

	        // 수정 서비스 호출
	        service.updateCalendar(dto);
	        state = "true";
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    model.put("state", state);
	    return model;
	}
	
	// 4. 일정 삭제 (AJAX - Post)
	@PostMapping("delete")
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> model = new HashMap<>();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		if (info == null) {
			model.put("state", "loginFail");
			return model;
		}

		String state = "false";
		try {
			long board_cal_code = Long.parseLong(req.getParameter("board_cal_code"));

			Map<String, Object> map = new HashMap<>();
			map.put("board_cal_code", board_cal_code);
			map.put("member_code", info.getMember_code());

			service.deleteCalendar(map);
			state = "true";
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.put("state", state);
		return model;
	}
}