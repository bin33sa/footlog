package com.fl.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fl.mvc.annotation.Controller;
import com.fl.mvc.annotation.RequestMapping;
import com.fl.mvc.annotation.RequestMethod;
import com.fl.model.BoardFaqDTO;
import com.fl.model.SessionInfo;
import com.fl.service.BoardFaqService;
import com.fl.service.BoardFaqServiceImpl;
import com.fl.mvc.view.ModelAndView;

@Controller
public class BoardFaqController {
    private BoardFaqService service = new BoardFaqServiceImpl();

    // 1. FAQ 리스트 및 카테고리 필터링
    @RequestMapping(value = "/faq/list")
    public ModelAndView list(HttpServletRequest req, HttpServletResponse resp) {
        String categoryStr = req.getParameter("category");
        int category = (categoryStr == null) ? 0 : Integer.parseInt(categoryStr);

        List<BoardFaqDTO> list = service.listFaq(category);

        ModelAndView mav = new ModelAndView("faq/list");
        mav.addObject("list", list);
        mav.addObject("category", category);
        return mav;
    }

    // 2. FAQ 등록 (POST 방식)
    @RequestMapping(value = "/faq/write", method = RequestMethod.POST)
    public ModelAndView writeSubmit(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        // 관리자 권한 확인 (role_level 50 이상)
        if (info == null || info.getRole_level() < 50) {
            return new ModelAndView("redirect:/faq/list");
        }

        try {
            BoardFaqDTO dto = new BoardFaqDTO();
            dto.setMember_code(info.getMember_code());
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setCategory(Integer.parseInt(req.getParameter("category")));

            service.insertFaq(dto);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ModelAndView("redirect:/faq/list");
    }

    // 3. FAQ 삭제
    @RequestMapping(value = "/faq/delete")
    public ModelAndView delete(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        SessionInfo info = (SessionInfo) session.getAttribute("member");

        // 관리자만 삭제 가능
        if (info != null && info.getRole_level() >= 50) {
            try {
                long board_faq_code = Long.parseLong(req.getParameter("board_faq_code"));
                service.deleteFaq(board_faq_code);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return new ModelAndView("redirect:/faq/list");
    }
}