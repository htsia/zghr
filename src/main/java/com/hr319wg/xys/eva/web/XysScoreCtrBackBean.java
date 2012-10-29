package com.hr319wg.xys.eva.web;

import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysScoreCtrBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;

public class XysScoreCtrBackBean extends BaseBackingBean {
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private IEvaGradeUCC evaGradeUCC;
	private String pageInit;
	private String planId;
	private String type;
	private List ctrList;
	

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
	
	public void queryCtr(){
		try{
			List list=xysEvaPlanUCC.getXysScoreCtrBOByPlanId(planId, type);
			if(list==null||list.size()<=0){
				XysEvaPlanBO plan=xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				if(plan.getPlanGrade()!=null&&!plan.getPlanGrade().equals("")){
					List items=evaGradeUCC.getAllGradeItem(plan.getPlanGrade());
					if(items!=null&&items.size()>0){
						for(int i=0;i<items.size();i++){
							EvaGradeItemBO item=(EvaGradeItemBO)items.get(i);
							XysScoreCtrBO bo=new XysScoreCtrBO();
							bo.setPlanId(planId);
							bo.setType(type);
							bo.setGradeItem(item.getItemID());
							bo.setCount("");//默认不限制
							xysEvaPlanUCC.saveXysScoreCtrBO(bo);
						}
					}
				}
			}
			ctrList=xysEvaPlanUCC.getXysScoreCtrBOByPlanId(planId, type);
			if(ctrList!=null&&ctrList.size()>0){
				for(int i=0;i<ctrList.size();i++){
					XysScoreCtrBO bo=(XysScoreCtrBO)ctrList.get(i);
					EvaGradeItemBO item=evaGradeUCC.getGradeItem(bo.getGradeItem());
					bo.setGradeItem(item.getItemName());
					if(bo.getCount()==null||bo.getCount().equals("")){
						bo.setCount("不限制");
					}
					ctrList.set(i, bo);
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
		if(super.getRequestParameter("type")!=null){
			type=super.getRequestParameter("type");
		}
		queryCtr();
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List getCtrList() {
		return ctrList;
	}

	public void setCtrList(List ctrList) {
		this.ctrList = ctrList;
	}
	
	private String ctrId;
	private String initEdit;
	private XysScoreCtrBO ctrBo;
	
	
	public XysScoreCtrBO getCtrBo() {
		return ctrBo;
	}

	public void setCtrBo(XysScoreCtrBO ctrBo) {
		this.ctrBo = ctrBo;
	}

	public String getCtrId() {
		return ctrId;
	}

	public void setCtrId(String ctrId) {
		this.ctrId = ctrId;
	}
	public String saveCtr(){
		try{
			xysEvaPlanUCC.saveXysScoreCtrBO(ctrBo);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getInitEdit() {
		try{
			if(super.getRequestParameter("ctrId")!=null){
				ctrId=super.getRequestParameter("ctrId");
				ctrBo=xysEvaPlanUCC.findXysScoreCtrBOById(ctrId);
				ctrBo.setGradeName(this.evaGradeUCC.getGradeItem(ctrBo.getGradeItem()).getItemName());
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}
	
	

}
