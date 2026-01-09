package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.MercenaryMapper;
import com.fl.model.MercenaryDTO;
import com.fl.mybatis.support.MapperContainer;

public class MercenaryServiceImpl implements MercenaryService {
    private MercenaryMapper mapper = MapperContainer.get(MercenaryMapper.class);

    
    @Override
    public void insertMercenary(MercenaryDTO dto) throws Exception {
        try {
            mapper.insertMercenary(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // 
        }
    }
/*
    @Override
    public void deleteMercenary(Map<String, Object> map) throws Exception {
        try {
            mapper.deleteMercenary(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

*/
    @Override
    public List<MercenaryDTO> listMercenary(Map<String, Object> map) {
        List<MercenaryDTO> list = null;
        try {
            list = mapper.listMercenary(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
/*
    @Override
    public int dataCount(Map<String, Object> map) {
        int result = 0;
        try {
            result = mapper.dataCount(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
*/
    @Override
    public void updateHitCount(long recruitId) throws Exception {
       try {
            mapper.updateHitCount(recruitId);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }
	@Override
	public List<MercenaryDTO> listTeam(Map<String, Object> map) {
        List<MercenaryDTO> list = null;
        try {
            list = mapper.listTeam(map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public void updateMercenary(MercenaryDTO dto) throws Exception {
		try {
			mapper.updateMercenary(dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
		
	}
	@Override
	public MercenaryDTO findById(long recruit_id) {
		MercenaryDTO dto = null;
		try {
			dto = mapper.findById(recruit_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return dto;
	}

}