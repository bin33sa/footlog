package com.fl.model;

public class SessionInfo {
    private Long member_code;
    private String member_id;
    private String member_name;
    private int role_level;

    public Long getMember_code() { return member_code; }
    public void setMember_code(Long member_code) { this.member_code = member_code; }
    
    public String getMember_id() { return member_id; }
    public void setMember_id(String member_id) { this.member_id = member_id; }
    
    public String getMember_name() { return member_name; }
    public void setMember_name(String member_name) { this.member_name = member_name; }
    
    public int getRole_level() { return role_level; }
    public void setRole_level(int role_level) { this.role_level = role_level; }
}