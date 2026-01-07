package com.fl.model;

public class FileDTO {
	private Long file_id;
    private String file_name;        
    private String file_server_name; 
    private long file_size;

    private Long board_main_code;   
    private Long gallery_code;      
    private Long board_team_code;
    
	public Long getFile_id() {
		return file_id;
	}
	public void setFile_id(Long file_id) {
		this.file_id = file_id;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_server_name() {
		return file_server_name;
	}
	public void setFile_server_name(String file_server_name) {
		this.file_server_name = file_server_name;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public Long getBoard_main_code() {
		return board_main_code;
	}
	public void setBoard_main_code(Long board_main_code) {
		this.board_main_code = board_main_code;
	}
	public Long getGallery_code() {
		return gallery_code;
	}
	public void setGallery_code(Long gallery_code) {
		this.gallery_code = gallery_code;
	}
	public Long getBoard_team_code() {
		return board_team_code;
	}
	public void setBoard_team_code(Long board_team_code) {
		this.board_team_code = board_team_code;
	}
    
    
}
