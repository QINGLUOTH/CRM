package com.nihao.crm.mapper.clue;

import com.nihao.crm.entityClass.clue.Clue;

import java.util.List;
import java.util.Map;

public interface ClueMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_clue
     *
     * @mbg.generated Thu Jul 07 16:22:28 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_clue
     *
     * @mbg.generated Thu Jul 07 16:22:28 CST 2022
     */
    int insert(Clue row);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_clue
     *
     * @mbg.generated Thu Jul 07 16:22:28 CST 2022
     */
    int insertSelective(Clue row);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_clue
     *
     * @mbg.generated Thu Jul 07 16:22:28 CST 2022
     */
    Clue selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_clue
     *
     * @mbg.generated Thu Jul 07 16:22:28 CST 2022
     */
    int updateByPrimaryKeySelective(Clue row);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_clue
     *
     * @mbg.generated Thu Jul 07 16:22:28 CST 2022
     */
    int updateByPrimaryKey(Clue row);

    /**
     * 根据查询条件, 查询所有数据
     */
    List<Clue> selectClue(Map<String, Object> map);

    /**
     * 查询符合条件的数据条数
     */
    int selectClueNumber(Map<String, Object> map);

    /**
     * 通过线索id. 删除线索
     */
    int dropClue(String[] ids);

    /**
     * 通过线索id, 查询线索信息
     */
    Clue byIdQueryClue(String id);
}