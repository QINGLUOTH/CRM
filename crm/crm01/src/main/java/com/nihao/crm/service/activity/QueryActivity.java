package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.Activity;

import java.util.Map;

public interface QueryActivity {
    /**
     * 通过id查询活动信息
     */
    Activity byIdQueryActivity(Map<String, String> map);
}
