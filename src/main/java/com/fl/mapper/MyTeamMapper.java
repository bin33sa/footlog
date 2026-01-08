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

@Mapper
public interface MyTeamMapper {
	
	// 1. 내 구단 정보
	// 내가 가입한 모든 팀 목록
	public List<TeamDTO> listMyTeam(long member_code);
	
	// 특정 팀에서의 내 정보 (권한 확인용)
	public TeamMemberDTO readMyTeamStatus(Map<String, Object> map);
	
	// 팀 탈퇴
	public void deleteMyTeamHistory(Map<String, Object> map); // member_team 삭제
	public void updateTeamMemberCountDown(long team_code);    // 팀원 수 -1

	// 2. 멤버 관리 (운영진)
	// 가입 신청 목록
	public List<JoinRequestDTO> listJoinRequest(long team_code);
	
	// 가입 신청 상태 변경 (수락/거절)
	public void updateJoinRequestStatus(Map<String, Object> map);
	
	// 가입 승인 시 팀원으로 정식 추가
	public void insertTeamMember(TeamMemberDTO dto);
	
	// 팀원 수 +1
	public void updateTeamMemberCountUp(long team_code);
	
	// 팀원 등급 변경 (일반 <-> 운영진)
	public void updateMemberRole(Map<String, Object> map);
	
	// 팀원 강제 방출
	public void deleteTeamMember(Map<String, Object> map);

	// 3. 팀 일정
	public List<ScheduleDTO> listMonthSchedule(Map<String, Object> map);
	public void insertSchedule(ScheduleDTO dto);
	public void deleteSchedule(long board_cal_code);

	// 4. 팀 투표
	public List<VoteDTO> listVote(Map<String, Object> map);
	public void insertVote(VoteDTO dto);
	public VoteDTO readVote(long board_vote_code);
	
	// 투표 참여 여부 확인
	public int checkVoteHistory(Map<String, Object> map);
	// 투표 참여 (member_vote 테이블 insert)
	public void insertVoteHistory(Map<String, Object> map); 
	
	// 5. 팀 게시판 (TeamBoard)
	public void insertTeamBoard(TeamBoardDTO dto);
	public List<TeamBoardDTO> listTeamBoard(Map<String, Object> map);
	public int dataCountTeamBoard(Map<String, Object> map);
	public TeamBoardDTO readTeamBoard(long board_team_code);
	public void updateHitCount(long board_team_code);
	public void updateTeamBoard(TeamBoardDTO dto);
	public void deleteTeamBoard(long board_team_code);
}