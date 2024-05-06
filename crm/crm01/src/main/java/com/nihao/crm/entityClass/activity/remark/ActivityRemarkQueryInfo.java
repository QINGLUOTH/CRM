package com.nihao.crm.entityClass.activity.remark;

import java.util.Objects;

public class ActivityRemarkQueryInfo {
    /**
     * 活动备注信息
     */
    String activityRemark;

    @Override
    public String toString() {
        return "ActivityRemarkQueryInfo{" +
                "activityRemark='" + activityRemark + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ActivityRemarkQueryInfo that = (ActivityRemarkQueryInfo) o;
        return Objects.equals(activityRemark, that.activityRemark);
    }

    @Override
    public int hashCode() {
        return Objects.hash(activityRemark);
    }

    public String getActivityRemark() {
        return activityRemark;
    }

    public void setActivityRemark(String activityRemark) {
        this.activityRemark = activityRemark;
    }

    public ActivityRemarkQueryInfo(String activityRemark) {
        this.activityRemark = activityRemark;
    }
}
