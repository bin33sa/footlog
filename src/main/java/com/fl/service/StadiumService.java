package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.ArenaDTO;
import com.fl.model.PageResult;
import com.fl.model.StadiumDTO;

public interface StadiumService {

	// 구장 목록 출력
	public PageResult<StadiumDTO> listStadium(int pageNo, int size, String keyword);
	public List<StadiumDTO> listStadiumAll();
	
	
	// 구장내 경기장 목록출력 , 경기장 페이징 처리?
	public List<ArenaDTO> listArena(Map<String,Object> map);
	public int arenaCount(Map<String, Object> map);
	
	
	
	
}
