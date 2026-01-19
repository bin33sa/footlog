package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.MatchApplyDTO;
import com.fl.model.MatchDTO;
import com.fl.model.TeamDTO;

public interface MatchService {
	public void insertMatch(MatchDTO dto) throws Exception;
	public void updateMatch(MatchDTO dto) throws Exception;
	public void updateMatchStatus(Map<String, Object> map);
	public void deleteMatch(Map<String,Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<MatchDTO> listMatch(Map<String, Object> map);
	public List<MatchApplyDTO> listApplicant(Map<String, Object> map);
	public MatchDTO findById(long num);
	public List<TeamDTO> listUserTeams(long member_code);
	public int getUserTeamRole(Map<String, Object> map);
	public void updateHitCount(long num) throws Exception;
	
	public void insertMatchApply(MatchApplyDTO dto) throws Exception;
	public void deleteMatchApply(MatchApplyDTO dto) throws Exception;
	public int countMatchApply(Map<String, Object> map);
	public void updateExpiredMatchStatus() throws Exception;
}
