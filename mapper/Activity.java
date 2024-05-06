package com.nihao.crm.mapper;

public class Activity {
    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.id
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String id;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.owner
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String owner;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.name
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String name;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.start_date
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String startDate;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.end_date
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String endDate;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.cost
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String cost;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.description
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String description;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.create_time
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String createTime;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.create_by
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String createBy;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.edit_time
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String editTime;

    /**
     *
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column t_activity.edit_by
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    private String editBy;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.id
     *
     * @return the value of t_activity.id
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.id
     *
     * @param id the value for t_activity.id
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.owner
     *
     * @return the value of t_activity.owner
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getOwner() {
        return owner;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.owner
     *
     * @param owner the value for t_activity.owner
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setOwner(String owner) {
        this.owner = owner == null ? null : owner.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.name
     *
     * @return the value of t_activity.name
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getName() {
        return name;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.name
     *
     * @param name the value for t_activity.name
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.start_date
     *
     * @return the value of t_activity.start_date
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getStartDate() {
        return startDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.start_date
     *
     * @param startDate the value for t_activity.start_date
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setStartDate(String startDate) {
        this.startDate = startDate == null ? null : startDate.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.end_date
     *
     * @return the value of t_activity.end_date
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getEndDate() {
        return endDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.end_date
     *
     * @param endDate the value for t_activity.end_date
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setEndDate(String endDate) {
        this.endDate = endDate == null ? null : endDate.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.cost
     *
     * @return the value of t_activity.cost
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getCost() {
        return cost;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.cost
     *
     * @param cost the value for t_activity.cost
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setCost(String cost) {
        this.cost = cost == null ? null : cost.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.description
     *
     * @return the value of t_activity.description
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getDescription() {
        return description;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.description
     *
     * @param description the value for t_activity.description
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.create_time
     *
     * @return the value of t_activity.create_time
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getCreateTime() {
        return createTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.create_time
     *
     * @param createTime the value for t_activity.create_time
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.create_by
     *
     * @return the value of t_activity.create_by
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getCreateBy() {
        return createBy;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.create_by
     *
     * @param createBy the value for t_activity.create_by
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setCreateBy(String createBy) {
        this.createBy = createBy == null ? null : createBy.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.edit_time
     *
     * @return the value of t_activity.edit_time
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getEditTime() {
        return editTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.edit_time
     *
     * @param editTime the value for t_activity.edit_time
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setEditTime(String editTime) {
        this.editTime = editTime == null ? null : editTime.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column t_activity.edit_by
     *
     * @return the value of t_activity.edit_by
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public String getEditBy() {
        return editBy;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column t_activity.edit_by
     *
     * @param editBy the value for t_activity.edit_by
     *
     * @mbg.generated Fri Jun 10 15:28:44 CST 2022
     */
    public void setEditBy(String editBy) {
        this.editBy = editBy == null ? null : editBy.trim();
    }
}