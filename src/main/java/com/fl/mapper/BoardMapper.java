package com.fl.mapper;

import java.sql.SQLException;

import java.util.List;
import java.util.Map;

import com.fl.model.BoardDTO;
import com.fl.model.BoardReplyDTO;




public interface BoardMapper {
	
    public void insertBoard(BoardDTO dto) throws SQLException;
    public void updateBoard(BoardDTO dto) throws SQLException;
    public void deleteBoard(Map<String, Object> map) throws SQLException;
    public void updateHitCount(long board_main_code) throws SQLException;
    public BoardDTO findById(long board_main_code);
    
    public List<BoardDTO> listBoard(Map<String, Object> map);
    public List<BoardDTO> listTeam(Map<String, Object> map);    
    public int dataCount(Map<String, Object> map);
    
    public void insertReply(BoardReplyDTO dto) throws Exception;
    public int replyCount(Map<String, Object> map);
    public List<BoardReplyDTO> listReply(Map<String, Object> map);
    public void deleteReply(Map<String, Object> map) throws Exception;
    public List<BoardReplyDTO> listReplyAnswer(Map<String, Object> map);
	public void insertGalleryFile(BoardDTO dto);
	public void insertGallery(BoardDTO dto);
    
}