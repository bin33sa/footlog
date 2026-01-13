package com.fl.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fl.model.JoinRequestDTO;
import com.fl.model.ScheduleDTO;
import com.fl.model.TeamBoardDTO;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;
import com.fl.model.VoteDTO;
import com.fl.model.VoteOptionDTO;

@Mapper
public interface MyTeamMapper {

	public List<TeamDTO> listMyTeam(long member_code);
	
	public Integer readMemberRoleLevel(Map<String, Object> map);
	
	public TeamDTO readTeamInfo(long team_code);

	public TeamMemberDTO readMyTeamStatus(Map<String, Object> map);

	public void updateTeamInfo(TeamDTO dto);

	public void deleteMyTeamHistory(Map<String, Object> map);

	public void updateTeamMemberCountDown(long team_code);

	public void updateTeamMemberCountUp(long team_code);

	public List<TeamMemberDTO> listTeamMember(Map<String, Object> map);

	public int dataCountTeamMember(Map<String, Object> map);

	public void updateMemberRole(Map<String, Object> map);

	public void updateTeamMember(TeamMemberDTO dto);
	
	public void deleteTeamMember(Map<String, Object> map);

	public List<JoinRequestDTO> listJoinRequest(long team_code);
	
	public void insertTeamMemberFromRequest(TeamMemberDTO dto);

	public void deleteJoinRequest(Map<String, Object> map);

	public List<ScheduleDTO> listMonthSchedule(Map<String, Object> map);

	public void insertSchedule(ScheduleDTO dto);

	public void updateSchedule(ScheduleDTO dto);

	public void deleteSchedule(long schedule_code);

	public void insertVote(VoteDTO dto);

	public void insertVoteOption(VoteOptionDTO dto);

	public List<VoteDTO> listVote(Map<String, Object> map);

	public VoteDTO readVote(Map<String, Object> map);

	public List<VoteOptionDTO> listVoteOptions(Map<String, Object> map);

	public int checkVoteHistory(Map<String, Object> map);

	public void insertVoteHistory(Map<String, Object> map);

	public void insertTeamBoard(TeamBoardDTO dto);
	
	public List<TeamBoardDTO> listTeamBoard(Map<String, Object> map);
	
	public int dataCountTeamBoard(Map<String, Object> map);
	
	public TeamBoardDTO readTeamBoard(long board_team_code);
	
	public void updateHitCount(long board_team_code);
	
	public void updateTeamBoard(TeamBoardDTO dto);
	
	public void deleteTeamBoard(long board_team_code);
}