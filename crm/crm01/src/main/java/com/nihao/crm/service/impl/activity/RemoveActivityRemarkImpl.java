package com.nihao.crm.service.impl.activity;

import com.nihao.crm.mapper.activity.remark.ActivityRemarkMapper;
import com.nihao.crm.service.activity.RemoveActivityRemark;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * RemarkActivityRemark接口的实现类
 */
@Service("removeActivityRemark")
public class RemoveActivityRemarkImpl implements RemoveActivityRemark {
    @Autowired
    ActivityRemarkMapper activityRemarkMapper;

    @Override
    public boolean deleteActivityRemark(String id) {
        return activityRemarkMapper.deleteActivityRemark(id) > 0 ? true : false;
    }
}
