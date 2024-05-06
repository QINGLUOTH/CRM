package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.remark.ActivityRemark;

public interface CreateActivityRemark {
    /**
     * 添加活动备注信息
     * @param activityRemark com.nihao.crm.entityClass.activity.remark.ActivityRemark
     * @return boolean类型的数据, true表示添加成功, false表示添加失败
     */
    boolean addActivityRemark(ActivityRemark activityRemark);
}
