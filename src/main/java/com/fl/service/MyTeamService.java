package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.JoinRequestDTO;
import com.fl.model.ScheduleDTO;
import com.fl.model.TeamBoardDTO;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;
import com.fl.model.VoteDTO;

public interface MyTeamService {
    
    public List<TeamDTO> listMyTeam(long member_code);

    public TeamMemberDTO readMyTeamStatus(Map<String, Object> map);

    public void leaveTeam(Map<String, Object> map) throws Exception;

    public List<JoinRequestDTO> listJoinRequest(long team_code);

    public void updateJoinRequestStatus(Map<String, Object> map) throws Exception;
    
    public void insertTeamMember(TeamMemberDTO dto) throws Exception;
    
    public void updateTeamMemberCountUp(long team_code) throws Exception;
    
    public void updateMemberRole(Map<String, Object> map) throws Exception;

    public void expelMember(Map<String, Object> map) throws Exception;

    public List<ScheduleDTO> listMonthSchedule(Map<String, Object> map);

    public void insertSchedule(ScheduleDTO dto) throws Exception;

    public void deleteSchedule(long board_cal_code) throws Exception;

    public List<VoteDTO> listVote(Map<String, Object> map);

    public void insertVote(VoteDTO dto) throws Exception;

    public VoteDTO readVote(long board_vote_code, long member_code);

    public void doVote(Map<String, Object> map) throws Exception;
    
    public void insertTeamBoard(TeamBoardDTO dto) throws Exception;

    public List<TeamBoardDTO> listTeamBoard(Map<String, Object> map);
    public int dataCountTeamBoard(Map<String, Object> map);

    public TeamBoardDTO readTeamBoard(long board_team_code);

    public void updateHitCount(long board_team_code) throws Exception;

    public void updateTeamBoard(TeamBoardDTO dto) throws Exception;

    public void deleteTeamBoard(long board_team_code) throws Exception;
    
    // 파일 다운로드용 파일 정보 가져오기 (필요시)
    // public FileDTO readFile(long file_id);
}