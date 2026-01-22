package com.fl.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.fl.model.MemberDTO;

public interface MemberMapper {
	public MemberDTO loginMember(Map<String, Object> map);
	public void insertMember(MemberDTO dto) throws SQLException;
	public void updateMember(MemberDTO dto) throws SQLException;
	public void deleteProfileImage(Map<String, Object> map) throws SQLException;
	public void deleteMember(Map<String, Object> map) throws SQLException;
	public void updateMemberPw(MemberDTO dto) throws SQLException;
	
	public MemberDTO findById(String userId); // 아이디 중복확인 
	public MemberDTO findId(Map<String, Object> map); // 아이디 찾기
	
	// 구단장인 팀의 진행 중인 매치 개수 확인(회원 탈퇴용)
	public int countActiveMatchAsLeader(long member_code);
}
