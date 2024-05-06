package com.nihao.crm.service.activity;

public interface RemoveActivity {
    /**
     * 删除市场活动和市场活动备注
     * @return true表示删除成功, false表示删除失败
     */
    boolean removeActivityAndRemoveActivityRemark(String[] ids);
}
