package com.hr319wg.attence.pojo.vo;

/**
 * Created by IntelliJ IDEA.
 * User: ¸ßº£ÐÇ
 * Date: 11-12-12
 * Time: ÉÏÎç10:50
 * To change this template use File | Settings | File Templates.
 */
public class AttPersonAnnualQryVO {
    private String personName;
    private String canLeaveDay;
    private String haveLeaveDay;
    private String avaLeaveDay;
    private String criticalDate;
    private String workDate;
    private String enterDate;

    public String getAvaLeaveDay() {
        return avaLeaveDay;
    }

    public void setAvaLeaveDay(String avaLeaveDay) {
        this.avaLeaveDay = avaLeaveDay;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getCanLeaveDay() {
        return canLeaveDay;
    }

    public void setCanLeaveDay(String canLeaveDay) {
        this.canLeaveDay = canLeaveDay;
    }

    public String getHaveLeaveDay() {
        return haveLeaveDay;
    }

    public void setHaveLeaveDay(String haveLeaveDay) {
        this.haveLeaveDay = haveLeaveDay;
    }

    public String getCriticalDate() {
        return criticalDate;
    }

    public void setCriticalDate(String criticalDate) {
        this.criticalDate = criticalDate;
    }

    public String getWorkDate() {
        return workDate;
    }

    public void setWorkDate(String workDate) {
        this.workDate = workDate;
    }

    public String getEnterDate() {
        return enterDate;
    }

    public void setEnterDate(String enterDate) {
        this.enterDate = enterDate;
    }
}
