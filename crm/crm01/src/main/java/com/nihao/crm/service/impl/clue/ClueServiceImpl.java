package com.nihao.crm.service.impl.clue;

import com.nihao.crm.entityClass.clue.Clue;
import com.nihao.crm.entityClass.clue.ClueDataAndClueNumber;
import com.nihao.crm.entityClass.clue.remark.ClueRemark;
import com.nihao.crm.mapper.clue.ClueMapper;
import com.nihao.crm.mapper.clue.remark.ClueRemarkMapper;
import com.nihao.crm.service.clue.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * ClueService接口的实现类
 */
@Service("clueService")
public class ClueServiceImpl implements ClueService {
    @Autowired
    ClueMapper clueMapper;

    @Autowired
    ClueRemarkMapper clueRemarkMapper;

    @Override
    public ClueDataAndClueNumber queryClue(Map<String, Object> map) {
        return new ClueDataAndClueNumber(clueMapper.selectClue(map), clueMapper.selectClueNumber(map));
    }

    @Override
    public boolean insertClue(Clue clue) {
        return clueMapper.insert(clue) > 0;
    }

    @Override
    public int deleteClue(String[] ids) {
        return clueMapper.dropClue(ids);
    }

    @Override
    public Clue selectClueById(String id) {
        return clueMapper.byIdQueryClue(id);
    }

    @Override
    public int updateClue(Clue clue) {
        return clueMapper.updateByPrimaryKeySelective(clue);
    }

    @Override
    public List<ClueRemark> selectClueRemark(String id) {
        return clueRemarkMapper.byIdSelectClueRemark(id);
    }
}
