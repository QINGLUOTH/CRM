package com.nihao.crm.entityClass.activity.remark;

import com.nihao.crm.entityClass.activity.Activity;

import java.util.List;
import java.util.Objects;

public class ActivityAndActivityRemark {
    /**
     * 活动
     */
    private Activity activity;
    /**
     * 活动备注
     */
    private List<ActivityRemark> activityRemark;

    @Override
    public String toString() {
        return "ActivityAndActivityRemark{" +
                "activity=" + activity +
                ", activityRemark=" + activityRemark +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ActivityAndActivityRemark that = (ActivityAndActivityRemark) o;
        return Objects.equals(activity, that.activity) && Objects.equals(activityRemark, that.activityRemark);
    }

    @Override
    public int hashCode() {
        return Objects.hash(activity, activityRemark);
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public List<ActivityRemark> getActivityRemark() {
        return activityRemark;
    }

    public void setActivityRemark(List<ActivityRemark> activityRemark) {
        this.activityRemark = activityRemark;
    }

    public ActivityAndActivityRemark(Activity activity, List<ActivityRemark> activityRemark) {
        this.activity = activity;
        this.activityRemark = activityRemark;
    }
}
