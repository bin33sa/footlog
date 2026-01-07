package com.fl.model;

public class MercenaryApplyDTO {
	private Long apply_id;       
    private Long member_code;    
    private Long recruit_id;     
    private int status;          

    private String member_name;  
    private String member_id;    
    private String phone_number; 
    private String preferred_position; 
    private String profile_image;      
    private int role_level;            

    private String title;    
    private String created_at;
    
	public Long getApply_id() {
		return apply_id;
	}
	public void setApply_id(Long apply_id) {
		this.apply_id = apply_id;
	}
	public Long getMember_code() {
		return member_code;
	}
	public void setMember_code(Long member_code) {
		this.member_code = member_code;
	}
	public Long getRecruit_id() {
		return recruit_id;
	}
	public void setRecruit_id(Long recruit_id) {
		this.recruit_id = recruit_id;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public String getPreferred_position() {
		return preferred_position;
	}
	public void setPreferred_position(String preferred_position) {
		this.preferred_position = preferred_position;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public int getRole_level() {
		return role_level;
	}
	public void setRole_level(int role_level) {
		this.role_level = role_level;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
    
    
    
}
