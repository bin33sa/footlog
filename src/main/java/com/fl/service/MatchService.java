package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.model.MatchDTO;

public interface MatchService {
	public void insertMatch(MatchDTO dto) throws Exception;
	public void updateMatch(MatchDTO dto) throws Exception;
	public void deleteMatch(List<Long> list) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<MatchDTO> listMatch(Map<String, Object> map);
	public List<MatchDTO> listMyMatch(Map<String, Object> map);
	public MatchDTO findById(long num);
	public Long getUserTeamCode(long member_code);
	public MatchDTO findByPrev(Map<String, Object> map);
	public MatchDTO findByNext(Map<String, Object> map);
	public void updateHitCount(long num) throws Exception;
	
	public void insertNoticeFile(MatchDTO dto) throws Exception;
	public void deleteNoticeFile(Map<String, Object> map) throws Exception;
	public List<MatchDTO> listNoticeFile(long num);
	public MatchDTO findByFileId(long fileNum);
	
}
