package com.fl.service;

import java.util.List;
import java.util.Map;
import com.fl.model.BoardQnaDTO;

public interface BoardQnaService {
    // 문의 작성
    public void insertQna(BoardQnaDTO dto) throws Exception;
    
    // 문의 목록 조회
    public List<BoardQnaDTO> listQna(Map<String, Object> map);
    
    // 데이터 총 개수
    public int dataCount(Map<String, Object> map);
    
    // 상세 내용 보기
    public BoardQnaDTO findByCode(long board_qna_code);
    
    // 문의 수정
    public void updateQna(BoardQnaDTO dto) throws Exception;
    
    // 문의 삭제
    public void deleteQna(long board_qna_code) throws Exception;
    
    // 관리자 답변 등록/수정
    public void updateAnswer(BoardQnaDTO dto) throws Exception;
}