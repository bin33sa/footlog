package com.fl.model;

public class MemberDTO {
    private Long memberCode;
    private String memberId;
    private String password;
    private String memberName;
    private String phoneNumber;
    private String email;
    private String region;
    private String profileImage;
    private String preferredPosition;
    private int roleLevel;
    private int isDeleted;
    private String deletedAt; 

    public Long getMemberCode() {
        return memberCode;
    }
    public void setMemberCode(Long memberCode) {
        this.memberCode = memberCode;
    }
    public String getMemberId() {
        return memberId;
    }
    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getMemberName() {
        return memberName;
    }
    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }
    public String getPhoneNumber() {
        return phoneNumber;
    }
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getRegion() {
        return region;
    }
    public void setRegion(String region) {
        this.region = region;
    }
    public String getProfileImage() {
        return profileImage;
    }
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }
    public String getPreferredPosition() {
        return preferredPosition;
    }
    public void setPreferredPosition(String preferredPosition) {
        this.preferredPosition = preferredPosition;
    }
    public int getRoleLevel() {
        return roleLevel;
    }
    public void setRoleLevel(int roleLevel) {
        this.roleLevel = roleLevel;
    }
    public int getIsDeleted() {
        return isDeleted;
    }
    public void setIsDeleted(int isDeleted) {
        this.isDeleted = isDeleted;
    }
    public String getDeletedAt() {
        return deletedAt;
    }
    public void setDeletedAt(String deletedAt) {
        this.deletedAt = deletedAt;
    }
}