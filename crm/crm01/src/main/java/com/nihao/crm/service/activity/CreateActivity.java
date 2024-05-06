package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.Activity;

public interface CreateActivity {
    /**
     * 创建市场活动
     * @return boolean类型的数据, true表示创建成功, false表示创建失败
     */
    boolean addActivity(Activity activity);
}
