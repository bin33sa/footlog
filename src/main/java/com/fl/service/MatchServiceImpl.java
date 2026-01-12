package com.fl.service;

import java.util.List;
import java.util.Map;

import com.fl.mapper.MatchMapper;
import com.fl.model.MatchDTO;
import com.fl.mybatis.support.MapperContainer;

public class MatchServiceImpl implements MatchService{
	private MatchMapper mapper = MapperContainer.get(MatchMapper.class);
	
	@Override
	public void insertMatch(MatchDTO dto) throws Exception {
		
		try {
			mapper.insertMatch(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateMatch(MatchDTO dto) throws Exception {
		try {
			mapper.updateMatch(dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteMatch(List<Long> list) throws Exception {
		try {
			mapper.deleteMatch(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

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

	@Override
	public List<MatchDTO> listMatch(Map<String, Object> map) {
		List<MatchDTO> list = null;
		try {
			list = mapper.listMatch(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<MatchDTO> listMyMatch(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MatchDTO findById(long num) {
		// TODO Auto-generated method stub
		return null;
	}
	

	@Override
	public MatchDTO findByPrev(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MatchDTO findByNext(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertNoticeFile(MatchDTO dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteNoticeFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<MatchDTO> listNoticeFile(long num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MatchDTO findByFileId(long fileNum) {
		// TODO Auto-generated method stub
		return null;
	}



}
