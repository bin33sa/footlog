package com.fl.model;

public class StadiumReservationDTO {
	 	private long reservationId;
	    private long stadiumCode;
	    private long memberCode;
	    private String playDate;   // yyyy-MM-dd
	    private int timeCode;
	    private String timeLabel;  // 10:00
	    private String reservedAt; // 예약 시각
	    
	    
		public long getReservationId() {
			return reservationId;
		}
		public void setReservationId(long reservationId) {
			this.reservationId = reservationId;
		}
		public long getStadiumCode() {
			return stadiumCode;
		}
		public void setStadiumCode(long stadiumCode) {
			this.stadiumCode = stadiumCode;
		}
		public long getMemberCode() {
			return memberCode;
		}
		public void setMemberCode(long memberCode) {
			this.memberCode = memberCode;
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
		public String getReservedAt() {
			return reservedAt;
		}
		public void setReservedAt(String reservedAt) {
			this.reservedAt = reservedAt;
		}

	    
	    
	    
}
