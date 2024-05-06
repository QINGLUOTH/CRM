package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.entityClass.activity.ActivityAndIds;
import com.nihao.crm.mapper.activity.ActivityMapper;
import com.nihao.crm.service.activity.AlterActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * AlterActivity接口的实现类
 */
@Service("alterActivity")
public class AlterActivityImpl implements AlterActivity {
    @Autowired
    ActivityMapper activityMapper;

    @Override
    public boolean changeActivity(ActivityAndIds activityAndIds) {
        return activityMapper.alterActivity(activityAndIds) > 0 ? true : false;
    }
}
