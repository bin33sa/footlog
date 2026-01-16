package com.fl.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fl.mapper.MyTeamMapper;
import com.fl.model.BoardReplyDTO;
import com.fl.model.FileDTO;
import com.fl.model.GalleryDTO;
import com.fl.model.JoinRequestDTO;
import com.fl.model.ScheduleDTO;
import com.fl.model.TeamBoardDTO;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;
import com.fl.model.VoteDTO;
import com.fl.model.VoteOptionDTO;
import com.fl.mybatis.support.MapperContainer;

public class MyTeamServiceImpl implements MyTeamService {

	private MyTeamMapper mapper = MapperContainer.get(MyTeamMapper.class);

	@Override
	public List<TeamDTO> listMyTeam(long member_code) {
		try {
			return mapper.listMyTeam(member_code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e; 
		}
	}

	@Override
	public TeamDTO readTeamInfo(long team_code) {
		try {
			return mapper.readTeamInfo(team_code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public TeamMemberDTO readMyTeamStatus(Map<String, Object> map) {
		try {
			return mapper.readMyTeamStatus(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateTeamMember(TeamMemberDTO dto) throws Exception {
		try {
			mapper.updateTeamMember(dto);		
		} catch (Exception e) {
			e.printStackTrace();

			throw e;
		}
	}
	
	@Override
	public void updateTeamInfo(TeamDTO dto) throws Exception {
		try {
			mapper.updateTeamInfo(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void leaveTeam(Map<String, Object> map) throws Exception {
		try {
			long team_code = Long.parseLong(map.get("team_code").toString());
			mapper.deleteMyTeamHistory(map);
			mapper.updateTeamMemberCountDown(team_code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<TeamMemberDTO> listTeamMember(Map<String, Object> map) {
		try {
			return mapper.listTeamMember(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCountTeamMember(Map<String, Object> map) {
		try {
			return mapper.dataCountTeamMember(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateMemberRole(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMemberRole(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void kickMember(Map<String, Object> map) throws Exception {
		try {
			long team_code = Long.parseLong(map.get("team_code").toString());
			mapper.deleteTeamMember(map);
			mapper.updateTeamMemberCountDown(team_code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int readMemberRoleLevel(long memberCode, long teamCode) {
	    try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("member_code", memberCode);
	        map.put("team_code", teamCode);
	        
	        Integer level = mapper.readMemberRoleLevel(map);

	        return (level == null) ? 0 : level;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return 0;
	    }
	}
	
	@Override
	public List<JoinRequestDTO> listJoinRequest(long team_code) {
        try {
            return mapper.listJoinRequest(team_code);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

	@Override
	public void processJoinAccept(Map<String, Object> map) throws Exception {
		try {
			TeamMemberDTO memberDto = new TeamMemberDTO();
			memberDto.setMember_code(Long.parseLong(map.get("member_code").toString()));
			memberDto.setTeam_code(Long.parseLong(map.get("team_code").toString()));
			memberDto.setPosition((String)map.get("position")); 

			mapper.insertTeamMemberFromRequest(memberDto);
			mapper.updateTeamMemberCountUp(memberDto.getTeam_code());
			mapper.deleteJoinRequest(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void processJoinReject(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteJoinRequest(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<ScheduleDTO> listMonthSchedule(Map<String, Object> map) {
		try {
			return mapper.listMonthSchedule(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertSchedule(ScheduleDTO dto) throws Exception {
		try {
			mapper.insertSchedule(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateSchedule(ScheduleDTO dto) throws Exception {
		try {
			mapper.updateSchedule(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteSchedule(long schedule_code) throws Exception {
		try {
			mapper.deleteSchedule(schedule_code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	// ==========================================
	// 5. [투표 관리]
	// ==========================================
	@Override
	public void insertVote(VoteDTO dto) throws Exception {
		try {
			mapper.insertVote(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertVoteOption(VoteOptionDTO dto) throws Exception {
		try {
			mapper.insertVoteOption(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<VoteDTO> listVote(Map<String, Object> map) {
		try {
			return mapper.listVote(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public VoteDTO readVote(Map<String, Object> map) {
		try {
			return mapper.readVote(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<VoteOptionDTO> listVoteOptions(Map<String, Object> map) {
		try {
			return mapper.listVoteOptions(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int checkVoteHistory(Map<String, Object> map) {
		try {
			return mapper.checkVoteHistory(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void vote(Map<String, Object> map) throws Exception {
		try {
			mapper.insertVoteHistory(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertTeamBoard(TeamBoardDTO dto) throws Exception {
		try {
			mapper.insertTeamBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<TeamBoardDTO> listTeamBoard(Map<String, Object> map) {
		try {
			return mapper.listTeamBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCountTeamBoard(Map<String, Object> map) {
		try {
			return mapper.dataCountTeamBoard(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public TeamBoardDTO readTeamBoard(long board_team_code) {
		try {
			mapper.updateHitCount(board_team_code);
			return mapper.readTeamBoard(board_team_code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateTeamBoard(TeamBoardDTO dto) throws Exception {
		try {
			mapper.updateTeamBoard(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteTeamBoard(long board_team_code) throws Exception {
		try {
			mapper.deleteTeamBoard(board_team_code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertGallery(GalleryDTO dto) throws Exception {
		try {
			mapper.insertGallery(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<GalleryDTO> listGallery(Map<String, Object> map) {
		List<GalleryDTO> list = null;
		try {
			list = mapper.listGallery(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int galleryDataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.galleryDataCount(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
    public GalleryDTO readGallery(long gallery_code) {
        GalleryDTO dto = null;
        
        try {
            dto = mapper.readGallery(gallery_code);
          
            if(dto != null && dto.getContent() != null) {
                dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return dto;
    }

	@Override
	public void deleteGallery(long gallery_code) throws Exception {
		try {
			mapper.deleteGallery(gallery_code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertReply(BoardReplyDTO dto) throws Exception {
		try {
			mapper.insertReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<BoardReplyDTO> listReply(Map<String, Object> map) {
		try {
			return mapper.listReply(map);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		try {
			return mapper.replyCount(map);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteReply(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int checkGalleryLike(Map<String, Object> map) {
		try {
			return mapper.checkGalleryLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public void insertGalleryLike(Map<String, Object> map) throws Exception {
		try {
			mapper.insertGalleryLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteGalleryLike(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteGalleryLike(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int countGalleryLike(long gallery_code) {
		try {
			return mapper.countGalleryLike(gallery_code);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	@Override
    public void updateReply(Map<String, Object> map) throws Exception {
        try {
            mapper.updateReply(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
	
	@Override
    public void updateGallery(GalleryDTO dto) throws Exception {
        try {
            mapper.updateGallery(dto);
            if(dto.getListFile() != null && !dto.getListFile().isEmpty()) {             
                mapper.deleteGalleryFiles(dto.getGallery_code());               
                for(FileDTO vo : dto.getListFile()) {
                    vo.setGallery_code(dto.getGallery_code());
                    mapper.insertGalleryFile(vo); 
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
	
}