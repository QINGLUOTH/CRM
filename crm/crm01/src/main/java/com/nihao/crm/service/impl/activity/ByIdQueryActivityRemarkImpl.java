package com.nihao.crm.service.impl.activity;

import com.nihao.crm.mapper.activity.remark.ActivityRemarkMapper;
import com.nihao.crm.service.activity.ByIdQueryActivityRemark;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * ByIdQueryActivityRemark接口的实现类
 */
@Service("byIdQueryActivityRemark")
public class ByIdQueryActivityRemarkImpl implements ByIdQueryActivityRemark {
    @Autowired
    ActivityRemarkMapper activityRemarkMapper;

    @Override
    public String findActivityRemark(String id) {
        return activityRemarkMapper.selectActivityRemark(id);
    }
}
