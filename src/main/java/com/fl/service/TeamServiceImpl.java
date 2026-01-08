package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;

public class TeamServiceImpl implements TeamService{

	@Override
	public void insertTeam(TeamDTO dto, Long member_code) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TeamDTO> listTeam(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public TeamDTO readTeam(long team_code, Long member_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateTeam(TeamDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTeam(long team_code) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertTeamLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTeamLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int teamLikeCount(long team_code) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<TeamMemberDTO> listTeamMember(long team_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertTeamMember(TeamMemberDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTeamMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public TeamMemberDTO readTeamMember(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

}
