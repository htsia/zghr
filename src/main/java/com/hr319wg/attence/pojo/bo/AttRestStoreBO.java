package com.hr319wg.attence.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-2-1
 * Time: 上午11:51
 * To change this template use File | Settings | File Templates.
 */
public class AttRestStoreBO {
    //记录类型0公出1出差2加班
    public static final String RECORD_TYPE_WORKOUT="0";
    public static final String RECORD_TYPE_EVECTION="1";
    public static final String RECORD_TYPE_OVERTIME="2";
    //状态0未休1已休2失效
    public static final String STATUS_NO_USE="0";
    public static final String STATUS_IS_USE="1";
    public static final String STATUS_CANNOT_USE="2";

    private String storeId;
    private String recordType;
    private String itemId;
    private String days;
    private String status;
    private String restTime;
    private String useDays;
    private String levDays;
    private String personId;
    private String daysDesc;

    private String recordTypeDes;
    private String statusDes;

    public String getDaysDesc() {
        return daysDesc;
    }

    public void setDaysDesc(String daysDesc) {
        this.daysDesc = daysDesc;
    }

    public String getRecordTypeDes() {
        return recordTypeDes;
    }

    public void setRecordTypeDes(String recordTypeDes) {
        this.recordTypeDes = recordTypeDes;
    }

    public String getStatusDes() {
        return statusDes;
    }

    public void setStatusDes(String statusDes) {
        this.statusDes = statusDes;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getUseDays() {
        return useDays;
    }

    public void setUseDays(String useDays) {
        this.useDays = useDays;
    }

    public String getLevDays() {
        return levDays;
    }

    public void setLevDays(String levDays) {
        this.levDays = levDays;
    }

    public String getStoreId() {
        return storeId;
    }

    public void setStoreId(String storeId) {
        this.storeId = storeId;
    }

    public String getRecordType() {
        return recordType;
    }

    public void setRecordType(String recordType) {
        this.recordType = recordType;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getDays() {
        return days;
    }

    public void setDays(String days) {
        this.days = days;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRestTime() {
        return restTime;
    }

    public void setRestTime(String restTime) {
        this.restTime = restTime;
    }
}
