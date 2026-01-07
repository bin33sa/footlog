package com.fl.model;

public class CommentDTO {
	private Long comment_id;         
    private Long member_code;        
    private Long parent_comment_id;  
    private String content;          
    private String created_at;       

    private Long board_main_code;  
    private Long board_team_code;  
    private Long gallery_code;     
    private Long board_vote_code;   
    private Long recruit_id;        
    private Long match_code;        

    private String member_name;    
    private String member_id;      
    private String profile_image;  
    
    private int depth;      
    private int reply_order;
    
    
	public Long getComment_id() {
		return comment_id;
	}
	public void setComment_id(Long comment_id) {
		this.comment_id = comment_id;
	}
	public Long getMember_code() {
		return member_code;
	}
	public void setMember_code(Long member_code) {
		this.member_code = member_code;
	}
	public Long getParent_comment_id() {
		return parent_comment_id;
	}
	public void setParent_comment_id(Long parent_comment_id) {
		this.parent_comment_id = parent_comment_id;
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
	public Long getBoard_main_code() {
		return board_main_code;
	}
	public void setBoard_main_code(Long board_main_code) {
		this.board_main_code = board_main_code;
	}
	public Long getBoard_team_code() {
		return board_team_code;
	}
	public void setBoard_team_code(Long board_team_code) {
		this.board_team_code = board_team_code;
	}
	public Long getGallery_code() {
		return gallery_code;
	}
	public void setGallery_code(Long gallery_code) {
		this.gallery_code = gallery_code;
	}
	public Long getBoard_vote_code() {
		return board_vote_code;
	}
	public void setBoard_vote_code(Long board_vote_code) {
		this.board_vote_code = board_vote_code;
	}
	public Long getRecruit_id() {
		return recruit_id;
	}
	public void setRecruit_id(Long recruit_id) {
		this.recruit_id = recruit_id;
	}
	public Long getMatch_code() {
		return match_code;
	}
	public void setMatch_code(Long match_code) {
		this.match_code = match_code;
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
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getReply_order() {
		return reply_order;
	}
	public void setReply_order(int reply_order) {
		this.reply_order = reply_order;
	}
    
    
    
    
}
