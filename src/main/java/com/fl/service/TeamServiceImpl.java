package com.fl.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.mapper.TeamMapper;
import com.fl.model.PageResult;
import com.fl.model.TeamDTO;
import com.fl.mybatis.support.MapperContainer;

public class TeamServiceImpl implements TeamService {
    
    private TeamMapper mapper = MapperContainer.get(TeamMapper.class);

    // 구단 생성
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

    // 구단 리스트 조회
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

    // 구단 상세 조회
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
            map.put("member_code", (member_code == null) ? 0 : member_code);
            
            dto = mapper.readTeam(map);
            
            if (dto != null && dto.getDescription() != null) {
                dto.setDescription(dto.getDescription().replaceAll("\n", "<br>"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    // 내 구단 목록 조회
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
    public void deleteTeam(long team_code) throws Exception {
        try {
            mapper.deleteTeam(team_code);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    // 좋아요 등록/취소
    @Override
    public void insertTeamLike(Map<String, Object> map) throws Exception {
        try {
            String userLiked = (String) map.get("user_Liked");
            if ("true".equals(userLiked)) {
                mapper.deleteTeamLike(map);
            } else {
                mapper.insertTeamLike(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
    
    // 좋아요 개수 조회
    @Override
    public int teamLikeCount(long team_code) { 
        try {
            return mapper.teamLikeCount(team_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0; 
    }

    // 가입 신청 (유지)
    @Override
    public void insertJoinRequest(Map<String, Object> map) throws Exception {
        try {
            mapper.insertJoinRequest(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e; 
        }
    }    
      
    // [삭제됨] acceptJoinRequest
    // [삭제됨] rejectJoinRequest

    // 가입 상태 확인 (유지 - 오타 수정함 team_code)
    @Override
    public int checkJoinStatus(long team_code, long member_code) {
        int status = 0;
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("team_code", team_code); // team_ode 오타 수정됨
            map.put("member_code", member_code);
            status = mapper.checkJoinStatus(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // [삭제됨] listJoinRequest

    @Override
    public boolean isLeader(long team_code, long member_code) {
        Map<String, Object> map = new HashMap<>();
        map.put("team_code", team_code);
        map.put("member_code", member_code);
        return mapper.isLeader(map) > 0;
    }
}