package com.fl.model;

public class BoardCalDTO {
    private long board_cal_code;  // 게시판코드 (PK)
    private long member_code;     // 회원코드
    private long team_code;       // 구단코드
    private long match_code;      // 매치코드
    private String start_date;    // 시작일 (FullCalendar용)
    private String end_date;      // 종료일
    private String title;         // 일정제목
    private String content;       // 내용
    private String created_at;    // 작성일
    
    private String match_title;    // 매치 게시판 제목
    private String stadium_name;   // 경기장 이름
    private String status;
    
    public String getMatch_title() {
		return match_title;
	}
	public void setMatch_title(String match_title) {
		this.match_title = match_title;
	}
	public String getStadium_name() {
		return stadium_name;
	}
	public void setStadium_name(String stadium_name) {
		this.stadium_name = stadium_name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	// FullCalendar 라이브러리가 인식하는 기본 필드명 추가 (편의성)
    private String start;         // start_date 대용
    private String end;           // end_date 대용
    
    
	public long getBoard_cal_code() {
		return board_cal_code;
	}
	public void setBoard_cal_code(long board_cal_code) {
		this.board_cal_code = board_cal_code;
	}
	public long getMember_code() {
		return member_code;
	}
	public void setMember_code(long member_code) {
		this.member_code = member_code;
	}
	public long getTeam_code() {
		return team_code;
	}
	public void setTeam_code(long team_code) {
		this.team_code = team_code;
	}
	public long getMatch_code() {
		return match_code;
	}
	public void setMatch_code(long match_code) {
		this.match_code = match_code;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
  
}