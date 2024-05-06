package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.mapper.activity.ActivityMapper;
import com.nihao.crm.service.activity.QueryActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * QueryActivity接口的实现类
 */
@Service("queryActivity")
public class QueryActivityImpl implements QueryActivity {
    @Autowired
    ActivityMapper activityMapper;

    @Override
    public Activity byIdQueryActivity(Map<String, String> map) {
        return activityMapper.byIdSelectActivity(map);
    }
}
