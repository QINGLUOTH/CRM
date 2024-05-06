package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.mapper.activity.ActivityMapper;
import com.nihao.crm.service.activity.AddActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * AddActivity接口的实现类
 */
@Service("addActivity")
public class AddActivityImpl implements AddActivity {
    @Autowired
    ActivityMapper activityMapper;

    @Override
    public boolean createActivityBatch(List<Activity> activities) {
        return activityMapper.batchAddActivity(activities) > 0 ? true : false;
    }
}
