package com.nihao.crm.entityClass.user;

public class User {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.id
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.login_act
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String loginAct;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.name
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String name;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.login_pwd
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String loginPwd;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.email
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String email;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.expire_time
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String expireTime;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.lock_state
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String lockState;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.deptno
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String deptno;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.allow_ips
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String allowIps;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.createTime
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String createtime;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.create_by
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String createBy;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.edit_time
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String editTime;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_user.edit_by
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    private String editBy;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.id
     *
     * @return the value of t_user.id
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.id
     *
     * @param id the value for t_user.id
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.login_act
     *
     * @return the value of t_user.login_act
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getLoginAct() {
        return loginAct;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.login_act
     *
     * @param loginAct the value for t_user.login_act
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setLoginAct(String loginAct) {
        this.loginAct = loginAct == null ? null : loginAct.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.name
     *
     * @return the value of t_user.name
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.name
     *
     * @param name the value for t_user.name
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.login_pwd
     *
     * @return the value of t_user.login_pwd
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getLoginPwd() {
        return loginPwd;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.login_pwd
     *
     * @param loginPwd the value for t_user.login_pwd
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd == null ? null : loginPwd.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.email
     *
     * @return the value of t_user.email
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getEmail() {
        return email;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.email
     *
     * @param email the value for t_user.email
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.expire_time
     *
     * @return the value of t_user.expire_time
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getExpireTime() {
        return expireTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.expire_time
     *
     * @param expireTime the value for t_user.expire_time
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setExpireTime(String expireTime) {
        this.expireTime = expireTime == null ? null : expireTime.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.lock_state
     *
     * @return the value of t_user.lock_state
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getLockState() {
        return lockState;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.lock_state
     *
     * @param lockState the value for t_user.lock_state
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setLockState(String lockState) {
        this.lockState = lockState == null ? null : lockState.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.deptno
     *
     * @return the value of t_user.deptno
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getDeptno() {
        return deptno;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.deptno
     *
     * @param deptno the value for t_user.deptno
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setDeptno(String deptno) {
        this.deptno = deptno == null ? null : deptno.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.allow_ips
     *
     * @return the value of t_user.allow_ips
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getAllowIps() {
        return allowIps;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.allow_ips
     *
     * @param allowIps the value for t_user.allow_ips
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setAllowIps(String allowIps) {
        this.allowIps = allowIps == null ? null : allowIps.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.createTime
     *
     * @return the value of t_user.createTime
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getCreatetime() {
        return createtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.createTime
     *
     * @param createtime the value for t_user.createTime
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.create_by
     *
     * @return the value of t_user.create_by
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getCreateBy() {
        return createBy;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.create_by
     *
     * @param createBy the value for t_user.create_by
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.edit_time
     *
     * @return the value of t_user.edit_time
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getEditTime() {
        return editTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.edit_time
     *
     * @param editTime the value for t_user.edit_time
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setEditTime(String editTime) {
        this.editTime = editTime == null ? null : editTime.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_user.edit_by
     *
     * @return the value of t_user.edit_by
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public String getEditBy() {
        return editBy;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_user.edit_by
     *
     * @param editBy the value for t_user.edit_by
     *
     * @mbg.generated Sat Jun 04 10:51:14 CST 2022
     */
    public void setEditBy(String editBy) {
        this.editBy = editBy == null ? null : editBy.trim();
    }

    public User(String id, String loginAct, String name,
                String loginPwd, String email, String expireTime, String lockState, String deptno, String allowIps, String createtime) {
        this.id = id;
        this.loginAct = loginAct;
        this.name = name;
        this.loginPwd = loginPwd;
        this.email = email;
        this.expireTime = expireTime;
        this.lockState = lockState;
        this.deptno = deptno;
        this.allowIps = allowIps;
        this.createtime = createtime;
    }
}