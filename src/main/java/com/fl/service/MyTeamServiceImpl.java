package com.fl.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.fl.mapper.MyTeamMapper;
import com.fl.model.JoinRequestDTO;
import com.fl.model.ScheduleDTO;
import com.fl.model.TeamBoardDTO;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;
import com.fl.model.VoteDTO;
import com.fl.mybatis.support.MapperContainer;

public class MyTeamServiceImpl implements MyTeamService{
	private MyTeamMapper mapper = MapperContainer.get(MyTeamMapper.class);
	
	@Override
	public List<TeamDTO> listMyTeam(long member_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public TeamMemberDTO readMyTeamStatus(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void leaveTeam(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<JoinRequestDTO> listJoinRequest(long team_code) {
		List<JoinRequestDTO> list = new ArrayList<JoinRequestDTO>();
		
		try {
			list = mapper.listJoinRequest(team_code);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
		return list;
	}

	// 1. 상태 변경 (대기 -> 수락/거절)
		@Override
		public void updateJoinRequestStatus(Map<String, Object> map) throws Exception {
			try {
				mapper.updateJoinRequestStatus(map);
			} catch (Exception e) {
				System.out.println("[MyTeamService] updateJoinRequestStatus 에러 발생");
				e.printStackTrace(); // 에러 로그 필수!
				throw e; // 컨트롤러에게 "야, DB 쪽에서 문제 터졌어!"라고 알려줌
			}
		}

		// 2. 정식 팀원으로 추가
		@Override
		public void insertTeamMember(TeamMemberDTO dto) throws Exception {
			try {
				mapper.insertTeamMember(dto);
			} catch (Exception e) {
				System.out.println("[MyTeamService] insertTeamMember 에러 발생");
				e.printStackTrace();
				throw e;
			}
		}

		// 3. 팀원 수 증가
		@Override
		public void updateTeamMemberCountUp(long team_code) throws Exception {
			try {
				mapper.updateTeamMemberCountUp(team_code);
			} catch (Exception e) {
				System.out.println("[MyTeamService] updateTeamMemberCountUp 에러 발생");
				e.printStackTrace();
				throw e;
			}
		}

	@Override
	public void updateMemberRole(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void expelMember(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<ScheduleDTO> listMonthSchedule(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertSchedule(ScheduleDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteSchedule(long board_cal_code) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<VoteDTO> listVote(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertVote(VoteDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public VoteDTO readVote(long board_vote_code, long member_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void doVote(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertTeamBoard(TeamBoardDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TeamBoardDTO> listTeamBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCountTeamBoard(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public TeamBoardDTO readTeamBoard(long board_team_code) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(long board_team_code) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateTeamBoard(TeamBoardDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteTeamBoard(long board_team_code) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
