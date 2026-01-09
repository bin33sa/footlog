package com.fl.model;

public class MatchDTO {
	private Long match_code;         
    private Long home_code;          
    private Long away_code;          
    private String match_date;       
    private String status;           
    private String title;            
    private String content;          
    private String created_at;       
    private int view_count;          

    private int home_score;
    private int away_score;
   
    private String home_team_name;
    private String home_team_emblem; 
    private String region;          
    
    private String away_team_name;
    private String away_team_emblem;
    
    private int reply_count;
    
    private String matchType;
    private String gender;
    private Long fee;
    private Long member_code;
    
    
    public String getMatchType() {
		return matchType;
	}

	public void setMatchType(String matchType) {
		this.matchType = matchType;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Long getFee() {
		return fee;
	}

	public void setFee(Long fee) {
		this.fee = fee;
	}

	public Long getMember_code() {
		return member_code;
	}

	public void setMember_code(Long member_code) {
		this.member_code = member_code;
	}

	public Long getMatch_code() {
		return match_code;
	}

	public void setMatch_code(Long match_code) {
		this.match_code = match_code;
	}

	public Long getHome_code() {
		return home_code;
	}

	public void setHome_code(Long home_code) {
		this.home_code = home_code;
	}

	public Long getAway_code() {
		return away_code;
	}

	public void setAway_code(Long away_code) {
		this.away_code = away_code;
	}

	public String getMatch_date() {
		return match_date;
	}

	public void setMatch_date(String match_date) {
		this.match_date = match_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public int getHome_score() {
		return home_score;
	}

	public void setHome_score(int home_score) {
		this.home_score = home_score;
	}

	public int getAway_score() {
		return away_score;
	}

	public void setAway_score(int away_score) {
		this.away_score = away_score;
	}

	public String getHome_team_name() {
		return home_team_name;
	}

	public void setHome_team_name(String home_team_name) {
		this.home_team_name = home_team_name;
	}

	public String getHome_team_emblem() {
		return home_team_emblem;
	}

	public void setHome_team_emblem(String home_team_emblem) {
		this.home_team_emblem = home_team_emblem;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getAway_team_name() {
		return away_team_name;
	}

	public void setAway_team_name(String away_team_name) {
		this.away_team_name = away_team_name;
	}

	public String getAway_team_emblem() {
		return away_team_emblem;
	}

	public void setAway_team_emblem(String away_team_emblem) {
		this.away_team_emblem = away_team_emblem;
	}

	public int getReply_count() {
		return reply_count;
	}

	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
    
    
}
