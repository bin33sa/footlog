package com.fl.model;

public class StadiumTimeSlotDTO {
	private long stadiumCode;
	private long timeCode;
	private String timeLabel; // time_code 조인용
	private String dayType;
	private String availableYn;
	
	
	public String getAvailableYn() {
		return availableYn;
	}
	public void setAvailableYn(String availableYn) {
		this.availableYn = availableYn;
	}
	public long getStadiumCode() {
		return stadiumCode;
	}
	public void setStadiumCode(long stadiumCode) {
		this.stadiumCode = stadiumCode;
	}
	public long getTimeCode() {
		return timeCode;
	}
	public void setTimeCode(long timeCode) {
		this.timeCode = timeCode;
	}
	public String getTimeLabel() {
		return timeLabel;
	}
	public void setTimeLabel(String timeLabel) {
		this.timeLabel = timeLabel;
	}
	public String getDayType() {
		return dayType;
	}
	public void setDayType(String dayType) {
		this.dayType = dayType;
	}
	
	
	
	
	
}
