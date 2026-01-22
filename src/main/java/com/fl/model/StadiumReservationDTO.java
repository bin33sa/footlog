package com.fl.model;

public class StadiumReservationDTO {
	 	private long reservationId;
	    private long stadiumCode;
	    private long memberCode;
	    private long teamCode;
	    
	    private String playDate;   // yyyy-MM-dd
	    private long timeCode;
	    private String timeLabel;  // 10:00
	    private String reservedAt; // 예약 시각
	    
	    private String stadiumName;
	    private String teamName;
	    private String memberName;
	    
	    private int matchCount;
	    
		public String getStadiumName() {
			return stadiumName;
		}
		public void setStadiumName(String stadiumName) {
			this.stadiumName = stadiumName;
		}
		public String getTeamName() {
			return teamName;
		}
		public void setTeamName(String teamName) {
			this.teamName = teamName;
		}
		public String getMemberName() {
			return memberName;
		}
		public void setMemberName(String memberName) {
			this.memberName = memberName;
		}
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
		public long getTeamCode() {
			return teamCode;
		}
		public void setTeamCode(long teamCode) {
			this.teamCode = teamCode;
		}
		public String getPlayDate() {
			return playDate;
		}
		public void setPlayDate(String playDate) {
			this.playDate = playDate;
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
		public String getReservedAt() {
			return reservedAt;
		}
		public void setReservedAt(String reservedAt) {
			this.reservedAt = reservedAt;
		}
		public int getMatchCount() {
			return matchCount;
		}
		public void setMatchCount(int matchCount) {
			this.matchCount = matchCount;
		}
	    
	    
	    
	    
}
