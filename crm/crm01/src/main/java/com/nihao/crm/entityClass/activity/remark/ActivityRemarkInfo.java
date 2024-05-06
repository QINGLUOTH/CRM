package com.nihao.crm.entityClass.activity.remark;

import java.util.Objects;

public class ActivityRemarkInfo {
    /**
     * true表示创建成功, false表示创建失败
     */
    private boolean flag;

    @Override
    public String toString() {
        return "ActivityRemarkInfo{" +
                "flag=" + flag +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ActivityRemarkInfo that = (ActivityRemarkInfo) o;
        return flag == that.flag;
    }

    @Override
    public int hashCode() {
        return Objects.hash(flag);
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public ActivityRemarkInfo() {
    }

    public ActivityRemarkInfo(boolean flag) {
        this.flag = flag;
    }
}
