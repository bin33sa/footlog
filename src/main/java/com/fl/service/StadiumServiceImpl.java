package com.fl.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.mapper.StadiumMapper;

import com.fl.model.PageResult;
import com.fl.model.StadiumDTO;
import com.fl.mybatis.support.MapperContainer;

public class StadiumServiceImpl implements StadiumService {
	private StadiumMapper mapper = MapperContainer.get(StadiumMapper.class); 
	
	
	 public StadiumDTO findById(int stadiumCode){
	
		 StadiumDTO dto = mapper.findById(stadiumCode);
		 
		 
		 return dto;
	 }
	
	
	//전체리스트 불러오기
	@Override
	public List<StadiumDTO> listStadiumAll() {
		
		List<StadiumDTO> list = mapper.listStadiumAll();
		
		
		return list;
	}
	
	@Override
	public PageResult<StadiumDTO> listStadium(int pageNo, int size, String keyword, String sort) {
		
		int offset = (pageNo - 1) * size;
		
		Map<String,Object> map = new HashMap<>();
		map.put("offset", offset);
		map.put("size", size);
		map.put("keyword", keyword);
		map.put("sort", sort);
		
		List<StadiumDTO> list = mapper.listStadium(map);
		int dataCount = mapper.stadiumCount(map);
		
		int totalPage = (int) Math.ceil((double) dataCount / size);

		return new PageResult<>(list, pageNo, totalPage, dataCount); 
	}

	


	@Override
	public int arenaCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

}
