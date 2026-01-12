package com.fl.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.fl.model.MatchDTO;

public interface MatchMapper {
	public long noticeSeq();
	
	public void insertMatch(MatchDTO dto) throws SQLException;
	public void updateMatch(MatchDTO dto) throws SQLException;
	public void deleteMatch(List<Long> list) throws SQLException;
	
	public int dataCount(Map<String, Object> map);
	public List<MatchDTO> listMatch(Map<String, Object> map);
	public List<MatchDTO> listMyMatch(Map<String, Object> map);
	public MatchDTO getTeamcodeById(long num);
	public MatchDTO getTeamnameById(String name);
	public MatchDTO findByPrev(Map<String, Object> map);
	public MatchDTO findByNext(Map<String, Object> map);
	public void updateHitCount(long num) throws SQLException;
	
	public void insertNoticeFile(MatchDTO dto) throws SQLException;
	public void deleteNoticeFile(Map<String, Object> map) throws SQLException;
	public List<MatchDTO> listNoticeFile(long num);
	public MatchDTO findByFileId(long fileNum);
	
	
}
