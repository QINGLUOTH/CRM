package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.remark.ActivityRemark;

import java.util.List;
import java.util.Map;

public interface QueryActivityRemarkData {
    /**
     * 通过活动id查询活动备注信息
     * @return com.nihao.crm.entityClass.activity.remark.ActivityRemark
     */
    List<ActivityRemark> byIdQueryActivityRemark(Map<String, String> map);
}
