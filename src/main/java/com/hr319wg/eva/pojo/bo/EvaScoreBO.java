package com.hr319wg.eva.pojo.bo;

public class EvaScoreBO {
    private String scoreID;
    private String masterID;
    private String objectID;
    private String itemID;
    private String score;
    private String calascore;
    
    public String getCalascore() {
		return calascore;
	}
	public void setCalascore(String calascore) {
		this.calascore = calascore;
	}
	public String getItemID() {
        return itemID;
    }
    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getObjectID() {
        return objectID;
    }
    public void setObjectID(String objectID) {
        this.objectID = objectID;
    }

    public String getScoreID() {
        return scoreID;
    }
    public void setScoreID(String scoreID) {
        this.scoreID = scoreID;
    }

    public String getScore() {
        return score;
    }
    public void setScore(String score) {
        this.score = score;
    }

    public String getMasterID() {
        return masterID;
    }
    public void setMasterID(String masterID) {
        this.masterID = masterID;
    }


}
