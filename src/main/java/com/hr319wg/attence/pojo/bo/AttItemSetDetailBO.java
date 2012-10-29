package com.hr319wg.attence.pojo.bo;

public class AttItemSetDetailBO {
    public static final String UNIT_NO="-"; //无单位
    public static final String UNIT_COUNT="0"; //次
    public static final String UNIT_DAY="1"; //天
    public static final String UNIT_HOUR="2"; //小时
    public static final String UNIT_MINUTE="3";//分钟

    private String itemID;
    private String itemCode;
    private String itemCodeName;
    private String createOrg;
    private String flagChar;
    private String unit;
    private String unitName;
    private String dayField;
    private String dayFieldName;
    private String monthField;
    private String monthFieldName;
    private String yearField;
    private String yearFieldName;

    public String getItemID() {
        return itemID;
    }

    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getItemCode() {
        return itemCode;
    }

    public void setItemCode(String itemCode) {
        this.itemCode = itemCode;
    }

    public String getCreateOrg() {
        return createOrg;
    }

    public void setCreateOrg(String createOrg) {
        this.createOrg = createOrg;
    }

    public String getFlagChar() {
        return flagChar;
    }

    public void setFlagChar(String flagChar) {
        this.flagChar = flagChar;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public String getItemCodeName() {
        return itemCodeName;
    }

    public void setItemCodeName(String itemCodeName) {
        this.itemCodeName = itemCodeName;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public String getDayField() {
        return dayField;
    }

    public void setDayField(String dayField) {
        this.dayField = dayField;
    }

    public String getDayFieldName() {
        return dayFieldName;
    }

    public void setDayFieldName(String dayFieldName) {
        this.dayFieldName = dayFieldName;
    }

    public String getMonthField() {
        return monthField;
    }

    public void setMonthField(String monthField) {
        this.monthField = monthField;
    }

    public String getMonthFieldName() {
        return monthFieldName;
    }

    public void setMonthFieldName(String monthFieldName) {
        this.monthFieldName = monthFieldName;
    }

    public String getYearField() {
        return yearField;
    }

    public void setYearField(String yearField) {
        this.yearField = yearField;
    }

    public String getYearFieldName() {
        return yearFieldName;
    }

    public void setYearFieldName(String yearFieldName) {
        this.yearFieldName = yearFieldName;
    }

}
