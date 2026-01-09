package com.fl.mapper;

import java.sql.SQLException;
import java.util.List;
import com.fl.model.MatchDTO;
import com.fl.model.MemberDTO;

public interface MyPageMapper {
	
	
    // 내 매치내역 리스트
    public List<MatchDTO> listMyMatch(long memberCode) throws SQLException;

    public MemberDTO readMember(long memberCode) throws SQLException;
	
}