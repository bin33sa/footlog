package com.fl.mapper;

import java.util.List;
import java.util.Map;
import com.fl.model.BoardQnaDTO;

public interface BoardQnaMapper {
    // 문의 등록
    public void insertQna(BoardQnaDTO dto) throws Exception;
    
    // 문의 목록 (검색 및 페이징 포함)
    public List<BoardQnaDTO> listQna(Map<String, Object> map);
    
    // 데이터 개수 (페이징용)
    public int dataCount(Map<String, Object> map);
    
    // 상세 보기
    public BoardQnaDTO findByCode(long board_qna_code);
    
    // 문의 수정 (답변 달리기 전만 가능하게 로직 짜면 좋음)
    public void updateQna(BoardQnaDTO dto) throws Exception;
    
    // 문의 삭제
    public void deleteQna(long board_qna_code) throws Exception;
    
    // [관리자 전용] 답변 등록 및 상태 변경
    public void updateAnswer(BoardQnaDTO dto) throws Exception;
}