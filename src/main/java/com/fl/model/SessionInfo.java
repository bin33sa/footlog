package com.fl.model;

public class SessionInfo {
    private Long member_code;
    private String member_id;
    private String member_name;
    private int role_level;
    private String profile_image;
    private String email;
    private String phone_number;
    private String region;
    
    public Long getMember_code() { return member_code; }
    public void setMember_code(Long member_code) { this.member_code = member_code; }
    
    public String getMember_id() { return member_id; }
    public void setMember_id(String member_id) { this.member_id = member_id; }
    
    public String getMember_name() { return member_name; }
    public void setMember_name(String member_name) { this.member_name = member_name; }
    
    public int getRole_level() { return role_level; }
    public void setRole_level(int role_level) { this.role_level = role_level; }
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	
  
}