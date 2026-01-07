package com.fl.model;

public class BookingDTO {
	private Long arena_hours_code;  
    private Long arena_code;        
    private String start_time;
    private String end_time;
    private String operating_date;  
    
    private Long team_code;       
    
    private String stadium_name;   
    private String arena_name;     
    private String team_name;      
    private String region;         
    private String stadium_image;
    
    
	public Long getArena_hours_code() {
		return arena_hours_code;
	}
	public void setArena_hours_code(Long arena_hours_code) {
		this.arena_hours_code = arena_hours_code;
	}
	public Long getArena_code() {
		return arena_code;
	}
	public void setArena_code(Long arena_code) {
		this.arena_code = arena_code;
	}
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	}
	public String getOperating_date() {
		return operating_date;
	}
	public void setOperating_date(String operating_date) {
		this.operating_date = operating_date;
	}
	public Long getTeam_code() {
		return team_code;
	}
	public void setTeam_code(Long team_code) {
		this.team_code = team_code;
	}
	public String getStadium_name() {
		return stadium_name;
	}
	public void setStadium_name(String stadium_name) {
		this.stadium_name = stadium_name;
	}
	public String getArena_name() {
		return arena_name;
	}
	public void setArena_name(String arena_name) {
		this.arena_name = arena_name;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getStadium_image() {
		return stadium_image;
	}
	public void setStadium_image(String stadium_image) {
		this.stadium_image = stadium_image;
	}
    
    
    
    
}
