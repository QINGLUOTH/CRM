package com.nihao.crm.service.impl.activity;

import com.nihao.crm.mapper.activity.ActivityMapper;
import com.nihao.crm.mapper.activity.remark.ActivityRemarkMapper;
import com.nihao.crm.service.activity.RemoveActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * RemoveActivity接口的实现类
 */
@Service("removeActivity")
public class RemoveActivityImpl implements RemoveActivity {
    @Autowired
    ActivityMapper activityMapper;

    @Autowired
    ActivityRemarkMapper activityRemarkMapper;

    @Override
    public boolean removeActivityAndRemoveActivityRemark(String[] ids) {
        activityRemarkMapper.removeActivityRemark(ids);
        return activityMapper.removeActivity(ids) > 0 ? true : false;
    }
}
