package com.fl.model;

public class MatchApplyDTO {
	private long apply_code;
    private long match_code;
    private long team_code;
    private String apply_date;
    private String status;
    private String team_level;
    private String team_name;
    private Long member_code; 
    
    
    public long getApply_code() {
		return apply_code;
	}
	public void setApply_code(long apply_code) {
		this.apply_code = apply_code;
	}
	public long getMatch_code() {
		return match_code;
	}
	public void setMatch_code(long match_code) {
		this.match_code = match_code;
	}
	public long getTeam_code() {
		return team_code;
	}
	public void setTeam_code(long team_code) {
		this.team_code = team_code;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getTeam_level() {
		return team_level;
	}
	public void setTeam_level(String team_level) {
		this.team_level = team_level;
	}
	public Long getMember_code() {
		return member_code;
	}
	public void setMember_code(Long member_code) {
		this.member_code = member_code;
	}
	

}
