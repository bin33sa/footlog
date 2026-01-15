package com.fl.model;

public class AdminTimeSlotDTO {
	  private long stadiumCode;
	    private String playDate;
	    private int timeCode;
	    private boolean available; // 화면용
	    
	    
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
		public boolean isAvailable() {
			return available;
		}
		public void setAvailable(boolean available) {
			this.available = available;
		}
	    
	    
}
