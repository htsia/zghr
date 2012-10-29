package com.hr319wg.eva.pojo.bo;

public class EvaTemplateBO {
    private String templateID;
    private String setID;
    private String setName;
    private String orguid;
    private String templateName;
    private String totalscore;
    private String curscore;
    private String showSEQ;
    private String createDate;
    private String isUse;
    private String level;
    private String createOrguid;

    public String getCreateOrguid() {
        return createOrguid;
    }
    public void setCreateOrguid(String orguid) {
        this.createOrguid = orguid;
    }

    public String getOrguid() {
        return orguid;
    }
    public void setOrguid(String orguid) {
        this.orguid = orguid;
    }

    public String getLevel() {
        return level;
    }
    public void setLevel(String level) {
        this.level = level;
    }
    
    public String getTemplateID() {
        return templateID;
    }
    public void setTemplateID(String id) {
        this.templateID = id;
    }

    public String getIsUse() {
        return isUse;
    }
    public void setIsUse(String id) {
        this.isUse = id;
    }


    public String getCurscore() {
        return curscore;
    }
    public void setCurscore(String id) {
        this.curscore = id;
    }

    public String getTotalscore() {
        return totalscore;
    }
    public void setTotalscore(String id) {
        this.totalscore = id;
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

    public String getTemplateName() {
        return templateName;
    }
    public void setTemplateName(String id) {
        this.templateName = id;
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
