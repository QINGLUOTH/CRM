package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.remark.ActivityRemark;

public interface AlterActivityRemark {
    /**
     * 修改活动备注信息
     * @param activityRemark com.nihao.crm.entityClass.activity.remark.ActivityRemark
     * @return true表示修改成功, false表示修改失败
     */
    boolean alterActivityRemark(ActivityRemark activityRemark);
}
