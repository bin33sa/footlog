package com.fl.model;

// 매치/용병 신청내역(마이페이지에뜸)
public class MatchHistoryDTO {
	//매치 신청 
    private long apply_code;     // PK
    private long match_code;     // FK
    private String status;       // 상태 (String: '대기중', '승인')
    
    //용병 신청 
    private long apply_id;       // PK
    private long recruit_id;     // FK
    private int recruit_status;  // 상태 (int: 0, 1, 2) ★ DB컬럼 status와 매핑
    
    private String team_name;
    private long member_code;    // 신청자
    private String opponent_name;   // 상대팀 이름
    private String region;       // 지역 (team 테이블)
    
    //게시글 정보
    private String title;        // 제목 (mercenary_post)
    private String match_date;   // 경기일 (match_post)
    private String created_at;   // 작성일 (mercenary_post)
    private String sort_date;    // 정렬
    
    private String team_emblem;      // 내 팀(혹은 신청한 팀) 엠블럼
    private String opponent_emblem;  // 상대 팀 엠블럼
    
	public long getApply_code() {
		return apply_code;
	}
	public void setApply_code(long apply_code) {
		this.apply_code = apply_code;
	}
	public long getMatch_code() {
		return match_code;
	}
	public void setMatch_code(long match_code) {
		this.match_code = match_code;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public long getApply_id() {
		return apply_id;
	}
	public void setApply_id(long apply_id) {
		this.apply_id = apply_id;
	}
	public long getRecruit_id() {
		return recruit_id;
	}
	public void setRecruit_id(long recruit_id) {
		this.recruit_id = recruit_id;
	}
	public int getRecruit_status() {
		return recruit_status;
	}
	public void setRecruit_status(int recruit_status) {
		this.recruit_status = recruit_status;
	}
	public long getMember_code() {
		return member_code;
	}
	public void setMember_code(long member_code) {
		this.member_code = member_code;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMatch_date() {
		return match_date;
	}
	public void setMatch_date(String match_date) {
		this.match_date = match_date;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getOpponent_name() {
		return opponent_name;
	}
	public void setOpponent_name(String opponent_name) {
		this.opponent_name = opponent_name;
	}
	public String getSort_date() {
		return sort_date;
	}
	public void setSort_date(String sort_date) {
		this.sort_date = sort_date;
	}
	public String getTeam_emblem() {
		return team_emblem;
	}
	public void setTeam_emblem(String team_emblem) {
		this.team_emblem = team_emblem;
	}
	public String getOpponent_emblem() {
		return opponent_emblem;
	}
	public void setOpponent_emblem(String opponent_emblem) {
		this.opponent_emblem = opponent_emblem;
	}
    
    
}
