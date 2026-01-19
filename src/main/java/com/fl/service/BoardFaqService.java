package com.fl.service;

import java.util.List;
import com.fl.model.BoardFaqDTO;


public interface BoardFaqService {
    public void insertFaq(BoardFaqDTO dto) throws Exception;
    public List<BoardFaqDTO> listFaq(int category);
    public void deleteFaq(long board_faq_code) throws Exception;
    
}