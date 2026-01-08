package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.MercenaryMapper;
import com.fl.model.MercenaryDTO;
import com.fl.mybatis.support.MapperContainer;

public class MercenaryServiceImpl implements MercenaryService {
    // 강사님 스타일: MapperContainer를 통해 Mapper 객체 획득
    private MercenaryMapper mapper = MapperContainer.get(MercenaryMapper.class);

    /*
    @Override
    public void insertMercenary(MercenaryDTO dto) throws Exception {
        try {
            mapper.insertMercenary(dto);
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // 등록 실패 시 컨트롤러로 예외를 던져 에러 페이지 처리를 유도
        }
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
    public void deleteMercenary(Map<String, Object> map) throws Exception {
        try {
            mapper.deleteMercenary(map);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public MercenaryDTO findById(long recruitId) {
        MercenaryDTO dto = null;
        try {
            dto = mapper.findById(recruitId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
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
//
//    @Override
//    public int dataCount(Map<String, Object> map) {
//        int result = 0;
//        try {
//            result = mapper.dataCount(map);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return result;
//    }
//
//    @Override
//    public void updateHitCount(long recruitId) throws Exception {
//        try {
//            mapper.updateHitCount(recruitId);
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw e;
//        }
//    }
}