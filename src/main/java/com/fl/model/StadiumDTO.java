package com.fl.model;

public class StadiumDTO {
	private Long stadium_code;    
    private String stadium_name;  
    private String region;        
    private String phone_number;  
    private String description;   
    private String intro_url;     
    private String stadium_image; 

    private int like_count;  
    private int arena_count; 
    private int user_liked;
    
	public Long getStadium_code() {
		return stadium_code;
	}
	public void setStadium_code(Long stadium_code) {
		this.stadium_code = stadium_code;
	}
	public String getStadium_name() {
		return stadium_name;
	}
	public void setStadium_name(String stadium_name) {
		this.stadium_name = stadium_name;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIntro_url() {
		return intro_url;
	}
	public void setIntro_url(String intro_url) {
		this.intro_url = intro_url;
	}
	public String getStadium_image() {
		return stadium_image;
	}
	public void setStadium_image(String stadium_image) {
		this.stadium_image = stadium_image;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getArena_count() {
		return arena_count;
	}
	public void setArena_count(int arena_count) {
		this.arena_count = arena_count;
	}
	public int getUser_liked() {
		return user_liked;
	}
	public void setUser_liked(int user_liked) {
		this.user_liked = user_liked;
	}
    
    
}
