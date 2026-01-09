package com.fl.service;

import java.util.List;

import com.fl.mapper.MyPageMapper;
import com.fl.model.MatchDTO;
import com.fl.model.MemberDTO;
import com.fl.mybatis.support.MapperContainer;

public class MyPageServiceImpl implements MyPageService {
	private MyPageMapper mapper = MapperContainer.get(MyPageMapper.class);
	
	@Override
	public List<MatchDTO> listMyMatch(long memberCode) {
        try {
        	return mapper.listMyMatch(memberCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
		return null;
	}

	@Override
	public MemberDTO readMember(long memberCode) {
		MemberDTO dto = null;
	    try {
	        dto = mapper.readMember(memberCode);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return dto;
	}
	
}
