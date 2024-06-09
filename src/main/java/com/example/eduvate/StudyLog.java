package com.example.eduvate;


import java.util.Date;

public class StudyLog {
	private int logID;
    private String userID;
    private Date studyDate;
    private int studyDuration;
    private String topic;
    private boolean editable;

    // 생성자
    public StudyLog() {
    }

    public StudyLog(String userID, Date studyDate, int studyDuration, String topic) {
    	this.userID = userID;
        this.studyDate = studyDate;
        this.studyDuration = studyDuration;
        this.topic = topic;
    }
    
    public int getLogID() {
        return logID;
    }

    public void setLogID(int logID) {
        this.logID = logID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
    	this.userID = userID;
    }

    public Date getStudyDate() {
        return studyDate;
    }

    public void setStudyDate(Date studyDate) {
        this.studyDate = studyDate;
    }

    public int getStudyDuration() {
        return studyDuration;
    }

    public void setStudyDuration(int studyDuration) {
        this.studyDuration = studyDuration;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }
    
    public boolean isEditable() {
        return editable;
    }

    public void setEditable(boolean editable) {
        this.editable = editable;
    }
}
