package com.fl.model;

public class JoinRequestDTO {
	private Long member_code;
    private Long team_code;
    private int status;            

    private String member_name;
    private String member_id;
    private String profile_image;
    private String preferred_position;
    private String phone_number;
   
    private String team_name;
    private String created_at;
    
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

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public String getTeam_name() {
		return team_name;
	}

	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
    
    
}
