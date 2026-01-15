package com.fl.model;

public class StadiumTimeSlotDTO {
	private long slotId;
	private long stadiumCode;
	private String playDate;
	private int timeCode;
	private String timeLabel; // time_code 조인용
	private String availableYn; // Y / N
	
	
	public long getSlotId() {
		return slotId;
	}
	public void setSlotId(long slotId) {
		this.slotId = slotId;
	}
	public long getStadiumCode() {
		return stadiumCode;
	}
	public void setStadiumCode(long stadiumCode) {
		this.stadiumCode = stadiumCode;
	}
	public String getPlayDate() {
		return playDate;
	}
	public void setPlayDate(String playDate) {
		this.playDate = playDate;
	}
	public int getTimeCode() {
		return timeCode;
	}
	public void setTimeCode(int timeCode) {
		this.timeCode = timeCode;
	}
	public String getTimeLabel() {
		return timeLabel;
	}
	public void setTimeLabel(String timeLabel) {
		this.timeLabel = timeLabel;
	}
	public String getAvailableYn() {
		return availableYn;
	}
	public void setAvailableYn(String availableYn) {
		this.availableYn = availableYn;
	}
	
	
	
}
