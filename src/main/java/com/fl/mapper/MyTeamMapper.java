package com.fl.mapper;


import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.fl.model.BoardReplyDTO;
import com.fl.model.FileDTO;
import com.fl.model.GalleryDTO;
import com.fl.model.JoinRequestDTO;
import com.fl.model.ScheduleDTO;
import com.fl.model.TeamBoardDTO;
import com.fl.model.TeamDTO;
import com.fl.model.TeamMemberDTO;
import com.fl.model.VoteDTO;

@Mapper
public interface MyTeamMapper {

	public List<TeamDTO> listMyTeam(long member_code);
	
	public Integer readMemberRoleLevel(Map<String, Object> map);
	
	public TeamDTO readTeamInfo(long team_code);
	
	public List<TeamBoardDTO> listHomeTeamBoard(long team_code);
	
	public TeamMemberDTO readMyTeamStatus(Map<String, Object> map);

	public void updateTeamInfo(TeamDTO dto);

	public void deleteMyTeamHistory(Map<String, Object> map);

	public void updateTeamMemberCountDown(long team_code);

	public void updateTeamMemberCountUp(long team_code);

	public List<TeamMemberDTO> listTeamMember(Map<String, Object> map);

	public int dataCountTeamMember(Map<String, Object> map);

	public void updateMemberRole(Map<String, Object> map);

	public void updateTeamMember(TeamMemberDTO dto);
	
	public void deleteTeamMember(Map<String, Object> map);

	public List<JoinRequestDTO> listJoinRequest(long team_code);
	
	public void insertTeamMemberFromRequest(TeamMemberDTO dto);

	public void deleteJoinRequest(Map<String, Object> map);

	public void insertSchedule(ScheduleDTO dto) throws SQLException;
	
	public void updateSchedule(ScheduleDTO dto) throws SQLException;
	
    public List<ScheduleDTO> listSchedule(Map<String, Object> map);

    public void deleteSchedule(Map<String, Object> map) throws SQLException;

	public void insertVote(VoteDTO dto);


	public List<VoteDTO> listVote(Map<String, Object> map);

	public VoteDTO readVote(Map<String, Object> map);

	public int checkVoteHistory(Map<String, Object> map);

	public void insertVoteHistory(Map<String, Object> map);
	
	public void deleteVote(Map<String, Object> map) throws SQLException;
	
	public void deleteMemberVoteAll(Map<String, Object> map) throws Exception;
	
	public void deleteScheduleByVote(Map<String, Object> map) throws Exception;
	
	public Integer readMemberVoteState(Map<String, Object> map);
	
	public void insertTeamBoard(TeamBoardDTO dto) throws Exception;
	
	public List<TeamBoardDTO> listTeamBoard(Map<String, Object> map);
	
	public int dataCountTeamBoard(Map<String, Object> map);
	
	public TeamBoardDTO readTeamBoard(long board_team_code);
	
	public void updateHitCount(long board_team_code) throws Exception;
	
	public void updateTeamBoard(TeamBoardDTO dto) throws Exception;
	
	public void deleteTeamBoard(long board_team_code) throws Exception;

	public TeamBoardDTO preReadTeamBoard(Map<String, Object> map) throws Exception;
	
	public TeamBoardDTO nextReadTeamBoard(Map<String, Object> map) throws Exception;
	
	public void insertBoardReply(BoardReplyDTO dto) throws SQLException;
	
    public List<BoardReplyDTO> listBoardReply(Map<String, Object> map);
    
    public List<FileDTO> listFile(long board_team_code);
    
    public int dataCountBoardReply(Map<String, Object> map);
    
    public void deleteBoardReply(Map<String, Object> map) throws SQLException;

    public void insertBoardLike(Map<String, Object> map) throws SQLException;
    
    public void deleteBoardLike(Map<String, Object> map) throws SQLException;
    
    public int countBoardLike(long board_team_code);
    
    public int checkBoardLike(Map<String, Object> map);
	
	public void insertGallery(GalleryDTO dto);
	
	public List<GalleryDTO> listGallery(Map<String, Object> map);
	
	public int galleryDataCount(Map<String, Object> map);
	
	public GalleryDTO readGallery(long gallery_code);
	
	public List<FileDTO> listGalleryFiles(long gallery_code);
	
	public void updateGalleryHitCount(long gallery_code);
	
	public void updateGallery(GalleryDTO dto);
	
	public void deleteGallery(long gallery_code);
	
	public void insertGalleryFile(FileDTO dto); 

    public void insertReply(BoardReplyDTO dto);
    
    public List<BoardReplyDTO> listReply(Map<String, Object> map);
    
    public int replyCount(Map<String, Object> map);
    
    public void deleteReply(Map<String, Object> map);
    
    public void insertGalleryLike(Map<String, Object> map);
    
    public void deleteGalleryLike(Map<String, Object> map);
    
    public int checkGalleryLike(Map<String, Object> map);
    
    public int countGalleryLike(long gallery_code);
    
    public void updateReply(Map<String, Object> map) throws Exception;
    
    public void deleteGalleryFiles(long gallery_code) throws Exception;
    
    public void updateBoardReply(Map<String, Object> map) throws SQLException;
}