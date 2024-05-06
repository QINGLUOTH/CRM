package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.remark.ActivityRemark;
import com.nihao.crm.mapper.activity.remark.ActivityRemarkMapper;
import com.nihao.crm.service.activity.AlterActivityRemark;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * AlterActivityRemark接口的实现类
 */
@Service("alterActivityRemark")
public class AlterActivityRemarkImpl implements AlterActivityRemark {
    @Autowired
    ActivityRemarkMapper activityRemarkMapper;

    @Override
    public boolean alterActivityRemark(ActivityRemark activityRemark) {
        return activityRemarkMapper.updateActivityRemark(activityRemark) > 0 ? true : false;
    }
}
