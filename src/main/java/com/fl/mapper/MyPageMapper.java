package com.fl.mapper;

import java.sql.SQLException;
import java.util.List;
import com.fl.model.MatchDTO;
import com.fl.model.MatchHistoryDTO;
import com.fl.model.MemberDTO;
import com.fl.model.MercenaryDTO;

public interface MyPageMapper {
	
	
    // 내 매치내역 리스트
    public List<MatchDTO> listMyMatch(long memberCode) throws SQLException;

    public MemberDTO readMember(long memberCode) throws SQLException;
    
    // 매치 신청 내역 
    public List<MatchHistoryDTO> listMatchApply(long member_code);

    // 용병 신청 내역 
    public List<MercenaryDTO> listMyMercenaryPosts(long member_code);

}