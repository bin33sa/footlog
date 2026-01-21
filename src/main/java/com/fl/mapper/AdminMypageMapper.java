package com.fl.mapper;

import java.util.List;

import com.fl.model.MemberDTO;
import com.fl.model.StadiumDTO;
import com.fl.model.TeamDTO;

public interface AdminMypageMapper {

	public List<TeamDTO> CountTeamAll();
	public List<TeamDTO> ListTeamAll();
	
	public List<StadiumDTO> CountStadiumAll();
	public List<StadiumDTO> ListStadiumAll();
	
	public List<MemberDTO> CountMemberAll();
	public List<MemberDTO> ListMemberAll();
	
	public int UpdateStadium(StadiumDTO dto);
	public int InsertStadium(StadiumDTO dto);
	public void DeleteStadium(Long stadiumCode);
	
}
