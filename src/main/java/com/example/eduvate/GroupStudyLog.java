package com.example.eduvate;

import java.sql.Date;

public class GroupStudyLog {
    private int groupLogID;
    private int groupID;
    private String userID;
    private Date groupStudyDate;
    private int groupStudyDuration;
    private String groupTopic;

    public int getGroupLogID() {
        return groupLogID;
    }

    public void setGroupLogID(int groupLogID) {
        this.groupLogID = groupLogID;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public Date getGroupStudyDate() {
        return groupStudyDate;
    }

    public void setGroupStudyDate(Date groupStudyDate) {
        this.groupStudyDate = groupStudyDate;
    }

    public int getGroupStudyDuration() {
        return groupStudyDuration;
    }

    public void setGroupStudyDuration(int groupStudyDuration) {
        this.groupStudyDuration = groupStudyDuration;
    }

    public String getGroupTopic() {
        return groupTopic;
    }

    public void setGroupTopic(String groupTopic) {
        this.groupTopic = groupTopic;
    }
    
    @Override
    public String toString() {
        return "GroupStudyLog{" +
                "groupLogID=" + groupLogID +
                ", groupID=" + groupID +
                ", userID='" + userID + '\'' +
                ", groupStudyDate=" + groupStudyDate +
                ", groupStudyDuration=" + groupStudyDuration +
                ", groupTopic='" + groupTopic + '\'' +
                '}';
    }
}