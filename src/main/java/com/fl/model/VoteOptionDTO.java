package com.fl.model;

public class VoteOptionDTO {
	private Long option_code;      
    private Long board_vote_code;  
    private String content;        

    private int option_count;     
    private int is_checked;
    
	public Long getOption_code() {
		return option_code;
	}
	public void setOption_code(Long option_code) {
		this.option_code = option_code;
	}
	public Long getBoard_vote_code() {
		return board_vote_code;
	}
	public void setBoard_vote_code(Long board_vote_code) {
		this.board_vote_code = board_vote_code;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getOption_count() {
		return option_count;
	}
	public void setOption_count(int option_count) {
		this.option_count = option_count;
	}
	public int getIs_checked() {
		return is_checked;
	}
	public void setIs_checked(int is_checked) {
		this.is_checked = is_checked;
	}
    
    
}
