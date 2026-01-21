package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.BoardQnaDTO;
import com.fl.model.MemberDTO;
import com.fl.model.StadiumDTO;
import com.fl.model.TeamDTO;

public interface AdminMypageService {
	
	//구장 업데이트
	public int UpdateStadium(StadiumDTO dto);
	public int InsertStadium(StadiumDTO dto);
	
	//구장 삭제
	public void DeleteStadium(Long stadiumCode);
	
	
	//전체 구단,구장,회원 수
	public List<TeamDTO> CountTeamAll();
	public List<StadiumDTO> CountStadiumAll();
	public List<MemberDTO> CountMemberAll();
	
	public List<TeamDTO> ListTeamAll();
	public List<StadiumDTO> ListStadiumAll();
	public List<MemberDTO> ListMemberAll();
	
	// 문의게시판 관련
    public List<BoardQnaDTO> listQna(Map<String, Object> map);
    public int dataCount(Map<String, Object> map);
    public BoardQnaDTO findByCode(long board_qna_code);
    
    
    
}
