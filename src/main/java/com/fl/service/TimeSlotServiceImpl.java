package com.fl.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.mapper.TimeSlotMapper;
import com.fl.model.StadiumTimeSlotDTO;
import com.fl.mybatis.support.MapperContainer;

public class TimeSlotServiceImpl implements TimeSlotService{
	private TimeSlotMapper mapper = MapperContainer.get(TimeSlotMapper.class);
	
	//해당 구장 타임슬롯 불러오기
	@Override
	public List<StadiumTimeSlotDTO> TimeSlots(
				long stadiumCode, String playDate) {
		
		try {
			Map<String,Object> map = new HashMap<>();
			map.put("stadiumCode", stadiumCode);
			map.put("playDate", playDate);
			
			List<StadiumTimeSlotDTO> list = mapper.listTimeSlots(map);
			
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}

}
