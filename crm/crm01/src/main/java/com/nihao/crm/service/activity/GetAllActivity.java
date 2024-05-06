package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.Activity;

import java.util.List;

public interface GetAllActivity {
    /**
     * 获取所有用户的信息
     * @return List<Activity>
     */
    public List<Activity> getAllActivityInfo();
}
