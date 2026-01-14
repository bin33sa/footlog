package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.BoardMapper; // BbsMapper로 변경
import com.fl.model.BoardDTO;   // BoardDTO로 변경
import com.fl.model.BoardReplyDTO; // BoardReplyDTO로 변경
import com.fl.mybatis.support.MapperContainer;

public class BoardServiceImpl implements BoardService { // BoardService 구현
    private BoardMapper mapper = MapperContainer.get(BoardMapper.class);

    @Override
    public void insertBoard(BoardDTO dto) throws Exception {
        try {
            mapper.insertBoard(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateBoard(BoardDTO dto) throws Exception {
        try {
            mapper.updateBoard(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deleteBoard(Map<String, Object> map) throws Exception {
        try {
            mapper.deleteBoard(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public BoardDTO findById(long board_main_code) {
        BoardDTO dto = null;
        try {
            // 상세 보기 시 조회수 증가 로직을 서비스에서 처리 (실시간 반영)
            mapper.updateHitCount(board_main_code);
            dto = mapper.findById(board_main_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    @Override
    public List<BoardDTO> listBoard(Map<String, Object> map) {
        List<BoardDTO> list = null;
        try {
            list = mapper.listBoard(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int dataCount(Map<String, Object> map) {
        int result = 0;
        try {
            result = mapper.dataCount(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public void updateHitCount(long board_main_code) throws Exception {
        try {
            mapper.updateHitCount(board_main_code);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    // --- 댓글 관련 구현 ---

    @Override
    public void insertReply(BoardReplyDTO dto) throws Exception {
        try {
            mapper.insertReply(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public int replyCount(Map<String, Object> map) {
        return mapper.replyCount(map);
    }

    @Override
    public List<BoardReplyDTO> listReply(Map<String, Object> map) {
        return mapper.listReply(map);
    }

    @Override
    public void deleteReply(Map<String, Object> map) throws Exception {
        try {
            mapper.deleteReply(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public List<BoardReplyDTO> listReplyAnswer(Map<String, Object> map) {
        return mapper.listReplyAnswer(map);
    }
}