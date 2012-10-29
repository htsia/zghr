package com.hr319wg.attence.pojo.bo;

public class AttItemPowerBO {
    private String powerID;
    private String setID;
    private String personID;
    private String itemID;
    private String itemName;

    public String getPowerID() {
        return powerID;
    }
    public void setPowerID(String id) {
        this.powerID = id;
    }

    public String getPersonID() {
        return personID;
    }
    public void setPersonID(String name) {
        this.personID = name;
    }

    public String getSetID() {
        return setID;
    }
    public void setSetID(String id) {
        this.setID = id;
    }

    public String getItemID() {
        return itemID;
    }
    public void setItemID(String name) {
        this.itemID = name;
    }

    public String getItemName() {
        return itemName;
    }
    public void setItemName(String pa) {
        this.itemName = pa;
    }

}
