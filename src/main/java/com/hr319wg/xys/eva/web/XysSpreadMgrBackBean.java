package com.hr319wg.xys.eva.web;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadDeptSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetItemBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysSpreadMgrUCC;

public class XysSpreadMgrBackBean extends BaseBackingBean {
	private IXysSpreadMgrUCC xysSpreadMgrUCC;
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private IEvaGradeUCC evaGradeUCC;
	private String pageInit;
	private String planId;
	private List setList;
	private String deptDesabled;
	private List gradeList;
	
	public List getGradeList() {
		try{
			gradeList=new ArrayList();
			if(planId!=null&&!planId.equals("")){
				XysEvaPlanBO bo1 = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				List gList=this.evaGradeUCC.getAllGradeItem(bo1.getPlanGrade());
				if(gList!=null&&gList.size()>0){
					for(int i=0;i<gList.size();i++){
						EvaGradeItemBO item=(EvaGradeItemBO)gList.get(i);
						SelectItem si=new SelectItem();
						si.setLabel(item.getItemName());
						si.setValue(item.getItemID());
						gradeList.add(si);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return gradeList;
	}
	public void setGradeList(List gradeList) {
		this.gradeList = gradeList;
	}
	public String getDeptDesabled() {
		return deptDesabled;
	}
	public void setDeptDesabled(String deptDesabled) {
		this.deptDesabled = deptDesabled;
	}
	public IXysSpreadMgrUCC getXysSpreadMgrUCC() {
		return xysSpreadMgrUCC;
	}
	public void setXysSpreadMgrUCC(IXysSpreadMgrUCC xysSpreadMgrUCC) {
		this.xysSpreadMgrUCC = xysSpreadMgrUCC;
	}
	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}
	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
	}
	public IEvaGradeUCC getEvaGradeUCC() {
		return evaGradeUCC;
	}
	public void setEvaGradeUCC(IEvaGradeUCC evaGradeUCC) {
		this.evaGradeUCC = evaGradeUCC;
	}
	public void querySet(){
		try{
			XysEvaPlanBO bo1 = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
			if(bo1.getStatus().equals(XysEvaPlanBO.STATUS_ZHIXING)){
				this.deptDesabled="0";
			}else{
				this.deptDesabled="1";
			}
			List list=this.xysSpreadMgrUCC.getXysSpreadSetBOByPlanId(planId);
			if(list==null||list.size()==0){
				List gradeList=this.evaGradeUCC.getAllGradeItem(bo1.getPlanGrade());
				if(gradeList!=null&&gradeList.size()>0){
					for(int i=0;i<gradeList.size();i++){
						EvaGradeItemBO bo=(EvaGradeItemBO)gradeList.get(i);
						XysSpreadSetBO set=new XysSpreadSetBO();
						set.setGradeItem(bo.getItemID());
						set.setPlanId(planId);
						set.setCtrType("1");//默认控制数目
						xysSpreadMgrUCC.saveXysSpreadSetBO(set);
					}
				}
			}
			setList=this.xysSpreadMgrUCC.getXysSpreadSetBOByPlanId(planId);
			if(setList!=null&&setList.size()>0){
				for(int i=0;i<setList.size();i++){
					XysSpreadSetBO set=(XysSpreadSetBO)setList.get(i);
					EvaGradeItemBO bo=evaGradeUCC.getGradeItem(set.getGradeItem());
					if(set.getChgGradeItem()!=null&&!set.getChgGradeItem().equals("")){
						EvaGradeItemBO chgbo=evaGradeUCC.getGradeItem(set.getChgGradeItem());
						set.setChgGradeItem(chgbo.getItemName());
					}
					set.setGradeName(bo.getItemName());
					
					setList.set(i, set);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		querySet();
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public List getSetList() {
		return setList;
	}
	public void setSetList(List setList) {
		this.setList = setList;
	}
	//修改属性
	private String initEdit;
	private XysSpreadSetBO setBo=new XysSpreadSetBO();
	private String setId;
	
	public String saveSet(){
		try{
			xysSpreadMgrUCC.saveXysSpreadSetBO(setBo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getSetId() {
		return setId;
	}
	public void setSetId(String setId) {
		this.setId = setId;
	}
	public String getInitEdit() {
		try{
			if(super.getRequestParameter("setId")!=null){
				setId=super.getRequestParameter("setId");
				setBo=this.xysSpreadMgrUCC.findXysSpreadSetBOById(setId);
				EvaGradeItemBO bo=evaGradeUCC.getGradeItem(setBo.getGradeItem());
				setBo.setGradeName(bo.getItemName());
				planId=setBo.getPlanId();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}
	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	public XysSpreadSetBO getSetBo() {
		return setBo;
	}
	public void setSetBo(XysSpreadSetBO setBo) {
		this.setBo = setBo;
	}
	
	//设置员工等级配置
	private String initItem;
	private List itemList;

	public void queryItem(){
		try{
			XysEvaPlanBO bo1 = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
			if(bo1.getStatus().equals(XysEvaPlanBO.STATUS_ZHIXING)){
				this.deptDesabled="0";
			}else{
				this.deptDesabled="1";
			}
			List list=this.xysSpreadMgrUCC.getXysSpreadSetItemBOBySetId(setId);
			if(list==null||list.size()==0){
				XysSpreadSetBO set=this.xysSpreadMgrUCC.findXysSpreadSetBOById(setId);
				XysEvaPlanBO planbo=this.xysEvaPlanUCC.findXysEvaPlanBOById(set.getPlanId());
				List gradeList=this.evaGradeUCC.getAllGradeItem(planbo.getPlanGrade());
				if(gradeList!=null&&gradeList.size()>0){
					for(int i=0;i<gradeList.size();i++){
						EvaGradeItemBO bo=(EvaGradeItemBO)gradeList.get(i);
						XysSpreadSetItemBO item=new XysSpreadSetItemBO();
						item.setSetId(setId);
						item.setGradeItem(bo.getItemID());
						item.setCtrType("1");//默认控制数目
						xysSpreadMgrUCC.saveXysSpreadSetItemBO(item);
					}
				}
			}
			itemList=this.xysSpreadMgrUCC.getXysSpreadSetItemBOBySetId(setId);
			if(itemList!=null&&itemList.size()>0){
				for(int i=0;i<itemList.size();i++){
					XysSpreadSetItemBO item=(XysSpreadSetItemBO)itemList.get(i);
					EvaGradeItemBO bo=evaGradeUCC.getGradeItem(item.getGradeItem());
					item.setGradeName(bo.getItemName());
					if(item.getChgGradeItem()!=null&&!item.getChgGradeItem().equals("")){
						EvaGradeItemBO chgbo=evaGradeUCC.getGradeItem(item.getChgGradeItem());
						item.setChgGradeItem(chgbo.getItemName());
					}
					itemList.set(i, item);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitItem() {
		if(super.getRequestParameter("setId")!=null){
			setId=super.getRequestParameter("setId");
		}
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		queryItem();
		return initItem;
	}
	public void setInitItem(String initItem) {
		this.initItem = initItem;
	}
	public List getItemList() {
		return itemList;
	}
	public void setItemList(List itemList) {
		this.itemList = itemList;
	}
	//编辑项目
	private String initItemEdit;
	private XysSpreadSetItemBO itemBo=new XysSpreadSetItemBO();
	private String itemId;

	public String saveItem(){
		try{
			xysSpreadMgrUCC.saveXysSpreadSetItemBO(itemBo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public String getInitItemEdit() {
		try{
			if(super.getRequestParameter("itemId")!=null){
				itemId=super.getRequestParameter("itemId");
				itemBo=this.xysSpreadMgrUCC.findXysSpreadSetItemBO(itemId);
				XysSpreadSetBO set=this.xysSpreadMgrUCC.findXysSpreadSetBOById(itemBo.getSetId());
				EvaGradeItemBO bo=evaGradeUCC.getGradeItem(itemBo.getGradeItem());
				itemBo.setGradeName(bo.getItemName());
				planId=set.getPlanId();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initItemEdit;
	}
	public void setInitItemEdit(String initItemEdit) {
		this.initItemEdit = initItemEdit;
	}
	public XysSpreadSetItemBO getItemBo() {
		return itemBo;
	}
	public void setItemBo(XysSpreadSetItemBO itemBo) {
		this.itemBo = itemBo;
	}
	//部门等级设置
	private String initDeptItem;
	private String deptId;
	private List deptItemList;
	private String initDeptEdit;
	private XysSpreadDeptSetBO deptSetBo=new XysSpreadDeptSetBO();
	
	public String saveDept(){
		try{
			xysSpreadMgrUCC.saveXysSpreadDeptSetBO(deptSetBo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getInitDeptEdit() {
		try{
			if(super.getRequestParameter("setId")!=null){
				setId=super.getRequestParameter("setId");
				deptSetBo=this.xysSpreadMgrUCC.findXysSpreadDeptSetBOById(setId);
				EvaGradeItemBO bo=evaGradeUCC.getGradeItem(deptSetBo.getGradeItem());
				deptSetBo.setGradeName(bo.getItemName());
				planId=deptSetBo.getPlanId();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initDeptEdit;
	}
	public void setInitDeptEdit(String initDeptEdit) {
		this.initDeptEdit = initDeptEdit;
	}
	public XysSpreadDeptSetBO getDeptSetBo() {
		return deptSetBo;
	}
	public void setDeptSetBo(XysSpreadDeptSetBO deptSetBo) {
		this.deptSetBo = deptSetBo;
	}
	public void queryDeptItem(){
		try{
			deptItemList=this.xysSpreadMgrUCC.getXysSpreadDeptSetBO(planId, deptId);
			if(deptItemList!=null&&deptItemList.size()>0){
				for(int i=0;i<deptItemList.size();i++){
					XysSpreadDeptSetBO bo=(XysSpreadDeptSetBO)deptItemList.get(i);
					EvaGradeItemBO grade=evaGradeUCC.getGradeItem(bo.getGradeItem());
					if(bo.getChgGradeItem()!=null&&bo.getChgGradeItem().equals("")){
						EvaGradeItemBO grade1=evaGradeUCC.getGradeItem(bo.getChgGradeItem());
						bo.setChgGradeItem(grade1.getItemName());
					}
					bo.setGradeName(grade.getItemName());
					deptItemList.set(i,bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitDeptItem() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		if(super.getRequestParameter("deptId")!=null){
			deptId=super.getRequestParameter("deptId");
		}
		queryDeptItem();
		return initDeptItem;
	}
	public void setInitDeptItem(String initDeptItem) {
		this.initDeptItem = initDeptItem;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public List getDeptItemList() {
		return deptItemList;
	}
	public void setDeptItemList(List deptItemList) {
		this.deptItemList = deptItemList;
	}
	
	
}
