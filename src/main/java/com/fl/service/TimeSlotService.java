package com.fl.service;

import java.util.List;

import com.fl.model.StadiumTimeSlotDTO;

public interface TimeSlotService {

	
	public List<StadiumTimeSlotDTO> TimeSlots(
			long stadiumCode,String playDate, String dayType) ;
	
	
	
	public boolean isWeekend(String date);
	
}
