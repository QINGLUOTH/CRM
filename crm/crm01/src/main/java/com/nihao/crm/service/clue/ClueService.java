package com.nihao.crm.service.clue;

import com.nihao.crm.entityClass.clue.Clue;
import com.nihao.crm.entityClass.clue.ClueDataAndClueNumber;
import com.nihao.crm.entityClass.clue.remark.ClueRemark;

import java.util.List;
import java.util.Map;

public interface ClueService {
    /**
     * 查询线索信息
     * @param map map集合
     * @return com.nihao.crm.entityClass.clue.ClueDataAndClueNumber
     */
    ClueDataAndClueNumber queryClue(Map<String, Object> map);

    /**
     * 创建线索
     */
    boolean insertClue(Clue clue);

    /**
     * 通过线索id, 删除线索
     */
    int deleteClue(String[] ids);

    /**
     * 通过线索id, 查询线索数据
     */
    Clue selectClueById(String id);

    /**
     * 修改线索
     */
    int updateClue(Clue clue);

    /**
     * 通过线索id, 查询线索备注信息
     */
    List<ClueRemark> selectClueRemark(String id);
}
