package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.JoinRequestDTO;
import com.fl.model.ScheduleDTO;
import com.fl.model.TeamBoardDTO;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;
import com.fl.model.VoteDTO;
import com.fl.model.VoteOptionDTO;

public interface MyTeamService {
	
	// ==========================================
	// 1. [팀 정보 & 메인]
	// ==========================================
	public List<TeamDTO> listMyTeam(long member_code);
	
	public TeamDTO readTeamInfo(long team_code);
	
	public TeamMemberDTO readMyTeamStatus(Map<String, Object> map);
	
	public void updateTeamInfo(TeamDTO dto) throws Exception;
	
	public void leaveTeam(Map<String, Object> map) throws Exception;

	public int readMemberRoleLevel(long memberCode, long teamCode);
	// ==========================================
	// 2. [멤버 관리]
	// ==========================================
	public List<TeamMemberDTO> listTeamMember(Map<String, Object> map);
	
	public int dataCountTeamMember(Map<String, Object> map);
	
	public void updateMemberRole(Map<String, Object> map) throws Exception;
	
	public void kickMember(Map<String, Object> map) throws Exception;
	
	public void updateTeamMember(TeamMemberDTO dto) throws Exception;
	
	// ==========================================
	// 3. [가입 신청 관리]
	// ==========================================
	public List<JoinRequestDTO> listJoinRequest(long team_code);
	
	public void processJoinAccept(Map<String, Object> map) throws Exception;
	
	public void processJoinReject(Map<String, Object> map) throws Exception;

	
	// ==========================================
	// 4. [일정 관리]
	// ==========================================
	public List<ScheduleDTO> listMonthSchedule(Map<String, Object> map);
	
	public void insertSchedule(ScheduleDTO dto) throws Exception;
	
	public void updateSchedule(ScheduleDTO dto) throws Exception;
	
	public void deleteSchedule(long schedule_code) throws Exception;

	
	// ==========================================
	// 5. [투표 관리]
	// ==========================================
	public void insertVote(VoteDTO dto) throws Exception;
	
	public void insertVoteOption(VoteOptionDTO dto) throws Exception;

	public List<VoteDTO> listVote(Map<String, Object> map);
	
	public VoteDTO readVote(Map<String, Object> map);
	
	public List<VoteOptionDTO> listVoteOptions(Map<String, Object> map);
	
	public int checkVoteHistory(Map<String, Object> map);
	
	public void vote(Map<String, Object> map) throws Exception;

	
	// ==========================================
	// 6. [게시판]
	// ==========================================
	public void insertTeamBoard(TeamBoardDTO dto) throws Exception;
	
	public List<TeamBoardDTO> listTeamBoard(Map<String, Object> map);
	
	public int dataCountTeamBoard(Map<String, Object> map);
	
	public TeamBoardDTO readTeamBoard(long board_team_code);
	
	public void updateTeamBoard(TeamBoardDTO dto) throws Exception;
	
	public void deleteTeamBoard(long board_team_code) throws Exception;
	
	
	public void insertGallery(com.fl.model.GalleryDTO dto) throws Exception;
	
	public List<com.fl.model.GalleryDTO> listGallery(Map<String, Object> map);
	
	public int galleryDataCount(Map<String, Object> map);
	
	public com.fl.model.GalleryDTO readGallery(long gallery_code);
	
	public void updateGallery(com.fl.model.GalleryDTO dto) throws Exception;
	
	public void deleteGallery(long gallery_code) throws Exception;
}