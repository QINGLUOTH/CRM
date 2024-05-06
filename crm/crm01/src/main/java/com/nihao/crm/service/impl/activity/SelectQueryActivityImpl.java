package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.entityClass.activity.ActivityAndActivityNumber;
import com.nihao.crm.mapper.activity.ActivityMapper;
import com.nihao.crm.service.activity.SelectQueryActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * SelectQueryActivity的实现类
 */
@Service("selectQueryActivity")
public class SelectQueryActivityImpl implements SelectQueryActivity {
    @Autowired
    ActivityMapper activityMapper;

    @Override
    public ActivityAndActivityNumber likeQueryActivity(Map<String, Object> map) {
        return new ActivityAndActivityNumber(activityMapper.likeSelectActivity(map), activityMapper.selectActivityNumber(map));
    }
}
