package com.fl.model;

public class TeamDTO {
	private Long team_code;          
    private String team_name;        
    private String team_url;         
    private String contact_number;   
    private String region;           
    private String description;      
    private String created_at;       
    private String emblem_image;     
    private String intro_video_url;  

    private int member_count;      
    private int like_count;      
    
    private int my_role;      
    private int user_liked;
    
	public Long getTeam_code() {
		return team_code;
	}
	public void setTeam_code(Long team_code) {
		this.team_code = team_code;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getTeam_url() {
		return team_url;
	}
	public void setTeam_url(String team_url) {
		this.team_url = team_url;
	}
	public String getContact_number() {
		return contact_number;
	}
	public void setContact_number(String contact_number) {
		this.contact_number = contact_number;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getEmblem_image() {
		return emblem_image;
	}
	public void setEmblem_image(String emblem_image) {
		this.emblem_image = emblem_image;
	}
	public String getIntro_video_url() {
		return intro_video_url;
	}
	public void setIntro_video_url(String intro_video_url) {
		this.intro_video_url = intro_video_url;
	}
	public int getMember_count() {
		return member_count;
	}
	public void setMember_count(int member_count) {
		this.member_count = member_count;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public int getMy_role() {
		return my_role;
	}
	public void setMy_role(int my_role) {
		this.my_role = my_role;
	}
	public int getUser_liked() {
		return user_liked;
	}
	public void setUser_liked(int user_liked) {
		this.user_liked = user_liked;
	}
    
    
}
