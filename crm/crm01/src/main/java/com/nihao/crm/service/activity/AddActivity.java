package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.Activity;

import java.util.List;

public interface AddActivity {
    boolean createActivityBatch(List<Activity> activities);
}
