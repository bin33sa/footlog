package com.fl.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.fl.mapper.MemberMapper;
import com.fl.mapper.TeamMapper;
import com.fl.model.MemberDTO;
import com.fl.mybatis.support.MapperContainer;
import com.fl.mybatis.support.SqlSessionManager;

public class MemberServiceImpl implements MemberService {
	private MemberMapper mapper = MapperContainer.get(MemberMapper.class);
	private TeamMapper teamMapper = MapperContainer.get(TeamMapper.class);

	@Override
	public MemberDTO loginMember(Map<String, Object> map) {
		MemberDTO dto = null;
		
		try {
			dto = mapper.loginMember(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertMember(MemberDTO dto) throws Exception {
		try {
			mapper.insertMember(dto);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			
			e.printStackTrace();
			
			throw e;
		}
		
	}

	@Override
	public void updateMember(MemberDTO dto) throws Exception {
		try {
			mapper.updateMember(dto);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void updateMemberLevel(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteProfilePhoto(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		try {
			long memberCode = (Long) map.get("member_code"); 
			
	        teamMapper.deleteTeamsByLeader(memberCode);
	        
	        mapper.deleteMember(map);
	        
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
	        throw e;
		}
	}
	
	@Override
	public int countActiveMatchAsLeader(long member_code) {
		int result = 0;
		try {
			result = mapper.countActiveMatchAsLeader(member_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	@Override
	public int countLeaderTeam(long memberCode) {
	    int count = 0;
	    try {
	        count = teamMapper.countLeaderTeam(memberCode);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}
	

	@Override
	public MemberDTO findById(String member_id) {
		MemberDTO dto = null;
		
		try {
			dto = mapper.findById(member_id);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	// 아이디 찾기 (이메일, 이름)
	@Override
	public MemberDTO findId(Map<String, Object> map) {
		MemberDTO dto = null;
	    try {
	        dto = mapper.findId(map);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return dto;
	}

	@Override
	public void updateMemberPw(MemberDTO dto) throws SQLException {
		try {
			mapper.updateMemberPw(dto);
		} catch (Exception e) {
			SqlSessionManager.setRollbackOnly();
			
			e.printStackTrace();
			throw e;
		}
		
	}

}
