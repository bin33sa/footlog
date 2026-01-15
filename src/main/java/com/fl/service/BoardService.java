package com.fl.service;
import java.util.List;
import java.util.Map;

import com.fl.model.BoardDTO;
import com.fl.model.BoardReplyDTO;

public interface BoardService {
    
    // 1. 게시글 관련 비즈니스 로직
    public void insertBoard(BoardDTO dto) throws Exception;
    public void updateBoard(BoardDTO dto) throws Exception;
    public void deleteBoard(Map<String, Object> map) throws Exception;
    public void insertGallery(BoardDTO dto) throws Exception;
    // board_main_code를 사용하여 상세 정보 조회
    public BoardDTO findById(long board_main_code);
    // 메인 게시판 리스트 조회 (카테고리 필터링 포함 가능)
    public List<BoardDTO> listBoard(Map<String, Object> map);
    public int dataCount(Map<String, Object> map);
    
    // 조회수 증가 로직
    public void updateHitCount(long board_main_code) throws Exception;
    
    // 2. 댓글 관련 비즈니스 로직
    public void insertReply(BoardReplyDTO dto) throws Exception;
    public int replyCount(Map<String, Object> map);
    public List<BoardReplyDTO> listReply(Map<String, Object> map);
    public void deleteReply(Map<String, Object> map) throws Exception;
    
    // 답글(대댓글) 목록 조회
    public List<BoardReplyDTO> listReplyAnswer(Map<String, Object> map);
	
}