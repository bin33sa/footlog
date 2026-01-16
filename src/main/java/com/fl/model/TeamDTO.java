package com.fl.model;

public class TeamDTO {
	private Long team_code; // 구단 코드     
    private String team_name; // 구단 명   
    private String team_url; // 구단 URL
    private String contact_number; // 구단 대표 연락처
    private String region; // 활동 지역           
    private String description; // 구단 소개글     
    private String created_at; // 구단 생성일
    private String emblem_image; // 엠블럼 이미지
    private String intro_video_url; // 구단 소개 영상 URL
    
    private int status;          // 상태 (0:삭제, 1:정상)
    private String deleted_at;	 // 삭제(비활성화)된 날짜
    private int role_level; // 구단 역할 레벨 (구단장:10/매니저:5/일반:1)
    private String position; // 구단 포지션
    private int back_number; // 등번호
    private String reg_date; // 등록날짜(구단등록)
    private String profile_image; // 구단내 프로필 이미지
    
    private String leader_name; // 구단장 이름(표시하고싶어서 추가함..)

    private int member_count;      
    private int like_count;        
    private int user_liked; // 좋아요
    
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
	public int getUser_liked() {
		return user_liked;
	}
	public void setUser_liked(int user_liked) {
		this.user_liked = user_liked;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDeleted_at() {
		return deleted_at;
	}
	public void setDeleted_at(String deleted_at) {
		this.deleted_at = deleted_at;
	}
	public int getRole_level() {
		return role_level;
	}
	public void setRole_level(int role_level) {
		this.role_level = role_level;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public int getBack_number() {
		return back_number;
	}
	public void setBack_number(int back_number) {
		this.back_number = back_number;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public String getLeader_name() {
		return leader_name;
	}
	public void setLeader_name(String leader_name) {
		this.leader_name = leader_name;
	}
    
    
}
