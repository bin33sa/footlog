package com.fl.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.mapper.TeamMapper;
import com.fl.model.PageResult;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;
import com.fl.mybatis.support.MapperContainer;

public class TeamServiceImpl implements TeamService {
	
	private TeamMapper mapper = MapperContainer.get(TeamMapper.class);
	
	@Override
	public void insertTeam(TeamDTO dto, Long member_code) throws Exception {
		try {
			mapper.insertTeam(dto);
			
			Map<String, Object> map = new HashMap<>();
			map.put("team_code", dto.getTeam_code());
			map.put("member_code", member_code);
			map.put("role_level", 10); 
			map.put("position", "구단장"); 
			
			mapper.insertTeamMember(map);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e; 
		}
	}

	@Override
	public PageResult<TeamDTO> listTeam(int pageNo, int size, String keyword, String sort, long member_code) {
		int offset = (pageNo - 1) * size;
		
		Map<String, Object> map = new HashMap<>();
		map.put("offset", offset);
		map.put("size", size);
		map.put("keyword", keyword);
		map.put("sort", sort);
		map.put("member_code", member_code);
		
		List<TeamDTO> list = mapper.listTeam(map);
		int dataCount = mapper.teamCount(map);
		int totalPage = (int) Math.ceil((double) dataCount / size);
		
		return new PageResult<>(list, pageNo, totalPage, dataCount);
	}

	@Override
	public TeamDTO readTeam(long team_code) {
		return readTeam(team_code, 0L);
	}

    
	@Override
	public TeamDTO readTeam(long team_code, Long member_code) {
		TeamDTO dto = null;
		
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("team_code", team_code);
			// 로그인 안 했으면 0, 했으면 member_code 전달
			map.put("member_code", (member_code == null) ? 0 : member_code);
			
			// 이 쿼리 하나로 정보+좋아요여부(user_liked) 다 가져옴
			dto = mapper.readTeam(map);
			
			if (dto != null) {
				if(dto.getDescription() != null) {
					dto.setDescription(dto.getDescription().replaceAll("\n", "<br>"));
				}
                
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public List<TeamDTO> readMyTeam(long member_code) {
	    List<TeamDTO> list = null;
	    try {
	        list = mapper.readMyTeam(member_code);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}

	@Override
	public void insertTeamLike(Map<String, Object> map) throws Exception {
		try {
            // 좋아요 토글 로직: 화면에서 보낸 user_Liked 값("true"/"false")을 보고 판단
			String userLiked = (String) map.get("user_Liked");
			
			if ("true".equals(userLiked)) {
                // 이미 좋아요 누른 상태면 -> 삭제
				mapper.deleteTeamLike(map);
			} else {
                // 안 누른 상태면 -> 추가
				mapper.insertTeamLike(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
		
	@Override
	public void deleteTeamLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteTeamLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int teamLikeCount(long team_code) { 
		try {
			return mapper.teamLikeCount(team_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0; 
	}
	
	@Override
	public boolean isUserTeamLiked(Map<String, Object> map) {
		// XML에 쿼리가 없다면 에러가 나므로, 사용하지 않는다면 false 리턴하거나 메서드 자체를 정리해야 함
        // 현재 로직에서는 readTeam에서 처리하므로 필요 없음
		return false; 
	}

	@Override
	public List<TeamDTO> listTeam(Map<String, Object> map) { return null; }

	@Override
	public int dataCount(Map<String, Object> map) { return 0; }

	@Override
	public void updateTeam(TeamDTO dto) throws Exception {}

	@Override
	public void deleteTeam(long team_code) throws Exception {}

	@Override
	public List<TeamMemberDTO> listTeamMember(long team_code) { return null; }

	@Override
	public void insertTeamMember(TeamMemberDTO dto) throws Exception {}

	@Override
	public void deleteTeamMember(Map<String, Object> map) throws Exception {}

	@Override
	public TeamMemberDTO readTeamMember(Map<String, Object> map) { return null; }

}