package com.hr319wg.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 11-12-19
 * Time: ÉÏÎç10:54
 * To change this template use File | Settings | File Templates.
 */
public class EvaCaclControlBO {
    private String itemId;
    private String planId;
    private String templateId;
    private String masterType;
    private String caclMode;
    private String selScoreMode;

    public String getSelScoreMode() {
        return selScoreMode;
    }

    public void setSelScoreMode(String selScoreMode) {
        this.selScoreMode = selScoreMode;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getMasterType() {
        return masterType;
    }

    public void setMasterType(String masterType) {
        this.masterType = masterType;
    }

    public String getCaclMode() {
        return caclMode;
    }

    public void setCaclMode(String caclMode) {
        this.caclMode = caclMode;
    }
}
