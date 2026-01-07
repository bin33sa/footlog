package com.fl.model;

public class MemberDTO {
    private Long member_code;
    private String member_id;     
    private String password;
    private String member_name;   
    private String phone_number;
    private String email;
    private String region;
    private String profile_image;
    private String preferred_position;
    private int role_level;
    private int is_deleted;
    private String deleted_at;
    
    
	public Long getMember_code() {
		return member_code;
	}
	public void setMember_code(Long member_code) {
		this.member_code = member_code;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getPreferred_position() {
		return preferred_position;
	}
	public void setPreferred_position(String preferred_position) {
		this.preferred_position = preferred_position;
	}
	public int getRole_level() {
		return role_level;
	}
	public void setRole_level(int role_level) {
		this.role_level = role_level;
	}
	public int getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(int is_deleted) {
		this.is_deleted = is_deleted;
	}
	public String getDeleted_at() {
		return deleted_at;
	}
	public void setDeleted_at(String deleted_at) {
		this.deleted_at = deleted_at;
	}

    
}