package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.mapper.activity.ActivityMapper;
import com.nihao.crm.service.activity.CreateActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * CreateActivity接口的实现类
 */
@Service("createActivity")
public class CreateActivityImpl implements CreateActivity {
    @Autowired
    ActivityMapper activityMapper;

    @Override
    public boolean addActivity(Activity activity) {
        return activityMapper.insertActivity(activity) > 0 ? true : false;
    }
}
