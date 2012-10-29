package com.hr319wg.attence.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttItemSetDetailBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;

public class ItemSetConfigBackingBean extends BaseBackingBean {
	private boolean isExist = true;
	private String unitvalue;
	private String itemID;
	private AttItemSetDetailBO attitemsetdetailbo = new AttItemSetDetailBO();
	private String initEdit;
	private List nowyearlist = new ArrayList();
	private String atttype;
	private String superId = super.getUserInfo().getOrgId();
	private String pageInit;
	private List itemList = new ArrayList();
	private String flagcharname;
	private IAttenceSetUCC attenceSetUCC;
	private String dayField;
	private String monthField;
	private String yearField;
	private List dayfieldlist = new ArrayList();
	private List monthfieldlist = new ArrayList();
	private List yearfieldlist = new ArrayList();

	public boolean getIsExist() {
		return isExist;
	}

	public void setExist(boolean isExist) {
		this.isExist = isExist;
	}

	public String getUnitvalue() {
		return unitvalue;
	}

	public void setUnitvalue(String unitvalue) {
		this.unitvalue = unitvalue;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public AttItemSetDetailBO getAttitemsetdetailbo() {
		return attitemsetdetailbo;
	}

	public void setAttitemsetdetailbo(AttItemSetDetailBO attitemsetdetailbo) {
		this.attitemsetdetailbo = attitemsetdetailbo;
	}

	public String getInitEdit() {
		try {
			if (nowyearlist != null && nowyearlist.size() > 0) {
				nowyearlist = new ArrayList();
			}
			if (dayfieldlist != null && dayfieldlist.size() > 0) {
				dayfieldlist = new ArrayList();
			}
			if (monthfieldlist != null && monthfieldlist.size() > 0) {
				monthfieldlist = new ArrayList();
			}
			if (yearfieldlist != null && yearfieldlist.size() > 0) {
				yearfieldlist = new ArrayList();
			}
			if (super.getRequestParameter("itemID") != null
					&& !super.getRequestParameter("itemID").equals("")) {
				itemID = super.getRequestParameter("itemID");
				attitemsetdetailbo = attenceSetUCC
						.findAttItemSetDetailBObyId(itemID);
				flagcharname = attitemsetdetailbo.getFlagChar();
				atttype = attitemsetdetailbo.getItemCode();
				unitvalue = attitemsetdetailbo.getUnit();
				dayField=attitemsetdetailbo.getDayField();
				monthField=attitemsetdetailbo.getMonthField();
				yearField=attitemsetdetailbo.getYearField();
				isExist = false;
			} else {
				attitemsetdetailbo = new AttItemSetDetailBO();
				flagcharname = "";
				atttype = "-";
				unitvalue = "-";
				isExist = true;
			}
		} catch (Exception e) {

		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public List getNowyearlist() {
		doQueryYear();
		return nowyearlist;
	}

	public void setNowyearlist(List nowyearlist) {
		this.nowyearlist = nowyearlist;
	}

	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public List getItemList() {
		return itemList;
	}

	public void setItemList(List itemList) {
		this.itemList = itemList;
	}

	public String getFlagcharname() {
		return flagcharname;
	}

	public void setFlagcharname(String flagcharname) {
		this.flagcharname = flagcharname;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String doQuery() {
		try {
			if (itemList != null && itemList.size() > 0) {
				itemList = new ArrayList();
			}
			List lists = attenceSetUCC.getAllAttItemSetDetailBO(superId);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttItemSetDetailBO attitemsetdetailbo = (AttItemSetDetailBO) lists
							.get(i);
					if ("00".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("正常");
					} else if ("01".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("公休日");
					} else if ("704".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("迟到");
					} else if ("705".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("早退");
					} else if ("706".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("旷工");
					} else if ("707".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("事假");
					} else if ("708".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("病假");
					} else if ("709".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("产假");
					} else if ("710".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("婚假");
					} else if ("711".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("探亲假");
					} else if ("712".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("年假");
					} else if ("713".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("工伤假");
					} else if ("714".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("丧假");
					} else if ("715".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("出差");
					} else if ("716".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("公出");
					} else if ("717".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("公假");
					} else if ("718".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("倒休");
					} else if ("719".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("工作日加班");
					} else if ("720".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("双休日加班");
					} else if ("721".equals(attitemsetdetailbo.getItemCode())) {
						attitemsetdetailbo.setItemCodeName("节假日加班");
					}

					if ("-1".equals(attitemsetdetailbo.getUnit())) {
						attitemsetdetailbo.setUnitName("-");
					} else if ("0".equals(attitemsetdetailbo.getUnit())) {
						attitemsetdetailbo.setUnitName("次");
					} else if ("1".equals(attitemsetdetailbo.getUnit())) {
						attitemsetdetailbo.setUnitName("天");
					} else if ("2".equals(attitemsetdetailbo.getUnit())) {
						attitemsetdetailbo.setUnitName("小时");
					} else if ("3".equals(attitemsetdetailbo.getUnit())) {
						attitemsetdetailbo.setUnitName("分钟");
					}

					if ("-1".equals(attitemsetdetailbo.getDayField())) {
						attitemsetdetailbo.setDayFieldName("-");
					} else {
						InfoItemBO ib = SysCacheTool.findInfoItem("",attitemsetdetailbo.getDayField());
						attitemsetdetailbo.setDayFieldName(ib.getItemName());
					} 
					if ("-1".equals(attitemsetdetailbo.getDayField())) {
						attitemsetdetailbo.setMonthFieldName("-");
					} else {
						InfoItemBO ib1 = SysCacheTool.findInfoItem("",attitemsetdetailbo.getMonthField());
						attitemsetdetailbo.setMonthFieldName(ib1.getItemName());
					} 
					if ("-1".equals(attitemsetdetailbo.getDayField())) {
						attitemsetdetailbo.setYearFieldName("-");
					} else {
						InfoItemBO ib2 = SysCacheTool.findInfoItem("",attitemsetdetailbo.getYearField());
						attitemsetdetailbo.setYearFieldName(ib2.getItemName());
					} 
					
					itemList.add(attitemsetdetailbo);
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
		}
		return "";
	}

	public String save() {
		try {
			if (!"-".equals(atttype)) {
				List lists = attenceSetUCC.findAllAttItemSetDetailBO(atttype,
						superId);
				if (lists != null && lists.size() > 0) {
					super.showMessageDetail("本机构中该规则名称已经存在！");
					return "";
				} else {
					if (!"704".equals(atttype) && !"705".equals(atttype)
							&& !"706".equals(atttype)) {
						if ("0".equals(unitvalue)) {
							super.showMessageDetail("假期、公出、出差、计量单位为次，无意义。");
							return "";
						}
					}
					if(!"00".equals(atttype) && !"01".equals(atttype)){
						if("-1".equals(dayField) || "-1".equals(monthField) || "-1".equals(yearField)){
							super.showMessageDetail("请选择日、月、年汇总字段。");
							return "";
						}
					}
                    dayField="A809"+atttype;
                    monthField="A810"+atttype;
                    yearField="A811"+atttype;
					attitemsetdetailbo.setCreateOrg(superId);
					attitemsetdetailbo.setFlagChar(flagcharname);
					attitemsetdetailbo.setItemCode(atttype);
					attitemsetdetailbo.setUnit(unitvalue);
					attitemsetdetailbo.setDayField(dayField);
					attitemsetdetailbo.setMonthField(monthField);
					attitemsetdetailbo.setYearField(yearField);
					attenceSetUCC
							.saveorupdateAttItemSetDetailBO(attitemsetdetailbo);
				}
			} else {
				super.showMessageDetail("请选择规则名称。");
				return "";
			}
		} catch (Exception e) {

		}
		return "success";
	}

	public String update() {
		try {
			if (!"-".equals(atttype)) {
				attenceSetUCC.deleteAttItemSetDetailBO(itemID);
				if (!"704".equals(atttype) && !"705".equals(atttype)
						&& !"706".equals(atttype)) {
					if ("0".equals(unitvalue)) {
						super.showMessageDetail("假期、公出、出差、计量单位为次，无意义。");
						return "";
					}
				}
				if(!"00".equals(atttype) && !"01".equals(atttype)){
					if("-1".equals(dayField) || "-1".equals(monthField) || "-1".equals(yearField)){
						super.showMessageDetail("请选择日、月、年汇总字段。");
						return "";
					}
				}
                dayField="A809"+atttype;
                monthField="A810"+atttype;
                yearField="A811"+atttype;
				attitemsetdetailbo.setCreateOrg(superId);
				attitemsetdetailbo.setFlagChar(flagcharname);
				attitemsetdetailbo.setItemCode(atttype);
				attitemsetdetailbo.setUnit(unitvalue);
				attitemsetdetailbo.setDayField(dayField);
				attitemsetdetailbo.setMonthField(monthField);
				attitemsetdetailbo.setYearField(yearField);
				attenceSetUCC
						.saveorupdateAttItemSetDetailBO(attitemsetdetailbo);
			} else {
				super.showMessageDetail("请选择规则名称。");
				return "";
			}
		} catch (Exception e) {

		}
		return "success";
	}

	public String delete() {
		try {
			attenceSetUCC.deleteAttItemSetDetailBO(itemID);
		} catch (Exception e) {

		}
		return "";
	}

	public void doQueryYear() {
		String[] codeNames = { "正常", "公休日", "迟到", "早退", "旷工", "事假", "病假", "产假",
				"婚假", "探亲假", "年假", "工伤假", "丧假", "出差", "公出", "公假", "倒休", "工作日延时加班", "双休日加班", "节假日加班"};
		String[] codeValues = { "00", "01", "704", "705", "706", "707", "708",
				"709", "710", "711", "712", "713", "714", "715", "716", "717", "718", "719", "720", "721" };
		for (int i = 0; i < codeNames.length; i++) {
			SelectItem si = new SelectItem();
			si.setLabel(codeNames[i]);
			si.setValue(codeValues[i]);
			nowyearlist.add(si);
		}
	}

	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}

	public void changeStatus1(ValueChangeEvent event) {
		this.unitvalue = event.getNewValue().toString();
	}

	public void changeStatus2(ValueChangeEvent event) {
		this.dayField = event.getNewValue().toString();
	}

	public void changeStatus3(ValueChangeEvent event) {
		this.monthField = event.getNewValue().toString();
	}

	public void changeStatus4(ValueChangeEvent event) {
		this.yearField = event.getNewValue().toString();
	}

	public String getDayField() {
		return dayField;
	}

	public void setDayField(String dayField) {
		this.dayField = dayField;
	}

	public String getMonthField() {
		return monthField;
	}

	public void setMonthField(String monthField) {
		this.monthField = monthField;
	}

	public String getYearField() {
		return yearField;
	}

	public void setYearField(String yearField) {
		this.yearField = yearField;
	}

	public List getDayfieldlist() {
		doQueryDayField();
		return dayfieldlist;
	}

	public void setDayfieldlist(List dayfieldlist) {
		this.dayfieldlist = dayfieldlist;
	}

	public List getMonthfieldlist() {
		doQueryMonthField();
		return monthfieldlist;
	}

	public void setMonthfieldlist(List monthfieldlist) {
		this.monthfieldlist = monthfieldlist;
	}

	public List getYearfieldlist() {
		doQueryYearField();
		return yearfieldlist;
	}

	public void setYearfieldlist(List yearfieldlist) {
		this.yearfieldlist = yearfieldlist;
	}

	public void doQueryDayField() {
		try {
			SelectItem si1 = new SelectItem();
			si1.setLabel("-");
			si1.setValue("-1");
			dayfieldlist.add(si1);
			List lists = attenceSetUCC.findAllInfoItemBO("A809");
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					InfoItemBO infoitembo = (InfoItemBO) lists.get(i);
					if (!"A809000".equals(infoitembo.getItemId())
							&& !"A809700".equals(infoitembo.getItemId())
							&& !"A809701".equals(infoitembo.getItemId())
							&& !"A809702".equals(infoitembo.getItemId())
							&& !"A809703".equals(infoitembo.getItemId())
							&& !"ID".equals(infoitembo.getItemId())
							&& !"SUBID".equals(infoitembo.getItemId())) {
						SelectItem si = new SelectItem();
						si.setLabel(infoitembo.getItemName());
						si.setValue(infoitembo.getItemId());
						dayfieldlist.add(si);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void doQueryMonthField() {
		try {
			SelectItem si1 = new SelectItem();
			si1.setLabel("-");
			si1.setValue("-1");
			monthfieldlist.add(si1);
			List lists = attenceSetUCC.findAllInfoItemBO("A810");
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					InfoItemBO infoitembo = (InfoItemBO) lists.get(i);
					if (!"A810000".equals(infoitembo.getItemId())
							&& !"A810700".equals(infoitembo.getItemId())
							&& !"A810701".equals(infoitembo.getItemId())
							&& !"A810702".equals(infoitembo.getItemId())
							&& !"A810703".equals(infoitembo.getItemId())
							&& !"ID".equals(infoitembo.getItemId())
							&& !"SUBID".equals(infoitembo.getItemId())
							&& !"A810200".equals(infoitembo.getItemId())
							&& !"A810201".equals(infoitembo.getItemId())
							&& !"A810791".equals(infoitembo.getItemId())
							&& !"A810792".equals(infoitembo.getItemId())) {
						SelectItem si = new SelectItem();
						si.setLabel(infoitembo.getItemName());
						si.setValue(infoitembo.getItemId());
						monthfieldlist.add(si);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void doQueryYearField() {
		try {
			SelectItem si1 = new SelectItem();
			si1.setLabel("-");
			si1.setValue("-1");
			yearfieldlist.add(si1);
			List lists = attenceSetUCC.findAllInfoItemBO("A811");
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					InfoItemBO infoitembo = (InfoItemBO) lists.get(i);
					if (!"A811000".equals(infoitembo.getItemId())
							&& !"A811700".equals(infoitembo.getItemId())
							&& !"A811701".equals(infoitembo.getItemId())
							&& !"A811702".equals(infoitembo.getItemId())
							&& !"A811703".equals(infoitembo.getItemId())
							&& !"ID".equals(infoitembo.getItemId())
							&& !"SUBID".equals(infoitembo.getItemId())) {
						SelectItem si = new SelectItem();
						si.setLabel(infoitembo.getItemName());
						si.setValue(infoitembo.getItemId());
						yearfieldlist.add(si);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
