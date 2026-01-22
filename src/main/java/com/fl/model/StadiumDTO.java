package com.fl.model;

public class StadiumDTO {
	private Long stadiumCode;
	private String stadiumName;
	private String region;
	private String phoneNumber;
	private String description;
	private String introUrl;
	private String stadiumImage;
	private long rating;
	private long price;
	private long is_deleted;
	
	
	
	public String getStadiumImage() {
		return stadiumImage;
	}
	public void setStadiumImage(String stadiumImage) {
		this.stadiumImage = stadiumImage;
	}
	public long getIs_deleted() {
		return is_deleted;
	}
	public void setIs_deleted(long is_deleted) {
		this.is_deleted = is_deleted;
	}
	public Long getStadiumCode() {
		return stadiumCode;
	}
	public void setStadiumCode(Long stadiumCode) {
		this.stadiumCode = stadiumCode;
	}
	public String getStadiumName() {
		return stadiumName;
	}
	public void setStadiumName(String stadiumName) {
		this.stadiumName = stadiumName;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIntroUrl() {
		return introUrl;
	}
	public void setIntroUrl(String introUrl) {
		this.introUrl = introUrl;
	}
	
	public long getRating() {
		return rating;
	}
	public void setRating(long rating) {
		this.rating = rating;
	}
	public long getPrice() {
		return price;
	}
	public void setPrice(long price) {
		this.price = price;
	}
	
	
}
