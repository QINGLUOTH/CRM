package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.remark.ActivityRemark;
import com.nihao.crm.mapper.activity.remark.ActivityRemarkMapper;
import com.nihao.crm.service.activity.CreateActivityRemark;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * CreateActivityRemark接口的实现类
 */
@Service("createActivityRemark")
public class CreateActivityRemarkImpl implements CreateActivityRemark {
    @Autowired
    ActivityRemarkMapper activityRemarkMapper;

    @Override
    public boolean addActivityRemark(ActivityRemark activityRemark) {
        return activityRemarkMapper.createActivityRemark(activityRemark) > 0 ? true : false;
    }
}
