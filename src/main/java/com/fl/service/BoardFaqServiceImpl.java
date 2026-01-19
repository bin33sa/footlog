package com.fl.service;

import java.util.List;
import com.fl.mapper.BoardFaqMapper;
import com.fl.model.BoardFaqDTO;
import com.fl.mybatis.support.MapperContainer;

public class BoardFaqServiceImpl implements BoardFaqService {

    // MapperContainer를 통해 BoardFaqMapper를 가져옵니다.
    private BoardFaqMapper getMapper() {
        return MapperContainer.get(BoardFaqMapper.class);
    }

    @Override
    public void insertFaq(BoardFaqDTO dto) throws Exception {
        try {
            getMapper().insertFaq(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public List<BoardFaqDTO> listFaq(int category) {
        List<BoardFaqDTO> list = null;
        try {
            // FAQ는 대개 페이지네이션 없이 카테고리별 전체 조회를 많이 합니다.
            list = getMapper().listFaq(category);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void deleteFaq(long board_faq_code) throws Exception {
        try {
            getMapper().deleteFaq(board_faq_code);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}