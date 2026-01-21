package com.fl.model;

public class VoteDTO {

    private Long boardVoteCode;
    private Long memberCode;
    private Long teamCode;
    
    private String title;
    private String content;
    private int status;
    private int viewCount;
    
    private String startDate;
    private String endDate;
    private String createdAt;

    private int voteCount;
    private int myVoteStatus;
    
    private String writerName;
    
    private String eventDate;
    private String eventEndDate;
    
    public Long getBoardVoteCode() {
        return boardVoteCode;
    }
    public void setBoardVoteCode(Long boardVoteCode) {
        this.boardVoteCode = boardVoteCode;
    }

    public Long getMemberCode() {
        return memberCode;
    }
    public void setMemberCode(Long memberCode) {
        this.memberCode = memberCode;
    }

    public Long getTeamCode() {
        return teamCode;
    }
    public void setTeamCode(Long teamCode) {
        this.teamCode = teamCode;
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

    public int getViewCount() {
        return viewCount;
    }
    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public String getStartDate() {
        return startDate;
    }
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }
    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public int getVoteCount() {
        return voteCount;
    }
    public void setVoteCount(int voteCount) {
        this.voteCount = voteCount;
    }

    public int getMyVoteStatus() {
        return myVoteStatus;
    }
    public void setMyVoteStatus(int myVoteStatus) {
        this.myVoteStatus = myVoteStatus;
    }

    public String getWriterName() {
        return writerName;
    }
    public void setWriterName(String writerName) {
        this.writerName = writerName;
    }

    public String getEventDate() {
        return eventDate;
    }
    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public String getEventEndDate() {
        return eventEndDate;
    }
    public void setEventEndDate(String eventEndDate) {
        this.eventEndDate = eventEndDate;
    }
}