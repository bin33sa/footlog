package com.fl.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fl.model.BoardCalDTO;

@Mapper
public interface BoardCalMapper {

    // 1. 일정 목록 조회 (시작일/종료일 범위 조건 포함)
    public List<BoardCalDTO> listCalendar(Map<String, Object> map);

    // 2. 일정 등록
    public void insertCalendar(BoardCalDTO dto) throws Exception;

    // 3. 일정 상세 정보 조회 (수정/삭제 시 또는 클릭 이벤트 시)
    public BoardCalDTO findById(long board_cal_code);

    // 4. 일정 수정
    public void updateCalendar(BoardCalDTO dto) throws Exception;

    // 5. 일정 삭제
    public void deleteCalendar(Map<String, Object> map) throws Exception;

}