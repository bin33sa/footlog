package com.fl.model;

public class MemberVoteDTO {
	private Long board_vote_code;   
    private Long member_code;
    private int status;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
    
    
}
