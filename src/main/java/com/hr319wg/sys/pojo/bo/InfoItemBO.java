package com.hr319wg.sys.pojo.bo;

import java.io.Serializable;
import java.util.Hashtable;

import com.hr319wg.common.pojo.bo.CloneablePO;

public class InfoItemBO extends CloneablePO implements Serializable {
	public static String ISSUE_YES = "1";
	public static String ISSUE_NO = "0";
	public static String STATUS_OPEN = "1";
	public static String STATUS_BAN = "0";
	public static String IS_NULL = "0";
	public static String IS_NOTNULL = "1";
	public static final String DATA_TYPE_INT = "1";
	public static final String DATA_TYPE_FLOAT = "2";
	public static final String DATA_TYPE_STRING = "3";
	public static final String DATA_TYPE_REMARK = "4";
	public static final String DATA_TYPE_DATE = "5";
	public static final String DATA_TYPE_CODE = "6";
	public static final String DATA_TYPE_ORG = "7";
	public static final String DATA_TYPE_PERSON = "8";
	public static final String DATA_TYPE_COMPUTE = "9";
	public static final String DATA_TYPE_CLOB = "10";
	public static final String DATA_TYPE_POST = "11";
	public static final String DATA_TYPE_PARTY = "12";
	public static final String DATA_TYPE_WAGE = "13";
	public static final String DATA_TYPE_IMAG = "14";
	public static final String DATA_TYPE_DATE6 = "15";
	public static final String DATA_TYPE_EMAIL = "16";
	public static final String DATA_TYPE_URL = "17";
	public static final String DATA_TYPE_FILE = "18";
	public static final String DATA_TYPE_REF = "19";
	public static final String DATA_TYPE_ICON = "20";
	public static final String DATA_TYPE_MULCODE = "21";
	public static final String DATA_TYPE_MOBILE = "22";
	public static final String DATA_TYPE_WAGEDEPT = "23";
	public static final String DATA_TYPE_ATTGROUP = "24";
	private static Hashtable htmlType = new Hashtable();
	public static String PROPERTY_CONTROL_HIDE;
	public static String PROPERTY_CONTROL_SHOW;
	public static String PROPERTY_SYSTEM_;
	public static String PROPERTY_EXTEND;
	public static String INFO_ITEM_SELF;
	public static String INFO_ITEM_SYSTEM;
	private String itemId;
	private String setId;
	private String itemName;
	private String itemNameEx;
	private String itemDesc;
	private String itemDataType;
	private String itemDataLength;
	private String itemIsSelect;
	private String itemPrecision;
	private String itemMax;
	private String itemMin;
	private String itemNotNull;
	private String itemIsunique;
	private String itemSequence;
	private String itemStatus;
	public static String SYSITEM_HIDDEN;
	public static String SYSITEM_READONLY;
	public static String SYSITEM_NOMARL;
	public static String USERITEM;
	private String itemProperty;
	private String itemDefaultValue;
	private String itemFormula;
	private String itemCodeSet;
	private String itemIssue;
	private String itemSelf;
	private String canInport;
	private String modiInWage;
	private String jy1006bh;
	private String jy1006name;
	private String gb14946;
	private String codeByOrg;
	private String itemMust;
	private String itemTrigger;
	private String itemClass;//0用户 1国标 2系统

	
	public String getItemClass() {
		return itemClass;
	}

	public void setItemClass(String itemClass) {
		this.itemClass = itemClass;
	}

	public static String getHtmlDataType(String key) {
		String type = "";
		if (key != null) {
			Object s = htmlType.get(key);
			if (s == null)
				type = "";
			else {
				type = (String) s;
			}
		}
		return type;
	}

	public static String getDataTypeCnName(String dataType) {
		if ("1".equals(dataType))
			return "整型";
		if ("2".equals(dataType))
			return "小数";
		if ("3".equals(dataType))
			return "字符";
		if ("4".equals(dataType))
			return "备注";
		if ("5".equals(dataType))
			return "八位日期";
		if ("15".equals(dataType)) {
			return "六位日期";
		}
		if ("6".equals(dataType))
			return "代码";
		if ("7".equals(dataType))
			return "机构";
		if ("8".equals(dataType))
			return "人员";
		if ("9".equals(dataType))
			return "计算";
		if ("10".equals(dataType))
			return "大文本字段";
		if ("11".equals(dataType))
			return "岗位";
		if ("12".equals(dataType))
			return "党组织";
		if ("13".equals(dataType))
			return "薪资机构";
		if ("14".equals(dataType))
			return "图片";
		if ("23".equals(dataType)) {
			return "薪资部门";
		}
		if ("18".equals(dataType)) {
			return "文件";
		}

		return "未知";
	}

	public String getItemIsunique() {
		return this.itemIsunique;
	}

	public void setItemIsunique(String itemIsunique) {
		this.itemIsunique = itemIsunique;
	}

	public String getJy1006bh() {
		return this.jy1006bh;
	}

	public void setJy1006bh(String jy1006bh) {
		this.jy1006bh = jy1006bh;
	}

	public String getJy1006name() {
		return this.jy1006name;
	}

	public void setJy1006name(String jy1006name) {
		this.jy1006name = jy1006name;
	}

	public String getGb14946() {
		return this.gb14946;
	}

