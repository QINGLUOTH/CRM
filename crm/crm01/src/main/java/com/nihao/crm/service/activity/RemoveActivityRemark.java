package com.nihao.crm.service.activity;

public interface RemoveActivityRemark {
    /**
     * 通过活动备注id, 删除活动数据
     * @param id 活动备注id
     * @return true表示删除成功, false表示删除失败
     */
    boolean deleteActivityRemark(String id);
}
