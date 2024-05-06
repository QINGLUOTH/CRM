package com.nihao.crm.entityClass.clue;


import java.util.List;
import java.util.Objects;

public class ClueDataAndClueNumber {
    private List<Clue> clue;
    private int number;

    @Override
    public String toString() {
        return "ClueDataAndClueNumber{" +
                "clue=" + clue +
                ", number=" + number +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ClueDataAndClueNumber that = (ClueDataAndClueNumber) o;
        return number == that.number && Objects.equals(clue, that.clue);
    }

    @Override
    public int hashCode() {
        return Objects.hash(clue, number);
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public List<Clue> getClue() {
        return clue;
    }

    public void setClue(List<Clue> clue) {
        this.clue = clue;
    }

    public ClueDataAndClueNumber() {
    }

    public ClueDataAndClueNumber(List<Clue> clue, int number) {
        this.clue = clue;
        this.number = number;
    }
}
