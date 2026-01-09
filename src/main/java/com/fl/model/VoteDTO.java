package com.fl.model;

import java.util.List;

public class VoteDTO {
	private Long board_vote_code;  
    private Long member_code;      
    private Long team_code;        
    
    private String title;          
    private String content;        
    private int status;            
    private int view_count;        
    
    private String start_date;    
    private String end_date;      
    private String created_at;    

    private int vote_count;              
    private int my_vote_status;          
    
    private String writer_name;          
    private List<VoteOptionDTO> options;
    
	public Long getBoard_vote_code() {
		return board_vote_code;
	}
	public void setBoard_vote_code(Long board_vote_code) {
		this.board_vote_code = board_vote_code;
	}
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public int getVote_count() {
		return vote_count;
	}
	public void setVote_count(int vote_count) {
		this.vote_count = vote_count;
	}
	public int getMy_vote_status() {
		return my_vote_status;
	}
	public void setMy_vote_status(int my_vote_status) {
		this.my_vote_status = my_vote_status;
	}
	public String getWriter_name() {
		return writer_name;
	}
	public void setWriter_name(String writer_name) {
		this.writer_name = writer_name;
	}
	public List<VoteOptionDTO> getOptions() {
		return options;
	}
	public void setOptions(List<VoteOptionDTO> options) {
		this.options = options;
	}
    
    
}