package com.nihao.crm.service.activity;

import com.nihao.crm.entityClass.activity.Activity;
import com.nihao.crm.entityClass.activity.ActivityAndIds;

public interface AlterActivity {
    /**
     * 通过活动id修改活动数据
     * @param activity com.nihao.crm.entityClass.activity.Activity
     * @param ids 修改数据的活动id
     * @return true表示修改成功, false表示修改失败
     */
    boolean changeActivity(ActivityAndIds activityAndIds);
}
