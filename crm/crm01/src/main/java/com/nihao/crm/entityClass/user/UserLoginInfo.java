package com.nihao.crm.entityClass.user;

import java.util.Objects;

/**
 * 用户登录的实体类, 有两个参数, 一个boolean类型, 表示用户是否验证成功, 可以登录, 第二个表示登录失败的信息
 */
public class UserLoginInfo {
    private String errorInfo;  // 错误信息
    private boolean loginInfo;  // 登录成功或失败信息

    @Override
    public String toString() {
        return "UserLoginInfo{" +
                "errorInfo='" + errorInfo + '\'' +
                ", loginInfo=" + loginInfo +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserLoginInfo that = (UserLoginInfo) o;
        return loginInfo == that.loginInfo && Objects.equals(errorInfo, that.errorInfo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(errorInfo, loginInfo);
    }

    public String getErrorInfo() {
        return errorInfo;
    }

    public void setErrorInfo(String errorInfo) {
        this.errorInfo = errorInfo;
    }

    public boolean isLoginInfo() {
        return loginInfo;
    }

    public void setLoginInfo(boolean loginInfo) {
        this.loginInfo = loginInfo;
    }

    public UserLoginInfo(String errorInfo) {
        this.errorInfo = errorInfo;
    }

    public UserLoginInfo(String errorInfo, boolean loginInfo) {
        this.errorInfo = errorInfo;
        this.loginInfo = loginInfo;
    }
}
