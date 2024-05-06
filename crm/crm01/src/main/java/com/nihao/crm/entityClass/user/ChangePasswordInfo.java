package com.nihao.crm.entityClass.user;

import java.util.Objects;

/**
 * 修改密码是否成功的信息
 */
public class ChangePasswordInfo {
    private boolean flag;

    @Override
    public String toString() {
        return "ChangePasswordInfo{" +
                "flag=" + flag +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ChangePasswordInfo that = (ChangePasswordInfo) o;
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

    public ChangePasswordInfo(boolean flag) {
        this.flag = flag;
    }
}
