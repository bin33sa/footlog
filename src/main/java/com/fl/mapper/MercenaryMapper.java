package com.fl.mapper;

// import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.fl.model.MercenaryDTO; // DTO 위치 확인 필요

public interface MercenaryMapper {
//    // 게시글 등록
//    public void insertMercenary(MercenaryDTO dto) throws SQLException;
//    
//    // 게시글 수정
//    public void updateMercenary(MercenaryDTO dto) throws SQLException;
//    
//    // ✅ 수정: 서비스 임플에서 Map을 보내므로 타입을 Map으로 일치시킴
//    public void deleteMercenary(Map<String, Object> map) throws SQLException;
//    
//    // ✅ 수정: XML의 #{recruit_id}와 파라미터명을 맞춤 (가독성)
//    public void updateHitCount(long recruit_id) throws SQLException;
//    
//    // ✅ 수정: XML의 #{recruit_id}와 파라미터명을 맞춤
//    public MercenaryDTO findById(long recruit_id);
    
    public List<MercenaryDTO> listMercenary(Map<String, Object> map);
    
//    public int dataCount(Map<String, Object> map);
}