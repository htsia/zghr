package com.hr319wg.eva.pojo.vo;

/**
 * Created by IntelliJ IDEA.
 * User: gaohaixing
 * Date: 11-12-19
 * Time: ÏÂÎç12:53
 * To change this template use File | Settings | File Templates.
 */
public class EvaMastersVO {
    private String masterId;
    private String objectId;
    private String personId;
    private String purview;
    private String score;
    private String masterType;
    private String gradeId;
    private String isMark;
    private String templateId;
    private String planId;
    private String isCacl;

    public String getIsCacl() {
        return isCacl;
    }

    public void setIsCacl(String cacl) {
        isCacl = cacl;
    }
    public String getMasterId() {
        return masterId;
    }

    public void setMasterId(String masterId) {
        this.masterId = masterId;
    }

    public String getObjectId() {
        return objectId;
    }

    public void setObjectId(String objectId) {
        this.objectId = objectId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPurview() {
        return purview;
    }

    public void setPurview(String purview) {
        this.purview = purview;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getMasterType() {
        return masterType;
    }

    public void setMasterType(String masterType) {
        this.masterType = masterType;
    }

    public String getGradeId() {
        return gradeId;
    }

    public void setGradeId(String gradeId) {
        this.gradeId = gradeId;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getIsMark() {
        return isMark;
    }

    public void setIsMark(String mark) {
        isMark = mark;
    }
}
