package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.mapper.activity.ActivityMapper;
import com.nihao.crm.service.activity.ByIdSelectActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * ByIdSelectActivity接口的实现类
 */
@Service(value = "byIdSelectActivity")
public class ByIdSelectActivityImpl implements ByIdSelectActivity {
    @Autowired
    ActivityMapper activityMapper;

    @Override
    public List<Activity> selectActivity(String[] id) {
        return activityMapper.byIdQueryActivity(id);
    }
}
