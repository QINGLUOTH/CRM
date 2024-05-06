package com.nihao.crm.service.impl.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.mapper.activity.ActivityMapper;
import com.nihao.crm.service.activity.GetAllActivity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * GetAllActivity接口的实现类
 */
@Service("getAllActivity")
public class GetAllActivityImpl implements GetAllActivity {
    @Autowired
    ActivityMapper activityMapper;

    /**
     * 获取所有活动信息
     * @return List<Activity>
     */
    @Override
    public List<Activity> getAllActivityInfo() {
        return activityMapper.getAll();
    }
}
