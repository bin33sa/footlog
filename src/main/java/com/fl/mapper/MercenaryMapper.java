package com.fl.mapper;

import java.sql.SQLException;

import java.util.List;
import java.util.Map;

import com.fl.model.MercenaryDTO; // DTO 위치 확인 필요
import com.fl.model.MercenaryReplyDTO;

public interface MercenaryMapper {

    public void insertMercenary(MercenaryDTO dto) throws SQLException;
    public void updateMercenary(MercenaryDTO dto) throws SQLException;
    public void deleteMercenary(Map<String, Object> map) throws SQLException;
    public void updateHitCount(long recruit_id) throws SQLException;
    public MercenaryDTO findById(long recruit_id);
    
    public List<MercenaryDTO> listMercenary(Map<String, Object> map);
    public List<MercenaryDTO> listTeam(Map<String, Object> map);    
    public int dataCount(Map<String, Object> map);
    
    public void insertReply(MercenaryReplyDTO dto) throws Exception;
    public int replyCount(Map<String, Object> map);
    public List<MercenaryReplyDTO> listReply(Map<String, Object> map);
    public void deleteReply(Map<String, Object> map) throws Exception;
    public List<MercenaryReplyDTO> listReplyAnswer(Map<String, Object> map);

}