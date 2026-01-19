package com.fl.model;

public class BoardFaqDTO {
    private long board_faq_code;
    private long member_code;
    private String title;
    private String content;
    private int category; // 1:계정, 2:구장관련 등
	public long getBoard_faq_code() {
		return board_faq_code;
	}
	public void setBoard_faq_code(long board_faq_code) {
		this.board_faq_code = board_faq_code;
	}
	public long getMember_code() {
		return member_code;
	}
	public void setMember_code(long member_code) {
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
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
    
    
}