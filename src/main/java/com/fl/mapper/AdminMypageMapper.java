package com.fl.mapper;

import java.util.List;

import com.fl.model.MemberDTO;
import com.fl.model.StadiumDTO;
import com.fl.model.TeamDTO;

public interface AdminMypageMapper {

	public List<TeamDTO> CountTeamAll();
	public List<StadiumDTO> CountStadiumAll();
	public List<MemberDTO> CountMemberAll();
	  
	
	
}
