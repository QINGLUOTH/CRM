package com.nihao.crm.entityClass.activity;

import java.util.Objects;

/**
 * 市场活动创建成功信息
 */
public class ActivityInfo {
    /**
     * 判断相关Activity活动的操作是否成功, 成功返回true, 不成功返回false
     */
    private boolean flag;
    /**
     * 错误信息
     */
    private String info;

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(boolean flag) {
        this.flag = flag;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    @Override
    public String toString() {
        return "ActivityInfo{" +
                "flag=" + flag +
                ", info='" + info + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ActivityInfo that = (ActivityInfo) o;
        return flag == that.flag && Objects.equals(info, that.info);
    }

    @Override
    public int hashCode() {
        return Objects.hash(flag, info);
    }

    public ActivityInfo(boolean flag, String info) {
        this.flag = flag;
        this.info = info;
    }

    public ActivityInfo(boolean flag) {
        this.flag = flag;
    }
}