	public void setGb14946(String gb14946) {
		this.gb14946 = gb14946;
	}

	public String getCodeByOrg() {
		return this.codeByOrg;
	}

	public void setCodeByOrg(String codeByOrg) {
		this.codeByOrg = codeByOrg;
	}

	public String getItemMust() {
		return this.itemMust;
	}

	public void setItemMust(String itemMust) {
		this.itemMust = itemMust;
	}

	public String getModiInWage() {
		return this.modiInWage;
	}

	public void setModiInWage(String inport) {
		this.modiInWage = inport;
	}

	public String getItemTrigger() {
		return this.itemTrigger;
	}

	public void setItemTrigger(String inport) {
		this.itemTrigger = inport;
	}

	public String getCanInport() {
		return this.canInport;
	}

	public void setCanInport(String inport) {
		this.canInport = inport;
	}

	public String getItemIsSelect() {
		return this.itemIsSelect;
	}

	public void setItemIsSelect(String itemIsSelect) {
		this.itemIsSelect = itemIsSelect;
	}

	public String getItemIssue() {
		return this.itemIssue;
	}

	public void setItemIssue(String itemIssue) {
		this.itemIssue = itemIssue;
	}

	public String getItemSelf() {
		return this.itemSelf;
	}

	public void setItemSelf(String itemSelf) {
		this.itemSelf = itemSelf;
	}

	public String getItemId() {
		return this.itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getSetId() {
		return this.setId;
	}

	public void setSetId(String setId) {
		this.setId = setId;
	}

	public String getItemName() {
		return this.itemName;
	}

	public String getItemNameEx() {
		return this.itemName + "(" + this.itemId + ")";
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemDesc() {
		return this.itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public String getItemDataType() {
		return this.itemDataType;
	}

	public void setItemDataType(String itemDataType) {
		this.itemDataType = itemDataType;
	}

	public String getItemDataLength() {
		return this.itemDataLength;
	}

	public void setItemDataLength(String itemDataLength) {
		this.itemDataLength = itemDataLength;
	}

	public String getItemPrecision() {
		return this.itemPrecision;
	}

	public void setItemPrecision(String itemPrecision) {
		this.itemPrecision = itemPrecision;
	}

	public String getItemMax() {
		return this.itemMax;
	}

	public void setItemMax(String itemMax) {
		this.itemMax = itemMax;
	}

	public String getItemMin() {
		return this.itemMin;
	}

	public void setItemMin(String itemMin) {
		this.itemMin = itemMin;
	}

	public String getItemNotNull() {
		return this.itemNotNull;
	}

	public void setItemNotNull(String itemNotNull) {
		this.itemNotNull = itemNotNull;
	}

	public String getItemSequence() {
		return this.itemSequence;
	}

	public void setItemSequence(String itemSequence) {
		this.itemSequence = itemSequence;
	}

	public String getItemStatus() {
		return this.itemStatus;
	}

	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}

	public String getItemProperty() {
		return this.itemProperty;
	}

	public void setItemProperty(String itemProperty) {
		this.itemProperty = itemProperty;
	}

	public String getItemDefaultValue() {
		return this.itemDefaultValue;
	}

	public void setItemDefaultValue(String itemDefaultValue) {
		this.itemDefaultValue = itemDefaultValue;
	}

	public String getItemFormula() {
		return this.itemFormula;
	}

	public void setItemFormula(String itemFormula) {
		this.itemFormula = itemFormula;
	}

	public String getItemCodeSet() {
		return this.itemCodeSet;
	}

	public void setItemCodeSet(String itemCodeSet) {
		this.itemCodeSet = itemCodeSet;
	}

	public boolean equals(Object o) {
		if (this == o)
			return true;
		if ((o == null) || (getClass() != o.getClass()))
			return false;

		InfoItemBO that = (InfoItemBO) o;

		if (this.itemId != null ? !this.itemId.equals(that.itemId)
				: that.itemId != null)
			return false;
		return this.setId != null ? this.setId.equals(that.setId)
				: that.setId == null;
	}

	public int hashCode() {
		int result = this.itemId != null ? this.itemId.hashCode() : 0;
		result = 29 * result + (this.setId != null ? this.setId.hashCode() : 0);
		return result;
	}

	static {
		htmlType.put("1", "i");
		htmlType.put("2", "f");
		htmlType.put("3", "s");
		htmlType.put("4", "s");
		htmlType.put("5", "d");
		htmlType.put("6", "code");
		htmlType.put("7", "OU");
		htmlType.put("8", "PE");
		htmlType.put("9", "a");
		htmlType.put("10", "lob");
		htmlType.put("11", "PO");
		htmlType.put("12", "PA");
		htmlType.put("13", "WA");
		htmlType.put("14", "IGM");
		htmlType.put("15", "d6");
		htmlType.put("23", "WageDept");

		PROPERTY_CONTROL_HIDE = "1";
		PROPERTY_CONTROL_SHOW = "2";
		PROPERTY_SYSTEM_ = "3";
		PROPERTY_EXTEND = "4";

		INFO_ITEM_SELF = "1";
		INFO_ITEM_SYSTEM = "0";

		SYSITEM_HIDDEN = "1";
		SYSITEM_READONLY = "2";
		SYSITEM_NOMARL = "3";
		USERITEM = "4";
	}
}