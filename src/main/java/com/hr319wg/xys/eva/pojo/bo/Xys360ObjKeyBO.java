package com.hr319wg.xys.eva.pojo.bo;

public class Xys360ObjKeyBO {
	private String keyId;
	private String objId;
	private String keyName;
	private String keyDesc;
	private String weight;
	private String hiValue;
	private String lowValue;
	private String keyType;//指标类型(1能力2态度)
	
	
	public String getKeyType() {
		return keyType;
	}
	public void setKeyType(String keyType) {
		this.keyType = keyType;
	}
	public String getKeyId() {
		return keyId;
	}
	public void setKeyId(String keyId) {
		this.keyId = keyId;
	}
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
	}
	public String getKeyName() {
		return keyName;
	}
	public void setKeyName(String keyName) {
		this.keyName = keyName;
	}
	public String getKeyDesc() {
		return keyDesc;
	}
	public void setKeyDesc(String keyDesc) {
		this.keyDesc = keyDesc;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getHiValue() {
		return hiValue;
	}
	public void setHiValue(String hiValue) {
		this.hiValue = hiValue;
	}
	public String getLowValue() {
		return lowValue;
	}
	public void setLowValue(String lowValue) {
		this.lowValue = lowValue;
	}
	
	
}
