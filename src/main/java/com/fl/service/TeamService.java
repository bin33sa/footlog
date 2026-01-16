package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.PageResult;
import com.fl.model.TeamDTO;

public interface TeamService {
	
	// 1. 구단 생성 (구단장 자동 등록 포함)
	public void insertTeam(TeamDTO dto, Long member_code) throws Exception;
	
	// 2. 구단 리스트 조회 (페이징, 검색, 정렬 포함)
	public PageResult<TeamDTO> listTeam(int pageNo, int size, String keyword, String sort, long member_code);
	
	// 3. 구단 상세 조회 (비로그인용)
	public TeamDTO readTeam(long team_code);
	
	// 4. 구단 상세 조회 (로그인용 - 좋아요 여부 포함)
	public TeamDTO readTeam(long team_code, Long member_code);
	
	// 5. 내 구단 목록 조회 (사이드바 등)
	public List<TeamDTO> readMyTeam(long member_code);
	
	// 6. 구단 삭제 (비활성화 status=0 처리)
	public void deleteTeam(long team_code) throws Exception;
	
	// 7. 좋아요 등록/취소 (토글 로직)
	public void insertTeamLike(Map<String, Object> map) throws Exception;
	
	// 8. 좋아요 개수 조회 (AJAX 갱신용)
	public int teamLikeCount(long team_code);
	
	// 9. 구단 가입 신청
	public void insertJoinRequest(Map<String, Object> map) throws Exception;
	
	// 10. 가입 상태 확인 (15:멤버, 1:대기, 0:가입가능)
    public int checkJoinStatus(long team_code, long member_code);

    
    public boolean isLeader(long team_code, long member_code);
}