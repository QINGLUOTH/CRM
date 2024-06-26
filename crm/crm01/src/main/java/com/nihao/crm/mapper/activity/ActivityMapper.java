package com.nihao.crm.mapper.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.entityClass.activity.ActivityAndIds;

import java.util.List;
import java.util.Map;

public interface ActivityMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_activity
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_activity
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    int insert(Activity row);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_activity
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    int insertSelective(Activity row);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_activity
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    Activity selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_activity
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    int updateByPrimaryKeySelective(Activity row);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table t_activity
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    int updateByPrimaryKey(Activity row);

    /**
     * 创建市场活动
     */
    int insertActivity(Activity activity);

    /**
     * 查询所有的活动信息
     */
    List<Activity> getAll();

    /**
     * 通过活动id查询活动数据
     */
    Activity byIdSelectActivity(Map<String, String> id);

    /**
     * 模糊查询活动信息
     */
    List<Activity> likeSelectActivity(Map<String, Object> map);

    /**
     * 批量删除活动信息
     */
    int removeActivity(String[] array);

    /**
     * 通过活动id修改活动信息
     */
    int alterActivity(ActivityAndIds activityAndIds);

    /**
     * 查询符合条件的数据的总条数
     */
    int selectActivityNumber(Map<String, Object> map);

    /**
     * 通过活动id批量查询活动数据
     */
    List<Activity> byIdQueryActivity(String[] array);

    /**
     * 批量创建活动
     */
    int batchAddActivity(List<Activity> activities);
}