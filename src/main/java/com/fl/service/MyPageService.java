package com.fl.service;

import java.util.List;
import com.fl.model.MatchDTO;
import com.fl.model.MemberDTO;

public interface MyPageService {
	// 내 매치내역 리스트
    public List<MatchDTO> listMyMatch(long memberCode);
    
    // 회원 정보 불러오기 
    public MemberDTO readMember(long memberCode);
}