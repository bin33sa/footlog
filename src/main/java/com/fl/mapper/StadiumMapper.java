package com.fl.mapper;

import java.util.List;
import java.util.Map;

import com.fl.model.StadiumDTO;
import com.fl.model.StadiumReservationDTO;
import com.fl.model.TeamDTO;

public interface StadiumMapper {

	  public List<StadiumDTO> listStadium(Map<String, Object> map);
	  public List<StadiumDTO> listStadiumAll();
	  
	  public StadiumDTO findById(int stadiumCode);
	  
	  public List<TeamDTO> findByMemberCode(long memberCode);
	  
	  
	  public int stadiumCount(Map<String, Object> map);
	  
	  
	  
}
