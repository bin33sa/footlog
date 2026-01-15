package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.PageResult;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;

public interface TeamService {
	
	public void insertTeam(TeamDTO dto, Long member_code) throws Exception;
	
	public PageResult<TeamDTO> listTeam(int pageNo, int size, String keyword, String sort, long member_code);
	
	public TeamDTO readTeam(long team_code);
	
	public TeamDTO readTeam(long team_code, Long member_code);
	
	// 내 구단 정보 가져오기
	public List<TeamDTO> readMyTeam(long member_code);
	
	public void updateTeam(TeamDTO dto) throws Exception;
	
	public void deleteTeam(long team_code) throws Exception;
	
	public void insertTeamLike(Map<String, Object> map) throws Exception;
	
	public void deleteTeamLike(Map<String, Object> map) throws Exception;
	
	public int teamLikeCount(long team_code);
	
	public boolean isUserTeamLiked(Map<String, Object> map);
	
	public List<TeamDTO> listTeam(Map<String, Object> map);
	
	public int dataCount(Map<String, Object> map);

	public List<TeamMemberDTO> listTeamMember(long team_code);
	
	public void insertTeamMember(TeamMemberDTO dto) throws Exception;

	public void deleteTeamMember(Map<String, Object> map) throws Exception;

	public TeamMemberDTO readTeamMember(Map<String, Object> map);
}