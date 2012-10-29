package com.hr319wg.eva.pojo.bo;

public class TemplateItemSetBO {
    private String setID;
    private String setName;
    private String parentID;
    private String parentName;
    private String showSEQ;
    private String createDate;

    public String getSetID() {
        return setID;
    }
    public void setSetID(String id) {
        this.setID = id;
    }

    public String getParentName() {
        return parentName;
    }
    public void setParentName(String id) {
        this.parentName = id;
    }

    public String getSetName() {
        return setName;
    }
    public void setSetName(String id) {
        this.setName = id;
    }

    public String getParentID() {
        return parentID;
    }
    public void setParentID(String id) {
        this.parentID = id;
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
