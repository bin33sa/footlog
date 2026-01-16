package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.BoardQnaMapper;
import com.fl.model.BoardQnaDTO;
import com.fl.mybatis.support.MapperContainer;

public class BoardQnaServiceImpl implements BoardQnaService {

    // MapperContainer를 통해 BoardQnaMapper를 가져옵니다.
    private BoardQnaMapper getMapper() {
        return MapperContainer.get(BoardQnaMapper.class);
    }

    @Override
    public void insertQna(BoardQnaDTO dto) throws Exception {
        try {
            getMapper().insertQna(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public List<BoardQnaDTO> listQna(Map<String, Object> map) {
        List<BoardQnaDTO> list = null;
        try {
            list = getMapper().listQna(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int dataCount(Map<String, Object> map) {
        int result = 0;
        try {
            result = getMapper().dataCount(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public BoardQnaDTO findByCode(long board_qna_code) {
        BoardQnaDTO dto = null;
        try {
            dto = getMapper().findByCode(board_qna_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    @Override
    public void updateQna(BoardQnaDTO dto) throws Exception {
        try {
            getMapper().updateQna(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deleteQna(long board_qna_code) throws Exception {
        try {
            getMapper().deleteQna(board_qna_code);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateAnswer(BoardQnaDTO dto) throws Exception {
        try {
            getMapper().updateAnswer(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}