package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.remark.ActivityRemark;
import com.nihao.crm.mapper.activity.remark.ActivityRemarkMapper;
import com.nihao.crm.service.activity.QueryAllDataActivityRemark;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * QueryAllDataActivityRemark接口的实现类
 */
@Service("queryAllDataActivityRemark")
public class QueryAllDataActivityRemarkImpl implements QueryAllDataActivityRemark {
    @Autowired
    ActivityRemarkMapper activityRemarkMapper;

    @Override
    public List<ActivityRemark> queryAllActivityRemark() {
        return activityRemarkMapper.getAllActivityRemark();
    }
}
