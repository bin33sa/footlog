package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.MatchMapper;
import com.fl.model.MatchApplyDTO;
import com.fl.model.MatchDTO;
import com.fl.model.StadiumReservationDTO;
import com.fl.model.TeamDTO;
import com.fl.mybatis.support.MapperContainer;

public class MatchServiceImpl implements MatchService{
	private MatchMapper mapper = MapperContainer.get(MatchMapper.class);
	
	@Override
	public void insertMatch(MatchDTO dto) throws Exception {
		
		try {
			mapper.insertMatch(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateMatch(MatchDTO dto) throws Exception {
		try {
			mapper.updateMatch(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateMatchStatus(Map<String, Object> map) {
		try {
			mapper.updateMatchStatus(map);
			
			mapper.updateApplyStatus(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}

	@Override
	public void deleteMatch(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteMatch(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<MatchDTO> listMatch(Map<String, Object> map) {
		List<MatchDTO> list = null;
		try {
			list = mapper.listMatch(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<MatchApplyDTO> listApplicant(Map<String, Object> map) {
		List<MatchApplyDTO> list = null;
		try {
			list = mapper.listApplicant(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public MatchDTO findById(long num) {
		MatchDTO dto = null;
		try {
			dto = mapper.findById(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	

	@Override
	public void updateHitCount(long num) throws Exception {
		try {
			mapper.updateHitCount(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<TeamDTO> listUserTeams(long member_code) {
	    List<TeamDTO> list = null;
	    try {
	        list = mapper.listUserTeams(member_code);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	@Override
	public int getUserTeamRole(Map<String, Object> map) {
		int role = 0;
		try {
			role = mapper.getUserTeamRole(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return role;
	}

	@Override
	public void insertMatchApply(MatchApplyDTO dto) throws Exception {
		try {
			mapper.insertMatchApply(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	@Override
	public void deleteMatchApply(MatchApplyDTO dto) throws Exception {
		try {
			mapper.deleteMatchApply(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int countMatchApply(Map<String, Object> map) {
		int count=0;
		try {
			count = mapper.countMatchApply(map);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return count;
	}

	@Override
	public void updateExpiredMatchStatus() throws Exception {
		try {
			mapper.updateExpiredMatchStatus();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int countMatchResult(long match_code) {
		int result=0;
		try {
			result = mapper.countMatchResult(match_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int insertMatchResult(MatchDTO dto) {
		int result=0;
		try {
			result=mapper.insertMatchResult(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int updateMatchResult(MatchDTO dto) {
		int result=0;
		try {
			result = mapper.updateMatchResult(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<MatchDTO> listMyMatch(Map<String, Object> map) {
		List<MatchDTO> list = null;
		try {
			list = mapper.listMyMatch(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMyMatch(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCountMyMatch(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<StadiumReservationDTO> listMyFutureReservations(long team_code) {
		List<StadiumReservationDTO> list = null;
		try {
			list=mapper.listMyFutureReservations(team_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}