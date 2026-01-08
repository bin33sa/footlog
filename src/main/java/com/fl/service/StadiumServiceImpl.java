package com.fl.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fl.mapper.StadiumMapper;
import com.fl.model.ArenaDTO;
import com.fl.model.StadiumDTO;
import com.fl.mybatis.support.MapperContainer;

public class StadiumServiceImpl implements StadiumService {
	private StadiumMapper mapper = MapperContainer.get(StadiumMapper.class); 
	
	
	@Override
	public List<StadiumDTO> listStadium(Map<String, Object> map) {
		
		List<StadiumDTO> list = new ArrayList<StadiumDTO>();
		
		try {
			list = mapper.listStadium(map);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
		
		return list;
		
	}

	@Override
	public int stadiumCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ArenaDTO> listArena(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int arenaCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}
