package com.fl.service;

import java.util.List;
import java.util.Map;
import com.fl.model.MercenaryDTO;

public interface MercenaryService {
	
//    public void insertMercenary(MercenaryDTO dto) throws Exception;
//    public void updateMercenary(MercenaryDTO dto) throws Exception;
//    public void deleteMercenary(Map<String, Object> map) throws Exception;
    
//    public MercenaryDTO findById(long recruitId);
    public List<MercenaryDTO> listMercenary(Map<String, Object> map);
//    public int dataCount(Map<String, Object> map);
//    public void updateHitCount(long recruitId) throws Exception;
}