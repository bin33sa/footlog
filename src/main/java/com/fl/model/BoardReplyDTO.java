package com.fl.model;

public class BoardReplyDTO {
    private long comment_id;            // 댓글 코드 (PK)
    private Integer parent_comment_id; // 부모 댓글 코드 (FK, 답글 기능용)
    private long member_code;          // 회원 코드 (FK)
    private long board_main_code;      // 게시판 코드 (FK) - recruit_id에서 변경
    private String content;            // 댓글 내용
    private String created_at;         // 작성일
    
    // 조인(Join) 및 UI 표시를 위한 추가 필드
    private String member_name;        // 작성자 이름 (MEMBER 테이블과 조인)
    private int answerCount;           // 해당 댓글에 달린 답글(대댓글) 개수
    
    // Getter 및 Setter
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
}