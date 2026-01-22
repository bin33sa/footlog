package com.fl.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.fl.model.MemberDTO;

public interface MemberService {
	public MemberDTO loginMember(Map<String, Object> map);
	
	public void insertMember(MemberDTO dto) throws Exception;
	public void updateMember(MemberDTO dto) throws Exception;	
	public void updateMemberPw(MemberDTO dto) throws SQLException;
	public void updateMemberLevel(Map<String, Object> map) throws Exception;
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception;
	public void deleteMember(Map<String, Object> map) throws Exception;
	
	// 내가 구단장인 팀 개수 확인 (경고창용)
    public int countLeaderTeam(long member_code);
    // 구단장인 팀의 진행 중인 매치 개수 확인
    public int countActiveMatchAsLeader(long member_code);
	
	public MemberDTO findId(Map<String, Object> map); // 아이디 찾기
	public MemberDTO findById(String userId); // 아이디 중복 확인 

}
