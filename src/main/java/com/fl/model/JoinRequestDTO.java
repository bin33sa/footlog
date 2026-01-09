package com.fl.model;

public class JoinRequestDTO {
  
    private long member_code;
    private long team_code;
    private int status;
    private String created_at;
    

    private String user_name;
    private String user_id;


    public long getMember_code() { return member_code; }
    public void setMember_code(long member_code) { this.member_code = member_code; }
    public long getTeam_code() { return team_code; }
    public void setTeam_code(long team_code) { this.team_code = team_code; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public String getCreated_at() { return created_at; }
    public void setCreated_at(String created_at) { this.created_at = created_at; }
    public String getUser_name() { return user_name; }
    public void setUser_name(String user_name) { this.user_name = user_name; }
    public String getUser_id() { return user_id; }
    public void setUser_id(String user_id) { this.user_id = user_id; }
}