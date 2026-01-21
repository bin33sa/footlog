package com.fl.service;

import java.util.List;

import com.fl.mapper.MyPageMapper;
import com.fl.model.MatchDTO;
import com.fl.model.MatchHistoryDTO;
import com.fl.model.MemberDTO;
import com.fl.model.MercenaryDTO;
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

	@Override
	public List<MatchHistoryDTO> listMatchApply(long member_code) {
		List<MatchHistoryDTO> list = null;
        try {
            list = mapper.listMatchApply(member_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;	
   }

	@Override
	public List<MercenaryDTO> listMyMercenaryPosts(long member_code) {
	    List<MercenaryDTO> list = null;
	    try {
	        // 매퍼 메소드 이름도 변경
	        list = mapper.listMyMercenaryPosts(member_code);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	
	
}
