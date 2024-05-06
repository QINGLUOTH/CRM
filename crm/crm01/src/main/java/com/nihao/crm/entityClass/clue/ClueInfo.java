package com.nihao.crm.entityClass.clue;

import java.util.Objects;

public class ClueInfo {
    private boolean flag;

    @Override
    public String toString() {
        return "ClueInfo{" +
                "flag=" + flag +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ClueInfo clueInfo = (ClueInfo) o;
        return flag == clueInfo.flag;
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

    public ClueInfo() {
    }

    public ClueInfo(boolean flag) {
        this.flag = flag;
    }
}
