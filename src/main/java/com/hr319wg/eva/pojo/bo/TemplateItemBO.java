package com.hr319wg.eva.pojo.bo;

public class TemplateItemBO {
    private String itemID;
    private String itemName;
    private String templateID;
    private String setID;
    private String setName;
    private String showSEQ;
    private String createDate;
    private String score;
    private String linkID;

    public String getLinkID() {
        return linkID;
    }
    public void setLinkID(String linkID) {
        this.linkID = linkID;
    }

    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getScore() {
        return score;
    }
    public void setScore(String score) {
        this.score = score;
    }

    public String getTemplateID() {
        return templateID;
    }
    public void setTemplateID(String templateID) {
        this.templateID = templateID;
    }

    public String getItemID() {
        return itemID;
    }
    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getSetID() {
        return setID;
    }
    public void setSetID(String id) {
        this.setID = id;
    }

    public String getSetName() {
        return setName;
    }
    public void setSetName(String id) {
        this.setName = id;
    }

    public String getShowSEQ() {
        return showSEQ;
    }
    public void setShowSEQ(String id) {
        this.showSEQ = id;
    }

    public String getCreateDate() {
        return createDate;
    }
    public void setCreateDate(String id) {
        this.createDate = id;
    }

}
