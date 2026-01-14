package com.fl.model;

import java.util.List;

public class BoardDTO {
	private int replyCount;
	private Long board_main_code;   
    private Long member_code;       
    private String title;
    private String content;
    private String created_at;      
    private int category;           
    private int view_count;         
    private String video_url;        
    private List<FileDTO> listFile;
    
    private String member_name;
    private String member_id;
    
    private int reply_count;         
    private int file_count;          
    private String gap;
    
    
	public Long getBoard_main_code() {
		return board_main_code;
	}
	public void setBoard_main_code(Long board_main_code) {
		this.board_main_code = board_main_code;
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
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public String getVideo_url() {
		return video_url;
	}
	public void setVideo_url(String video_url) {
		this.video_url = video_url;
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
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	public int getFile_count() {
		return file_count;
	}
	public void setFile_count(int file_count) {
		this.file_count = file_count;
	}
	public String getGap() {
		return gap;
	}
	public void setGap(String gap) {
		this.gap = gap;
	}
	public List<FileDTO> getListFile() {
		return listFile;
	}
	public void setListFile(List<FileDTO> listFile) {
		this.listFile = listFile;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
    
    
    
}
