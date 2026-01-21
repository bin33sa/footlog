package com.fl.service;

import java.util.List;
import com.fl.model.MatchDTO;
import com.fl.model.MatchHistoryDTO;
import com.fl.model.MemberDTO;
import com.fl.model.MercenaryDTO;

public interface MyPageService {
	// 내 매치내역 리스트
    public List<MatchDTO> listMyMatch(long memberCode);
    
    // 회원 정보 불러오기 
    public MemberDTO readMember(long memberCode);
    
    // 매치 신청 내역 불러오기 
    public List<MatchHistoryDTO> listMatchApply(long member_code);
    
    // 용병 신청 내역 불러오기 
    public List<MercenaryDTO> listMyMercenaryPosts(long member_code);


}