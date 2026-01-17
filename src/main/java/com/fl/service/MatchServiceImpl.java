package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.MatchMapper;
import com.fl.model.MatchApplyDTO;
import com.fl.model.MatchDTO;
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
	public boolean updateMatchStatus(Map<String, Object> map) {
		try {
			int result = mapper.updateMatchStatus(map);
			
			return result > 0;
			
		} catch (Exception e) {
			e.printStackTrace();
			
			return false;
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
	public MatchDTO findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MatchDTO findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertNoticeFile(MatchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteNoticeFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<MatchDTO> listNoticeFile(long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MatchDTO findByFileId(long fileNum) {
		// TODO Auto-generated method stub
		return null;
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
			Integer result = mapper.getUserTeamRole(map);
			if(result != null) {
				role=result;
			}
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
	public void updateMatchApply(MatchApplyDTO dto) throws Exception {
		try {
			mapper.updateMatchApply(dto);
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
	
}