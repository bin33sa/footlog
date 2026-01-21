package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.AdminMypageMapper;
import com.fl.mapper.BoardQnaMapper;
import com.fl.model.BoardQnaDTO;
import com.fl.model.MemberDTO;
import com.fl.model.StadiumDTO;
import com.fl.model.TeamDTO;
import com.fl.mybatis.support.MapperContainer;

public class AdminMypageServiceImpl implements AdminMypageService {
	private AdminMypageMapper mapper = MapperContainer.get(AdminMypageMapper.class); 
	private BoardQnaMapper qnaMapper = MapperContainer.get(BoardQnaMapper.class); 
	
	
	// 구장 인서트,업데이트
	@Override
	public int InsertStadium(StadiumDTO dto) {
		int result= mapper.InsertStadium(dto);
		
		return result;
	}
	
	@Override
	public int UpdateStadium(StadiumDTO dto) {
		int result= mapper.UpdateStadium(dto);
		return result;
	}
	
	@Override
	public void DeleteStadium(Long stadiumCode) {
		mapper.DeleteStadium(stadiumCode);
	}
	
	
	
	// 전체 구단,구장,회원수 조회
	@Override
	public List<TeamDTO> CountTeamAll() {
		List<TeamDTO> list = mapper.CountTeamAll();
		
		return list;
	}

	@Override
	public List<StadiumDTO> CountStadiumAll() {
		
		List<StadiumDTO> list = mapper.CountStadiumAll();
		
		return list;
	}

	@Override
	public List<MemberDTO> CountMemberAll() {
		
		List<MemberDTO> list = mapper.CountMemberAll();
		
		return list;
	}
	
	
	// 관리 페이지
	public List<TeamDTO> ListTeamAll() {
		List<TeamDTO> list = mapper.ListTeamAll();
		
		return list;
	}
	
	public List<StadiumDTO> ListStadiumAll() {
		List<StadiumDTO> list = mapper.ListStadiumAll();
		
		return list;
	}
	
	public List<MemberDTO> ListMemberAll() {
		List<MemberDTO> list = mapper.ListMemberAll();
		
		return list;
	}
	
	
	
	//문의 게시판 조회
	 @Override
	    public List<BoardQnaDTO> listQna(Map<String, Object> map) {
	        List<BoardQnaDTO> list = null;
	        try {
	            list = qnaMapper.listQna(map);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    }

	    @Override
	    public int dataCount(Map<String, Object> map) {
	        int result = 0;
	        try {
	            result = qnaMapper.dataCount(map);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return result;
	    }

	    @Override
	    public BoardQnaDTO findByCode(long board_qna_code) {
	        BoardQnaDTO dto = null;
	        try {
	            dto = qnaMapper.findByCode(board_qna_code);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return dto;
	    }

		



}
