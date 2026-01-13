package com.fl.model;

public class StadiumDTO {
	private Long stadium_code;    
    private String stadium_name;  
    private String region;        
    private String phoneNumber;  
    private String description;   
    private String introUrl;     
    private String stadium_image; 

    private int likeCount;  
    private int arenaCount; 
    private int userLiked;
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
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIntroUrl() {
		return introUrl;
	}
	public void setIntroUrl(String introUrl) {
		this.introUrl = introUrl;
	}
	public String getStadium_image() {
		return stadium_image;
	}
	public void setStadium_image(String stadium_image) {
		this.stadium_image = stadium_image;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public int getArenaCount() {
		return arenaCount;
	}
	public void setArenaCount(int arenaCount) {
		this.arenaCount = arenaCount;
	}
	public int getUserLiked() {
		return userLiked;
	}
	public void setUserLiked(int userLiked) {
		this.userLiked = userLiked;
	}
	
    
    
}
