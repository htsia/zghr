package com.hr319wg.attence.pojo.bo;

public class AttClassGroupBO {
    //考勤排班类型：1正常班2周期班3免考勤班4手工排班
    public static final String  NATURAL="1";
    public static final String  CYCLE="2";
    public static final String  FREE_CTR="3";
    public static final String  MANUAL="4";

    private String groupNo;
    private String groupName;
    private String groupType;
    private String linkClass;
    private String orgID;
    private String groupPeriod;
    private String beginDate;

    public String getGroupNo() {
        return groupNo;
    }

    public void setGroupNo(String groupNo) {
        this.groupNo = groupNo;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupType() {
        return groupType;
    }

    public void setGroupType(String groupType) {
        this.groupType = groupType;
    }

    public String getLinkClass() {
        return linkClass;
    }

    public void setLinkClass(String linkClass) {
        this.linkClass = linkClass;
    }

    public String getOrgID() {
        return orgID;
    }

    public void setOrgID(String orgID) {
        this.orgID = orgID;
    }

    public String getGroupPeriod() {
        return groupPeriod;
    }

    public void setGroupPeriod(String groupPeriod) {
        this.groupPeriod = groupPeriod;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

}
