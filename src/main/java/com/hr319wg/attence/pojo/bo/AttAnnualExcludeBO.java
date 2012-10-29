package com.hr319wg.attence.pojo.bo;

public class AttAnnualExcludeBO {
private String itemId;
private String recId;
private String personId;
private String personName;
private String mode; //0自动排除 1手工排除
private String modeName;
private String cause;
public String getItemId() {
	return itemId;
}
public void setItemId(String itemId) {
	this.itemId = itemId;
}
public String getRecId() {
	return recId;
}
public void setRecId(String recId) {
	this.recId = recId;
}
public String getPersonId() {
	return personId;
}
public void setPersonId(String personId) {
	this.personId = personId;
}
public String getPersonName() {
	return personName;
}
public void setPersonName(String personName) {
	this.personName = personName;
}
public String getMode() {
	return mode;
}
public void setMode(String mode) {
	this.mode = mode;
}
public String getModeName() {
	return modeName;
}
public void setModeName(String modeName) {
	this.modeName = modeName;
}
public String getCause() {
	return cause;
}
public void setCause(String cause) {
	this.cause = cause;
}

}
