package com.fl.service;

import java.util.List;
import java.util.Map;

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
	
	
	// 1. 매치 신청 내역 페이징 처리
    @Override
    public int dataCountMatch(long member_code) {
        int result = 0;
        try {
            result = mapper.countMatchApply(member_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public List<MatchHistoryDTO> listMatchApply(Map<String, Object> map) {
        List<MatchHistoryDTO> list = null;
        try {
            // Map에는 member_code, offset, size가 들어있음
            list = mapper.listMatchApply(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. 용병 활동 내역 페이징 처리
    @Override
    public int dataCountMyMercenary(long member_code) {
        int result = 0;
        try {
            result = mapper.countMyMercenaryPosts(member_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public List<MercenaryDTO> listMyMercenaryPosts(Map<String, Object> map) {
        List<MercenaryDTO> list = null;
        try {
            // Map에는 member_code, offset, size가 들어있음
            list = mapper.listMyMercenaryPosts(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

	

	
	
}
