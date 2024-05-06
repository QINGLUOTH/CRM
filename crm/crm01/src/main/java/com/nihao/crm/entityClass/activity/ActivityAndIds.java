package com.nihao.crm.entityClass.activity;

import java.util.Arrays;
import java.util.Objects;

public class ActivityAndIds {
    private String[] ids;
    private Activity activity;

    @Override
    public String toString() {
        return "ActivityAndIds{" +
                "ids=" + Arrays.toString(ids) +
                ", activity=" + activity +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ActivityAndIds that = (ActivityAndIds) o;
        return Arrays.equals(ids, that.ids) && Objects.equals(activity, that.activity);
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(activity);
        result = 31 * result + Arrays.hashCode(ids);
        return result;
    }

    public String[] getIds() {
        return ids;
    }

    public void setIds(String[] ids) {
        this.ids = ids;
    }

    public Activity getActivity() {
        return activity;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public ActivityAndIds() {

    }

    public ActivityAndIds(String[] ids, Activity activity) {
        this.ids = ids;
        this.activity = activity;
    }
}
