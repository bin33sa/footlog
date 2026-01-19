package com.fl.service;


import java.util.List;
import java.util.Map;
import com.fl.model.MercenaryDTO;
import com.fl.model.MercenaryReplyDTO;

public interface MercenaryService {
	
    public void insertMercenary(MercenaryDTO dto) throws Exception;
    public void updateMercenary(MercenaryDTO dto) throws Exception;
    public void deleteMercenary(Map<String, Object> map) throws Exception;
    
    public MercenaryDTO findById(long recruit_id);
    public List<MercenaryDTO> listMercenary(Map<String, Object> map);
    public List<MercenaryDTO> listTeam(Map<String, Object> map);    
    public int dataCount(Map<String, Object> map);
    public void updateHitCount(long recruit_Id) throws Exception;
    
    public void insertReply(MercenaryReplyDTO dto) throws Exception;
    public int replyCount(Map<String, Object> map);
    public List<MercenaryReplyDTO> listReply(Map<String, Object> map);
    public void deleteReply(Map<String, Object> map) throws Exception;
    public List<MercenaryReplyDTO> listReplyAnswer(Map<String, Object> map);
    
    public int getUserTeamLevel(Map<String, Object> map) throws Exception;
}