package com.fl.mapper;

import java.util.List;
import com.fl.model.BoardFaqDTO;

public interface BoardFaqMapper {

    public void insertFaq(BoardFaqDTO dto);

    public List<BoardFaqDTO> listFaq(int category);

    public void deleteFaq(long board_faq_code);

    public void updateFaq(BoardFaqDTO dto);
    
    public BoardFaqDTO findByCode(long board_faq_code);
}