package com.hr319wg.attence.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttClassGroupBO;
import com.hr319wg.attence.pojo.bo.AttPersonArrangeBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CommonFuns;

public class AutoRearrangeBackingBean extends BaseBackingBean {
	private List groupValuelist=new ArrayList();
	private String groupValue;
	private String className;
	private String arrangeId;
	private String personName = super.getUserInfo().getName();
	private String atttype;
	private List nowyearlist = new ArrayList();
	private String nowyearvalue;
	private AttPersonArrangeBO bo=new AttPersonArrangeBO();
	private String initEdit;
	private String superName;
	private String superId=super.getUserInfo().getOrgId();
	private List dateList;
	private String pageInit;
	private IAttenceSetUCC attenceSetUCC;
	private PageVO mypage = new PageVO();

	public String first() {
		mypage.setCurrentPage(1);
		doQuery();
		return "";
	}

	public String pre() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		doQuery();
		return "";
	}

	public String next() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		doQuery();
		return "";
	}

	public String last() {
		mypage.setCurrentPage(mypage.getTotalPage());
		doQuery();
		return "";
	}
	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	
	public List getDateList() {
		return dateList;
	}

	public void setDateList(List dateList) {
		this.dateList = dateList;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String getSuperName() {
		OrgBO b = SysCacheTool.findOrgById(this.superId);
		if (b != null) {
			superName = b.getName();
		}
		return superName;
	}

	public void setSuperName(String superName) {
		this.superName = superName;
	}

	public AttPersonArrangeBO getBo() {
		return bo;
	}

	public void setBo(AttPersonArrangeBO bo) {
		this.bo = bo;
	}

	public String getInitEdit() {
			if (super.getRequestParameter("superId") != null && !super.getRequestParameter("superId").equals("")) {
				superId = super.getRequestParameter("superId");
				bo.setRestDay("4");
			}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getNowyearvalue() {
		return nowyearvalue;
	}

	public void setNowyearvalue(String nowyearvalue) {
		this.nowyearvalue = nowyearvalue;
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

	public String getPersonName() {
		return personName;
	}

	public void setPersonName(String personName) {
		this.personName = personName;
	}

	public String getArrangeId() {
		return arrangeId;
	}

	public void setArrangeId(String arrangeId) {
		this.arrangeId = arrangeId;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getGroupValue() {
		return groupValue;
	}

	public void setGroupValue(String groupValue) {
		this.groupValue = groupValue;
	}

	public List getGroupValuelist() {
		doQueryGroup();
		return groupValuelist;
	}

	public void setGroupValuelist(List groupValuelist) {
		this.groupValuelist = groupValuelist;
	}

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			dateList=attenceSetUCC.getAllAttPersonArrangeBO(mypage,superId);
			if (dateList != null && dateList.size() > 0) {
				for (int i = 0; i < dateList.size(); i++) {
					AttPersonArrangeBO attpersonarrangebo=(AttPersonArrangeBO)dateList.get(i);
					attpersonarrangebo.setStatusValues(attpersonarrangebo.getStatus().trim());
					dateList.set(i, attpersonarrangebo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String save(){
		try {
			String ymd1 = bo.getDuraBegin();
			String ymd2 = bo.getDuraEnd();
			if (CommonFuns.betweenMonths(ymd2, ymd1) > 1) {
				super.showMessageDetail("计算的最长期限不超过一个月！");
				return "";
			}
			 boolean success=true;
			 List lists=attenceSetUCC.findAttPersonArrangeBO(superId);
				if (lists != null && lists.size() > 0) {
					for (int i = 0; i < lists.size(); i++) {
						AttPersonArrangeBO attpersonarrangebo=(AttPersonArrangeBO)lists.get(i);
						if ("-1".equals(attpersonarrangebo.getStatus().trim())
								|| "0".equals(attpersonarrangebo.getStatus().trim())) {
							success=false;
							break;
						}
					}
				}
				if(success){
					bo.setOrgId(superId);
					bo.setCreateDate(CommonFuns.getSysDate("yyyy-MM-dd"));
					bo.setCreateOper(personName);
					bo.setDuraYear(this.nowyearvalue);
					bo.setDuraMonth(this.atttype);
					bo.setStatus("-1");
					bo.setGroupId(groupValue);
					attenceSetUCC.saveorupdateAttPersonArrangeBO(bo);
				}else{
					super.showMessageDetail("上个月自动排班未结束，不能进行此步操作！");
					return "";
				}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public String finish(){
		try{
		AttPersonArrangeBO attpersonarrangebo=attenceSetUCC.findAttPersonArrangeBObyId(arrangeId);
		attpersonarrangebo.setStatus("9");
		attenceSetUCC.saveorupdateAttPersonArrangeBO(attpersonarrangebo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public void doQueryYear() {
		String nowyear = new SimpleDateFormat("yyyy").format(new java.util.Date());
		nowyearvalue = nowyear;
		String nowmonth = new SimpleDateFormat("MM").format(new java.util.Date());
		atttype = nowmonth;
		int m = Integer.parseInt(nowyear);
		for (int i = 4; i > 0; i--) {
			String num = (m - i) + "";
			SelectItem si = new SelectItem();
			si.setLabel(num);
			si.setValue(num);
			nowyearlist.add(si);
		}

		SelectItem si1 = new SelectItem();
		si1.setLabel(nowyear);
		si1.setValue(nowyear);
		nowyearlist.add(si1);

		for (int i = 1; i <= 30; i++) {
			String num = (m + i) + "";
			SelectItem si = new SelectItem();
			si.setLabel(num);
			si.setValue(num);
			nowyearlist.add(si);
		}
	}
	
	public void doQueryGroup() {
		try{
			if(groupValuelist!=null && groupValuelist.size()>0){
				groupValuelist=new ArrayList();
			}
		List groupValueLists=attenceSetUCC.findGroupValues(superId);
		if(groupValueLists!=null){
			for(int i=0;i<groupValueLists.size();i++){
				AttClassGroupBO attclassgroupbo=(AttClassGroupBO)groupValueLists.get(i);
				SelectItem si = new SelectItem();
				si.setLabel(attclassgroupbo.getGroupName());
				si.setValue(attclassgroupbo.getGroupNo());
				groupValuelist.add(si);
			}
		}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void changeGroupValue(ValueChangeEvent event) {
		this.groupValue = event.getNewValue().toString();
	}
	
	public void changeNowYearValue(ValueChangeEvent event) {
		this.nowyearvalue = event.getNewValue().toString();
	}
	
	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}
	
}
