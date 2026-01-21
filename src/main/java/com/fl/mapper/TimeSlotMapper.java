package com.fl.mapper;

import java.util.List;
import java.util.Map;

import com.fl.model.StadiumTimeSlotDTO;

public interface TimeSlotMapper {
	
	
	public List<StadiumTimeSlotDTO> listTimeSlots(Map<String, Object> map);
	  
	
}
