package com.fl.model;

public class BoardReplyDTO {
    private long comment_id;          
    private Integer parent_comment_id; 
    private long member_code;          
    private long board_main_code;     
    private String content;           
    private String created_at;         
    private Long gallery_code;
    private String profile_image;
    private long board_team_code;
    
    private String member_name;       
    private int answerCount;           
 
    public long getComment_id() {
        return comment_id;
    }
    public void setComment_id(long comment_id) {
        this.comment_id = comment_id;
    }
    public Integer getParent_comment_id() {
        return parent_comment_id;
    }
    public void setParent_comment_id(Integer parent_comment_id) {
        this.parent_comment_id = parent_comment_id;
    }
    public long getMember_code() {
        return member_code;
    }
    public void setMember_code(long member_code) {
        this.member_code = member_code;
    }
    public long getBoard_main_code() { // 변수명 변경에 따른 Getter 수정
        return board_main_code;
    }
    public void setBoard_main_code(long board_main_code) {
        this.board_main_code = board_main_code;
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
    public String getMember_name() {
        return member_name;
    }
    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }
    public int getAnswerCount() {
        return answerCount;
    }
    public void setAnswerCount(int answerCount) {
        this.answerCount = answerCount;
    }
	public Long getGallery_code() {
		return gallery_code;
	}
	public void setGallery_code(Long gallery_code) {
		this.gallery_code = gallery_code;
	}
	public String getProfile_image() {
		return profile_image;
	}
	public void setProfile_image(String profile_image) {
		this.profile_image = profile_image;
	}
	public long getBoard_team_code() {
		return board_team_code;
	}
	public void setBoard_team_code(long board_team_code) {
		this.board_team_code = board_team_code;
	}
    
    
}