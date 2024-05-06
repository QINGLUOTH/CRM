package com.nihao.crm.entityClass.user;

import java.util.Objects;

/**
 * 传输用户创建信息
 */
public class AccountCreateInfo {
    /**
     * true表示用户创建成功, false表示用户创建失败
     */
    private boolean flag;

    @Override
    public String toString() {
        return "AccountCreateInfo{" +
                "flag=" + flag +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        AccountCreateInfo that = (AccountCreateInfo) o;
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

    public AccountCreateInfo(boolean flag) {
        this.flag = flag;
    }
}
