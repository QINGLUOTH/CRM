package com.nihao.crm.entityClass.activity;

import java.util.List;
import java.util.Objects;

public class ActivityAndActivityNumber {
    private List<Activity> activities;
    private int number;

    @Override
    public String toString() {
        return "ActivityAndActivityNumber{" +
                "activities=" + activities +
                ", number=" + number +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ActivityAndActivityNumber that = (ActivityAndActivityNumber) o;
        return number == that.number && Objects.equals(activities, that.activities);
    }

    @Override
    public int hashCode() {
        return Objects.hash(activities, number);
    }

    public List<Activity> getActivities() {
        return activities;
    }

    public void setActivities(List<Activity> activities) {
        this.activities = activities;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public ActivityAndActivityNumber() {

    }

    public ActivityAndActivityNumber(List<Activity> activities, int number) {
        this.activities = activities;
        this.number = number;
    }
}
