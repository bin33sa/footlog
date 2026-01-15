package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.BoardMapper;
import com.fl.model.BoardDTO;
import com.fl.model.BoardReplyDTO;
import com.fl.mybatis.support.MapperContainer;

public class BoardServiceImpl implements BoardService {

    // [핵심] 매퍼를 안전하게 가져오는 메서드
    private BoardMapper getMapper() {
        return MapperContainer.get(BoardMapper.class);
    }

    @Override
    public void insertBoard(BoardDTO dto) throws Exception {
        try {
            // mapper 대신 getMapper() 사용
            getMapper().insertBoard(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateBoard(BoardDTO dto) throws Exception {
        try {
            getMapper().updateBoard(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deleteBoard(Map<String, Object> map) throws Exception {
        try {
            getMapper().deleteBoard(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public BoardDTO findById(long board_main_code) {
        BoardDTO dto = null;
        try {
            getMapper().updateHitCount(board_main_code);
            dto = getMapper().findById(board_main_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    @Override
    public List<BoardDTO> listBoard(Map<String, Object> map) {
        List<BoardDTO> list = null;
        try {
            list = getMapper().listBoard(map);
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
    public void updateHitCount(long board_main_code) throws Exception {
        try {
            getMapper().updateHitCount(board_main_code);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    // --- 댓글 관련 구현 ---

    @Override
    public void insertReply(BoardReplyDTO dto) throws Exception {
        try {
            getMapper().insertReply(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public int replyCount(Map<String, Object> map) {
        return getMapper().replyCount(map);
    }

    @Override
    public List<BoardReplyDTO> listReply(Map<String, Object> map) {
        return getMapper().listReply(map);
    }

    @Override
    public void deleteReply(Map<String, Object> map) throws Exception {
        try {
            getMapper().deleteReply(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public List<BoardReplyDTO> listReplyAnswer(Map<String, Object> map) {
        return getMapper().listReplyAnswer(map);
    }

	


	@Override
	public void insertGallery(BoardDTO dto) throws Exception {
		try {
	        // 1. 게시글 정보 저장 (gallery 테이블)
	        // mapper의 insertGallery에서 <selectKey>를 통해 dto에 gallery_code가 세팅됩니다.
	        getMapper().insertGallery(dto);

	        // 2. 파일 정보 저장 (file_gallery 테이블)
	        if (dto.getImageFilename() != null && !dto.getImageFilename().isEmpty()) {
	            getMapper().insertGalleryFile(dto);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw e;
	    }
		
	}

	
}
