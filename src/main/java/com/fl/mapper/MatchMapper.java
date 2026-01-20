package com.fl.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.fl.model.MatchApplyDTO;
import com.fl.model.MatchDTO;
import com.fl.model.TeamDTO;

public interface MatchMapper {
	public long noticeSeq();
	
	public void insertMatch(MatchDTO dto) throws SQLException;
	public void updateMatch(MatchDTO dto) throws SQLException;
	public long updateMatchStatus(Map<String, Object> map);
	public void deleteMatch(Map<String, Object> map) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<MatchDTO> listMatch(Map<String, Object> map);
	public List<MatchApplyDTO> listApplicant(Map<String, Object> map);
	public MatchDTO findById(long num);
	public List<TeamDTO> listUserTeams(long member_code);
	public int getUserTeamRole(Map<String, Object> map);
	public MatchDTO findByPrev(Map<String, Object> map);
	public MatchDTO findByNext(Map<String, Object> map);
	public void updateHitCount(long num) throws SQLException;
	
	public void insertMatchApply(MatchApplyDTO dto) throws SQLException;
	public void updateApplyStatus(Map<String, Object> map) throws SQLException;
	public void deleteMatchApply(MatchApplyDTO dto) throws SQLException;
	public int countMatchApply(Map<String, Object> map);
	public void updateExpiredMatchStatus() throws SQLException;
	
	public int countMatchResult(long match_code);
	public int insertMatchResult(MatchDTO dto);
	public int updateMatchResult(MatchDTO dto);
	public List<MatchDTO> listMyMatch(long member_code);
}
