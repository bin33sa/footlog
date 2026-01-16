package com.fl.mapper;

import java.util.List;
import java.util.Map;
import com.fl.model.TeamDTO;

public interface TeamMapper {
    
    // 리스트 조회
    public List<TeamDTO> listTeam(Map<String, Object> map);
    public int teamCount(Map<String, Object> map);
    
    // 상세 조회
    public TeamDTO readTeam(Map<String, Object> map);
    
    // 생성
    public void insertTeam(TeamDTO dto) throws Exception;
    public void insertTeamMember(Map<String, Object> map) throws Exception;
    
    // 내 구단 조회
    public List<TeamDTO> readMyTeam(long member_code);
    
    // 구단 삭제(비활성화)
    public void deleteTeam(long team_code) throws Exception;
    
    
	// 구단 가입 신청서 등록
    public void insertJoinRequest(Map<String, Object> map) throws Exception;
    
    // 가입 상태 확인
    public int checkJoinStatus(Map<String, Object> map);
    
    // 구단장인지 확인 
    public int isLeader(Map<String, Object> map);
    
    // 좋아요
    public void insertTeamLike(Map<String, Object> map); 
    public void deleteTeamLike(Map<String, Object> map); 
    public int teamLikeCount(long team_code);
}