package com.fl.mapper;

import java.util.List;
import java.util.Map;

import com.fl.model.StadiumReservationDTO;
import com.fl.model.StadiumTimeSlotDTO;

public interface TimeSlotMapper {
	
	
	public List<StadiumTimeSlotDTO> listTimeSlots(Map<String, Object> map);
	  
	  public int InsertReservation(StadiumReservationDTO dto);

	  
	public List<StadiumReservationDTO> BookingFindById(long memberCode);
	public List<StadiumReservationDTO> BookingList();
	
	
	public void DeleteTimeSlot(long reservationId);
}
