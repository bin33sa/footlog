package com.fl.mapper;

import java.util.List;
import java.util.Map;

import com.fl.model.StadiumDTO;

public interface StadiumMapper {

	  public List<StadiumDTO> listStadium(Map<String, Object> map);
	  public List<StadiumDTO> listStadiumAll();
	  
	  public StadiumDTO findById(int stadiumCode);
	  
	  int stadiumCount(Map<String, Object> map);
}
