package com.hr319wg.sys.pojo.bo;

import com.hr319wg.common.pojo.bo.CloneablePO;

public class CodeSetBO extends CloneablePO {
	public static String STATUS_BAN = "0";

	public static String STATUS_OPEN = "1";

	public static String LAYER_LEAF = "1";

	public static String LAYER_EVERY = "0";
	private String setId;
	private String setName;
	private String setNameEx;
	private String setDesc;
	private String setLayer;
	private String setStatus;
	private String layerLength;
	private String setScaleName;
	private String scaleCode;
	private String createUnit;

	public String getCreateUnit() {
		return createUnit;
	}

	public void setCreateUnit(String createUnit) {
		this.createUnit = createUnit;
	}

	public String getSetScaleName() {
		return this.setScaleName;
	}

	public void setSetScaleName(String setScaleName) {
		this.setScaleName = setScaleName;
	}

	public String getSetId() {
		return this.setId;
	}

	public void setSetId(String setId) {
		this.setId = setId;
	}

	public String getSetName() {
		return this.setName;
	}

	public String getSetNameEx() {
		return this.setName + "(" + this.setId + ")";
	}

	public String getSetLayer() {
		return this.setLayer;
	}

	public void setSetLayer(String setLayer) {
		this.setLayer = setLayer;
	}

	public String getSetStatus() {
		return this.setStatus;
	}

	public void setSetStatus(String setStatus) {
		this.setStatus = setStatus;
	}

	public void setSetName(String setName) {
		this.setName = setName;
	}

	public String getSetDesc() {
		return this.setDesc;
	}

	public void setSetDesc(String setDesc) {
		this.setDesc = setDesc;
	}

	public String getLayerLength() {
		return this.layerLength;
	}

	public void setLayerLength(String layerLength) {
		this.layerLength = layerLength;
	}

	public String getScaleCode() {
		return this.scaleCode;
	}

	public void setScaleCode(String scaleCode) {
		this.scaleCode = scaleCode;
	}
}