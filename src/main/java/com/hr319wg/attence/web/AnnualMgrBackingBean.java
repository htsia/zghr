package com.hr319wg.attence.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.faces.event.ActionEvent;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import com.hr319wg.attence.pojo.bo.AttAnnualItemBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRecordBO;
import com.hr319wg.attence.pojo.bo.AttAnnualRuleBO;
import com.hr319wg.attence.pojo.vo.AttClassGroupVO;
import com.hr319wg.attence.ucc.IAttAnnualUCC;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;

public class AnnualMgrBackingBean extends BaseBackingBean {
	private String recID;
	private String ruleName;
	private String nowyearvalue;
	private List nowyearlist = new ArrayList();
	private AttAnnualRecordBO bo = new AttAnnualRecordBO();
	private AttAnnualItemBO attannualitembo = new AttAnnualItemBO();
	private String initEdit;
	private List lists;
	private PageVO mypage = new PageVO();
	private String superName;
	private String superId = super.getUserInfo().getOrgId();
	private String pageInit;
	 private IAttAnnualUCC attAnnualUcc;
    private String annItemEdit ;

    public IAttAnnualUCC getAttAnnualUcc() {
        return attAnnualUcc;
    }

    public void setAttAnnualUcc(IAttAnnualUCC attAnnualUcc) {
        this.attAnnualUcc = attAnnualUcc;
    }

    public String getAnnItemEdit() {
		try {
			if (super.getRequestParameter("itemID")!= null && !"".equals(super.getRequestParameter("itemID"))) {
				superId = super.getRequestParameter("itemID");
			}
		    attannualitembo = attAnnualUcc.findAttAnnualItemBObyId(superId);
	        attannualitembo.setPersonName(SysCacheTool.findPersonById(attannualitembo.getPersonID()).getName());
		} catch (SysException e) {
			e.printStackTrace();
		}
		return annItemEdit;
	}
	
	public String  saveOrUpdateAnnItemBO(){
		try {
			attannualitembo.setItemID(superId);
			attannualitembo.setUseDay("0");
			attannualitembo.setAvaDay(attannualitembo.getAnnDay());
			attAnnualUcc.saveAttAnnualItemBO(attannualitembo);
		} catch (SysException e) {
			e.printStackTrace();
		}
	return "success" ;
	}

	public void setAnnItemEdit(String annItemEdit) {
		this.annItemEdit = annItemEdit;
	}

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


	public String getPageInit() {
		if (super.getUserInfo().getOrgId() != null
				&& !super.getUserInfo().getOrgId().equals("")) {
			superId = super.getUserInfo().getOrgId();
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
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

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public AttAnnualItemBO getAttannualitembo() {
		return attannualitembo;
	}

	public void setAttannualitembo(AttAnnualItemBO attannualitembo) {
		this.attannualitembo = attannualitembo;
	}

	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("superId") != null) {
				superId = super.getRequestParameter("superId");
				bo.setRecID(null);
				bo.setOrgID(superId);
			} else if (super.getRequestParameter("recID") != null
					&& !super.getRequestParameter("recID").equals("")) {
				String recID = super.getRequestParameter("recID");
				bo = attAnnualUcc.findAttAnnualRecordBOById(recID);
				nowyearvalue=bo.getRecodeYear();
				AttAnnualRuleBO attannualrulebo=(AttAnnualRuleBO)attAnnualUcc.findAttAnnualRuleBObyId(bo.getRuleID());
				if(attannualrulebo!=null){
				if(attannualrulebo.getRuleName()!=null && !"".equals(attannualrulebo.getRuleName())){
					ruleName=attannualrulebo.getRuleName();
				}
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public AttAnnualRecordBO getBo() {
		return bo;
	}

	public void setBo(AttAnnualRecordBO bo) {
		this.bo = bo;
	}

	public String getRuleName() {
		return ruleName;
	}

	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}

	public String getNowyearvalue() {
		return nowyearvalue;
	}

	public void setNowyearvalue(String nowyearvalue) {
		this.nowyearvalue = nowyearvalue;
	}

	public String getRecID() {
		return recID;
	}

	public void setRecID(String recID) {
		this.recID = recID;
	}

	public List getNowyearlist() {
		if(nowyearlist!=null){
			nowyearlist=new ArrayList();
		}
		String nowyear = new SimpleDateFormat("yyyy")
				.format(new java.util.Date());
		nowyearvalue = nowyear;
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
		return nowyearlist;
	}

	public void setNowyearlist(List nowyearlist) {
		this.nowyearlist = nowyearlist;
	}

	public String doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			lists = attAnnualUcc.getAllAttAnnualRecordBO(mypage, superId);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttAnnualRecordBO attannualrecordbo = (AttAnnualRecordBO) lists
							.get(i);
                    if(attannualrecordbo.getRuleID()!=null&&!attannualrecordbo.getRuleID().equals("")){
                        AttAnnualRuleBO attannualrulebo = attAnnualUcc.findAttAnnualRuleBObyId(attannualrecordbo.getRuleID());
                        if(attannualrulebo!=null){
                            attannualrecordbo.setRuleName(attannualrulebo.getRuleName());
                        }
                    }
					lists.set(i, attannualrecordbo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "";
	}

	public String save() {
		bo.setRecodeYear(nowyearvalue);
		bo.setStatusValue("0");
		try {
			attAnnualUcc.saveAttAnnualRecordBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
	return "success";	
	}
	
public String delete(){
	try{
		if(recID!=null && !"".equals(recID)){
			List lists=attAnnualUcc.getAttAnnualItemBO(recID);
			if(lists!=null && lists.size()>0){
				super.showMessageDetail("该年度已有数据，不能删除！");
				return "";
			}else{
				attAnnualUcc.deleteAttAnnualRecordBO(recID);
			}
		}
	}catch(Exception e){
		
	}
	return "";
}
	
public String gameOver(){
	try{
		if(recID!=null && !"".equals(recID)){
				AttAnnualRecordBO  attannualrecordbo= attAnnualUcc.findAttAnnualRecordBOById(recID);
				attannualrecordbo.setStatusValue("1");
				attAnnualUcc.saveAttAnnualRecordBO(attannualrecordbo);
		}
	}catch(Exception e){
		
	}
	return "";
}

	public void changeNowYearValue(ValueChangeEvent event) {
		this.nowyearvalue = event.getNewValue().toString();
	}
	
}
