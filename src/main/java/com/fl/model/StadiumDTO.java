package com.fl.model;

public class StadiumDTO {
	private Long stadiumCode;
	private String stadiumName;
	private String region;
	private String phoneNumber;
	private String description;
	private String introUrl;
	private String stadium_image;

	public Long getPrice() {
		return price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}

	public Long getRating() {
		return rating;
	}

	public void setRating(Long rating) {
		this.rating = rating;
	}

	private Long price;
	private Long rating;

	private int likeCount;
	private int arenaCount;
	private int userLiked;

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

	public String getStadium_image() {
		return stadium_image;
	}

	public void setStadium_image(String stadium_image) {
		this.stadium_image = stadium_image;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public int getArenaCount() {
		return arenaCount;
	}

	public void setArenaCount(int arenaCount) {
		this.arenaCount = arenaCount;
	}

	public int getUserLiked() {
		return userLiked;
	}

	public void setUserLiked(int userLiked) {
		this.userLiked = userLiked;
	}

}
