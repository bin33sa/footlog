package com.fl.model;

import java.util.List;

public class GalleryDTO {
	private Long gallery_code;  
    private Long member_code;   
    private String title;       
    private String title_image; 
    private String created_at;   
    private int view_count;      
    private String content;      

    private String member_name;
    private String member_id;
   
    private int like_count;      
    private int reply_count;     
    
    private List<FileDTO> listFile;

	public Long getGallery_code() {
		return gallery_code;
	}

	public void setGallery_code(Long gallery_code) {
		this.gallery_code = gallery_code;
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

	public String getTitle_image() {
		return title_image;
	}

	public void setTitle_image(String title_image) {
		this.title_image = title_image;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	public int getView_count() {
		return view_count;
	}

	public void setView_count(int view_count) {
		this.view_count = view_count;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public int getLike_count() {
		return like_count;
	}

	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}

	public int getReply_count() {
		return reply_count;
	}

	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}

	public List<FileDTO> getListFile() {
		return listFile;
	}

	public void setListFile(List<FileDTO> listFile) {
		this.listFile = listFile;
	}
    
    
    
}
