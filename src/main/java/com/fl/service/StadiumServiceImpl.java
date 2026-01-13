package com.fl.service;

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

		List<StadiumDTO> list;

		int pageNo = (int) map.get("pageNo");
		int size   = (int) map.get("size");

		int offset = (pageNo - 1) * size;
		map.put("offset", offset);

		try {
			list = mapper.listStadium(map);
		} catch (Exception e) {
			throw e;
		}

		return list;
	}

	@Override
	public int stadiumCount(Map<String, Object> map) {
		return mapper.stadiumCount(map);
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
