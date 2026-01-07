package com.fl.model;

public class QnaDTO {
	private Long board_qna_code;
    private Long member_code;
    private String title;
    private String content;
    private String answer;       
    private String created_at;
    private int status;          
    private int category;

    private String member_name;
    private String member_id;
    
	public Long getBoard_qna_code() {
		return board_qna_code;
	}
	public void setBoard_qna_code(Long board_qna_code) {
		this.board_qna_code = board_qna_code;
	}
	public Long getMember_code() {
		return member_code;
	}
	public void setMember_code(Long member_code) {
		this.member_code = member_code;
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
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
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
    
    
}	
