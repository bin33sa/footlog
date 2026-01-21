package com.fl.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.fl.model.MatchDTO;
import com.fl.model.MatchHistoryDTO;
import com.fl.model.MemberDTO;
import com.fl.model.MercenaryDTO;

public interface MyPageMapper {
	
    // 내 매치내역 리스트
    public List<MatchDTO> listMyMatch(long memberCode) throws SQLException;

    public MemberDTO readMember(long memberCode) throws SQLException;
    
    // 매치 신청 내역 불러오기 
    public int countMatchApply(long member_code);
    public List<MatchHistoryDTO> listMatchApply(Map<String, Object> map);
    
    // 용병 활동 내역 불러오기 
    public int countMyMercenaryPosts(long member_code);
    public List<MercenaryDTO> listMyMercenaryPosts(Map<String, Object> map);

}