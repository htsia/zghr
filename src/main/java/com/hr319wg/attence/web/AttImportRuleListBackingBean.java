package com.hr319wg.attence.web;

import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.attence.pojo.bo.AttFileImportItemBO;
import com.hr319wg.attence.ucc.IAttenceSetUCC;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.web.BaseBackingBean;

public class AttImportRuleListBackingBean extends BaseBackingBean {
	private static String enterflag="1"; //进标记可扩展接口
	private static String outflag="2";   //出标记可扩展接口
	private static String importid;
	private IAttenceSetUCC attenceSetUCC;
	private String pageInit;
	private String importID;
	private String importName;
	private List lists;
	private String atttype;
	private String initEdit;
	private AttFileImportItemBO bo=new AttFileImportItemBO();
	private String itemID;
	
	public List getLists() {
		return lists;
	}

	public void setLists(List lists) {
		this.lists = lists;
	}

	public String getImportID() {
		return importID;
	}

	public void setImportID(String importID) {
		this.importID = importID;
	}

	public String getImportName() {
		return importName;
	}

	public void setImportName(String importName) {
		this.importName = importName;
	}

	public String getPageInit() {
		try{
		if (super.getRequestParameter("importID") != null
				&& !super.getRequestParameter("importID").equals("")
				&& super.getRequestParameter("oid") != null
				&& !super.getRequestParameter("oid").equals("")) {
			importID = super.getRequestParameter("importID");
			importid=importID; 
			importName = super.getRequestParameter("oid");
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public IAttenceSetUCC getAttenceSetUCC() {
		return attenceSetUCC;
	}

	public void setAttenceSetUCC(IAttenceSetUCC attenceSetUCC) {
		this.attenceSetUCC = attenceSetUCC;
	}

	public void doQuery() {
		try {
			lists = attenceSetUCC.getAttFileImportItemBO(importID);
			if (lists != null && lists.size() > 0) {
				for (int i = 0; i < lists.size(); i++) {
					AttFileImportItemBO attfileimportitembo = (AttFileImportItemBO) lists
							.get(i);
					if(!"".equals(attfileimportitembo.getItemType())){
						if("1".equals(attfileimportitembo.getItemType())){
							attfileimportitembo.setItemTypeName("卡号");
						}else if("2".equals(attfileimportitembo.getItemType())){
							attfileimportitembo.setItemTypeName("时间");
						}else if("3".equals(attfileimportitembo.getItemType())){
							attfileimportitembo.setItemTypeName("考勤机号");
						}else if("4".equals(attfileimportitembo.getItemType())){
							attfileimportitembo.setItemTypeName("进出标志");
						}else if("5".equals(attfileimportitembo.getItemType())){
							attfileimportitembo.setItemTypeName("员工编号");
						}else{
							attfileimportitembo.setItemTypeName("旧系统员工编号");
						}
					}
					if(attfileimportitembo.getEnterFlag()!=null && !"".equals(attfileimportitembo.getEnterFlag())){
						attfileimportitembo.setEnterFlagName("入");
					}
					if(attfileimportitembo.getOutFlag()!=null && !"".equals(attfileimportitembo.getOutFlag())){
						attfileimportitembo.setOutFlagName("出");
					}
					
					if(attfileimportitembo.getPostStart()!=null && !"".equals(attfileimportitembo.getPostStart())){
						attfileimportitembo.setPostStart(attfileimportitembo.getPostStart());
					}else{
						attfileimportitembo.setPostStart("-");
					}
					
					if(attfileimportitembo.getPostEnd()!=null && !"".equals(attfileimportitembo.getPostEnd())){
						attfileimportitembo.setPostEnd(attfileimportitembo.getPostEnd());
					}else{
						attfileimportitembo.setPostEnd("-");
					}
					lists.set(i, attfileimportitembo);
				}
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
	}
	
	public String getInitEdit() {
		try {
		if (super.getRequestParameter("itemID") != null
				&& !super.getRequestParameter("itemID").equals("")){
			String itemID = super.getRequestParameter("itemID");
			bo=attenceSetUCC.findAttFileImportItemBObyId(itemID);
			atttype=bo.getItemType();
			if(bo.getPostStart()!=null && !"".equals(bo.getPostStart())){
				bo.setPostStart(bo.getPostStart());
			}else{
				bo.setPostStart("-");
			}
			
			if(bo.getPostEnd()!=null && !"".equals(bo.getPostEnd())){
				bo.setPostEnd(bo.getPostEnd());
			}else{
				bo.setPostEnd("-");
			}
		}else if(super.getRequestParameter("okID") != null ){
			bo.setItemID(null);
			bo.setColNum("");
			bo.setPostStart("");
			bo.setPostEnd("");
			bo.setEnterFlag("");
			bo.setOutFlag("");
		}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return initEdit;
	}   
	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public AttFileImportItemBO getBo() {
		return bo;
	}

	public void setBo(AttFileImportItemBO bo) {
		this.bo = bo;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public String save(){
		bo.setImportID(importid);
		bo.setItemType(atttype);
		if(!"4".equals(atttype)){
			bo.setEnterFlag(enterflag);
		}else{
			bo.setOutFlag(outflag);
		}
		try {
			attenceSetUCC.saveorupdateAttFileImportItemBO(bo);
		} catch (SysException e) {
			e.printStackTrace();
		}
		return "success";
	}
	
	public String delete(){
		try {
			if (itemID != null) {
				attenceSetUCC.deleteAttFileImportItemBO(itemID);
			}
		} catch (Exception e) {
			super.showMessageDetail("删除失败！");
		}
		return "";
	}	
	
	public String getAtttype() {
		return atttype;
	}

	public void setAtttype(String atttype) {
		this.atttype = atttype;
	}

	public void changeStatus(ValueChangeEvent event) {
		this.atttype = event.getNewValue().toString();
	}
}
