package com.example.eduvate;

public class StudyGroup {
    private int groupID;
    private String groupName;
    private String description;
    private String userID;

    // 생성자
    public StudyGroup() {
    }

    public StudyGroup(String groupName, String description, String userID) {
        this.groupName = groupName;
        this.description = description;
        this.userID = userID;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }
    
    @Override
    public String toString() {
        return "StudyGroup{" +
                "groupID=" + groupID +
                ", groupName='" + groupName + '\'' +
                ", description='" + description + '\'' +
                ", userID='" + userID + '\'' +
                '}';
    }
}
