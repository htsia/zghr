package com.hr319wg.eva.web;

import java.util.ArrayList;

import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.pojo.bo.EvaPlanElectionControlBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.util.CodeUtil;

public class EvaSetElectionCtrolBackBean extends BaseBackingBean {
	private IEvaGradeUCC gradeUCC;
	private IEvaPlanUCC evaplanucc;
	private String initItem;
	private String planId;
	private List itemList;
	private String itemId;
	
	public String deleteItem(){
		try{
			evaplanucc.deleteEvaPlanElectionControlBO(itemId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public void doQuery(){
		try{
			itemList=new ArrayList();
			itemList=evaplanucc.getAllEvaPlanElectionControlBOByPlanId(planId);
			if(itemList!=null&&itemList.size()>0){
				for(int i=0;i<itemList.size();i++){
					EvaPlanElectionControlBO bo=(EvaPlanElectionControlBO)itemList.get(i);
					bo.setMasterType(CodeUtil.interpertCode(bo.getMasterType()));
					bo.setGradeItem(gradeUCC.getGradeItem(bo.getGradeItem()).getItemName());
					itemList.set(i, bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitItem() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		doQuery();
		return initItem;
	}
	public void setInitItem(String initItem) {
		this.initItem = initItem;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public List getItemList() {
		return itemList;
	}
	public void setItemList(List itemList) {
		this.itemList = itemList;
	}
	public IEvaGradeUCC getGradeUCC() {
		return gradeUCC;
	}
	public void setGradeUCC(IEvaGradeUCC gradeUCC) {
		this.gradeUCC = gradeUCC;
	}
	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}
	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
	//增加控制比例
	private String initEdit;
	private EvaPlanElectionControlBO control=new EvaPlanElectionControlBO();
	private List gradeItemList;
	
	public List getGradeItemList() {
		try{
			gradeItemList=new ArrayList();
			EvaPlanBO planbo=evaplanucc.findPlanById(planId);
			if(planbo.getPlanGrade()!=null&&!planbo.getPlanGrade().equals("")){
				List itemList=gradeUCC.getAllGradeItem(planbo.getPlanGrade());
				if(itemList!=null&&itemList.size()>0){
					for(int i=0;i<itemList.size();i++){
						EvaGradeItemBO bo=(EvaGradeItemBO)itemList.get(i);
						SelectItem si=new SelectItem();
						si.setLabel(bo.getItemName());
						si.setValue(bo.getItemID());
						gradeItemList.add(si);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return gradeItemList;
	}

	public void setGradeItemList(List gradeItemList) {
		this.gradeItemList = gradeItemList;
	}

	public String saveControl(){
		try{
			EvaPlanElectionControlBO bo=this.evaplanucc.findTheSuitEvaPlanElectionControlBO(planId,control.getMasterType(), control.getGradeItem());
			if(bo!=null){
				super.showMessageDetail("已设置该级别等级比例！");
				return "";
			}else{
				control.setPlanId(planId);
				evaplanucc.saveEvaPlanElectionControlBO(control);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}

	public String getInitEdit() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public EvaPlanElectionControlBO getControl() {
		return control;
	}

	public void setControl(EvaPlanElectionControlBO control) {
		this.control = control;
	}
}
