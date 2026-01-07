package com.fl.model;

public class ScheduleDTO {
	private Long board_cal_code;
    private Long member_code;     
    private Long team_code;       
    private Long match_code;      
    private String start_date;    
    private String end_date;      
    private String title;         
    private String content;       
    private String created_at;

    private String member_name;

	public Long getBoard_cal_code() {
		return board_cal_code;
	}

	public void setBoard_cal_code(Long board_cal_code) {
		this.board_cal_code = board_cal_code;
	}

	public Long getMember_code() {
		return member_code;
	}

	public void setMember_code(Long member_code) {
		this.member_code = member_code;
	}

	public Long getTeam_code() {
		return team_code;
	}

	public void setTeam_code(Long team_code) {
		this.team_code = team_code;
	}

	public Long getMatch_code() {
		return match_code;
	}

	public void setMatch_code(Long match_code) {
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

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
    
    
}
