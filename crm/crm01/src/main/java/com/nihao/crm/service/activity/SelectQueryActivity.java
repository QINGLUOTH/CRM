package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.entityClass.activity.ActivityAndActivityNumber;

import java.util.List;
import java.util.Map;

public interface SelectQueryActivity {
    /**
     * 模糊查询活动信息
     */
    ActivityAndActivityNumber likeQueryActivity(Map<String, Object> map);
}
