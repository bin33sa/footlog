package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.BoardCalMapper;
import com.fl.model.BoardCalDTO;
import com.fl.mybatis.support.MapperContainer;

public class BoardCalServiceImpl implements BoardCalService {
    
    // [수정] 필드에서 즉시 할당하지 않고 메서드를 통해 안전하게 가져옵니다.
    private BoardCalMapper getMapper() {
        return MapperContainer.get(BoardCalMapper.class);
    }

    @Override
    public List<BoardCalDTO> listCalendar(Map<String, Object> map) {
        List<BoardCalDTO> list = null;
        try {
            // getMapper()를 사용하여 주입 실패 시 전이 에러 방지
            list = getMapper().listCalendar(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public void insertCalendar(BoardCalDTO dto) throws Exception {
        try {
            getMapper().insertCalendar(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public BoardCalDTO findById(long board_cal_code) {
        BoardCalDTO dto = null;
        try {
            dto = getMapper().findById(board_cal_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    @Override
    public void updateCalendar(BoardCalDTO dto) throws Exception {
        try {
            getMapper().updateCalendar(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deleteCalendar(Map<String, Object> map) throws Exception {
        try {
            getMapper().deleteCalendar(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
}