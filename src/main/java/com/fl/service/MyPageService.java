package com.fl.service;

import java.util.List;
import java.util.Map;

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
    public int dataCountMatch(long member_code);
    public List<MatchHistoryDTO> listMatchApply(Map<String, Object> map);
    
    // 용병 활동 내역 불러오기 
    public int dataCountMyMercenary(long member_code);
    public List<MercenaryDTO> listMyMercenaryPosts(Map<String, Object> map);


}