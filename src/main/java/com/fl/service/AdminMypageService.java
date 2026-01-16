package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.BoardQnaDTO;
import com.fl.model.MemberDTO;
import com.fl.model.StadiumDTO;
import com.fl.model.TeamDTO;

public interface AdminMypageService {
	
	//전체 구단,구장,회원 수
	public List<TeamDTO> CountTeamAll();
	public List<StadiumDTO> CountStadiumAll();
	public List<MemberDTO> CountMemberAll();
	
	public List<TeamDTO> ListTeamAll();
	
	// 문의게시판 관련
    public List<BoardQnaDTO> listQna(Map<String, Object> map);
    public int dataCount(Map<String, Object> map);
    public BoardQnaDTO findByCode(long board_qna_code);
    
    
    
}
