package com.fl.model;

public class ArenaDTO {
	private Long arena_code;
    private Long stadium_code;
    private String arena_name;
    private String stadium_name;
    
	public Long getArena_code() {
		return arena_code;
	}
	public void setArena_code(Long arena_code) {
		this.arena_code = arena_code;
	}
	public Long getStadium_code() {
		return stadium_code;
	}
	public void setStadium_code(Long stadium_code) {
		this.stadium_code = stadium_code;
	}
	public String getArena_name() {
		return arena_name;
	}
	public void setArena_name(String arena_name) {
		this.arena_name = arena_name;
	}
	public String getStadium_name() {
		return stadium_name;
	}
	public void setStadium_name(String stadium_name) {
		this.stadium_name = stadium_name;
	}
}
