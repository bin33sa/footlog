package com.fl.service;

import java.util.List;

import com.fl.model.PageResult;
import com.fl.model.StadiumDTO;
import com.fl.model.TeamDTO;

public interface StadiumService {

	// 구장 목록 출력
	public PageResult<StadiumDTO> listStadium(int pageNo, int size, String keyword, String sort);
	public List<StadiumDTO> listStadiumAll();
	
	public StadiumDTO findById(int stadiumCode);
	
	public List<TeamDTO> findByMemberCode(long memberCode);
	

	
	
	
	
}
