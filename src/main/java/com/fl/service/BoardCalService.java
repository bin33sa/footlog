package com.fl.service;

import java.util.List;
import java.util.Map;
import com.fl.model.BoardCalDTO;

public interface BoardCalService {
    // 일정 목록 조회
    public List<BoardCalDTO> listCalendar(Map<String, Object> map);
    
    // 일정 등록
    public void insertCalendar(BoardCalDTO dto) throws Exception;
    
    // 일정 상세 조회
    public BoardCalDTO findById(long board_cal_code);
    
    // 일정 수정
    public void updateCalendar(BoardCalDTO dto) throws Exception;
    
    // 일정 삭제
    public void deleteCalendar(Map<String, Object> map) throws Exception;
}