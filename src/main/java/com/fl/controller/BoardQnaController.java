package com.fl.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.model.BoardQnaDTO;
import com.fl.model.SessionInfo;
import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.GetMapping;
import com.fl.mvc.annotation.PostMapping;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.view.ModelAndView;
import com.fl.service.BoardQnaService;
import com.fl.service.BoardQnaServiceImpl;
import com.fl.util.MyUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/qna/*")
public class BoardQnaController {

    private BoardQnaService service = new BoardQnaServiceImpl();
    private MyUtil util = new MyUtil();

    // ==========================================
    // 1. 문의 게시글 목록
    // ==========================================
    @GetMapping("list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ModelAndView mav = new ModelAndView("qna/list");

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

            int dataCount = service.dataCount(map);
            int total_page = util.pageCount(dataCount, size);
            current_page = Math.min(current_page, total_page);

            int offset = (current_page - 1) * size;
            map.put("offset", Math.max(offset, 0));
            map.put("size", size);

            List<BoardQnaDTO> list = service.listQna(map);

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

    // ==========================================
    // 2. 문의 등록
    // ==========================================
    @GetMapping("write")
    public ModelAndView writeForm(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }

        ModelAndView mav = new ModelAndView("qna/write");
        mav.addObject("mode", "write");
        return mav;
    }

    @PostMapping("write")
    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        if (info == null) {
            return new ModelAndView("redirect:/member/login");
        }

        try {
            BoardQnaDTO dto = new BoardQnaDTO();
            dto.setMember_code(info.getMember_code());
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setCategory(Integer.parseInt(req.getParameter("category")));
            // 초기 상태는 1(답변대기)로 설정

            service.insertQna(dto);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/qna/list");
    }

    // ==========================================
    // 3. 상세보기
    // ==========================================
    @GetMapping("article")
    public ModelAndView article(HttpServletRequest req, HttpServletResponse resp) {
        String page = req.getParameter("page");
        
        try {
            long board_qna_code = Long.parseLong(req.getParameter("board_qna_code"));
            BoardQnaDTO dto = service.findByCode(board_qna_code);

            if (dto == null) {
                return new ModelAndView("redirect:/qna/list?page=" + page);
            }

            ModelAndView mav = new ModelAndView("qna/article");
            mav.addObject("dto", dto);
            mav.addObject("page", page);
            return mav;
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/qna/list?page=" + page);
    }

    // ==========================================
    // 4. 삭제
    // ==========================================
    @GetMapping("delete")
    public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        String page = req.getParameter("page");

        try {
            long board_qna_code = Long.parseLong(req.getParameter("board_qna_code"));
            BoardQnaDTO dto = service.findByCode(board_qna_code);

            // 본인 확인 또는 관리자 확인
            if (dto != null && (dto.getMember_code().equals(info.getMember_code()) || info.getRole_level() >= 50)) {
                service.deleteQna(board_qna_code);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/qna/list?page=" + page);
    }
}