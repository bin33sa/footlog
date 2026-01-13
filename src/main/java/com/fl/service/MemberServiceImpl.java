package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.MemberMapper;
import com.fl.model.MemberDTO;
import com.fl.mybatis.support.MapperContainer;
import com.fl.mybatis.support.SqlSessionManager;

public class MemberServiceImpl implements MemberService {
	private MemberMapper mapper = MapperContainer.get(MemberMapper.class);

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
		// TODO Auto-generated method stub
		
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
		// TODO Auto-generated method stub
		
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

	@Override
	public List<Map<String, Object>> listAgeSection() {
		// TODO Auto-generated method stub
		return null;
	}

}
