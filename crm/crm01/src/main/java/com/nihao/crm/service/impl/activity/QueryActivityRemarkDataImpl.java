package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.remark.ActivityRemark;
import com.nihao.crm.mapper.activity.remark.ActivityRemarkMapper;
import com.nihao.crm.service.activity.QueryActivityRemarkData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * QueryActivityRemarkData接口的实现类
 */
@Service("queryActivityRemarkData")
public class QueryActivityRemarkDataImpl implements QueryActivityRemarkData {
    @Autowired
    ActivityRemarkMapper activityRemarkMapper;

    @Override
    public List<ActivityRemark> byIdQueryActivityRemark(Map<String, String> map) {
        return activityRemarkMapper.byIdSelectActivityRemark(map);
    }
}
