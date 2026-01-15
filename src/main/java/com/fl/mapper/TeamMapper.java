package com.fl.mapper;

import java.util.List;
import java.util.Map;
import com.fl.model.TeamDTO;

public interface TeamMapper {
	
    // 전체 구단 리스트 (더보기용)
	public List<TeamDTO> listTeam(Map<String, Object> map);
	
	// 전체 구단 리스트 (전체)
	public List<TeamDTO> listTeamAll();
	
	// 구단 개수
	int teamCount(Map<String, Object> map);
	
	// 구단 상세 조회
	public TeamDTO readTeam(Map<String, Object> map);

    // 구단 생성
    public void insertTeam(TeamDTO dto) throws Exception;
    
    // 멤버 등록 (구단장 등록용)
    public void insertTeamMember(Map<String, Object> map) throws Exception;
    
    // 내 구단 정보 가져오기 
    public List<TeamDTO> readMyTeam(long member_code);
    
    // 좋아요 관련
    public TeamDTO readTeam(long team_code, Long member_code);
    public TeamDTO hasUserTeamLiked(Map<String, Object> map);
	public void insertTeamLike(Map<String, Object> map); 
	public void deleteTeamLike(Map<String, Object> map); 
	public int teamLikeCount(long num);
	

}