package com.hr319wg.xys.eva.web;

import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.xys.eva.pojo.bo.XysDeptKpiDivBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;

public class XysDeptKpiDivMgrBackBean extends BaseBackingBean {
	private IXysKpiDeptUCC xysKpiDeptUCC;
	private String pageInit;
	private List divList;
	private String divId;
	private String planId;
	private String objId;
	private String deptDesabled;
	private IXysEvaPlanUCC xysEvaPlanUCC;
	
	
	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}

	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
	}

	public String getDeptDesabled() {
		return deptDesabled;
	}

	public void setDeptDesabled(String deptDesabled) {
		this.deptDesabled = deptDesabled;
	}

	public void deleteDiv() {
		try {
			xysKpiDeptUCC.deleteXysDeptKpiDivBO(divId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public String getObjId() {
		return objId;
	}

	public void setObjId(String objId) {
		this.objId = objId;
	}

	public IXysKpiDeptUCC getXysKpiDeptUCC() {
		return xysKpiDeptUCC;
	}

	public void setXysKpiDeptUCC(IXysKpiDeptUCC xysKpiDeptUCC) {
		this.xysKpiDeptUCC = xysKpiDeptUCC;
	}

	public void queryDiv() {
		try {
			divList = xysKpiDeptUCC.getXysDeptKpiDivBOByObjId(objId);
			XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
			if(bo.getStatus().equals(XysEvaPlanBO.STATUS_ZHIXING)){
				this.deptDesabled="0";
			}else{
				this.deptDesabled="1";
			}
			if (divList != null && divList.size() > 0) {
				for (int i = 0; i < divList.size(); i++) {
					XysDeptKpiDivBO div = (XysDeptKpiDivBO) divList.get(i);
					PersonBO pbo = SysCacheTool.findPersonById(div
							.getPersonId());
					div.setPersonName(pbo.getName());
					div.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
							.getName());
					div.setPostName(PostTool.getPostName(pbo.getPostId()));
					divList.set(i, div);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
		if (super.getRequestParameter("objId") != null) {
			objId = super.getRequestParameter("objId");
		}
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		queryDiv();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public List getDivList() {
		return divList;
	}

	public void setDivList(List divList) {
		this.divList = divList;
	}

	public String getDivId() {
		return divId;
	}

	public void setDivId(String divId) {
		this.divId = divId;
	}

	// 增加分解人员
	private String initEdit;
	private String personIds;
	private String personNames;
	private String weight;

	public String selPerson() {
		PersonBO pbos[] = (PersonBO[]) super
				.getHttpSession().getAttribute(Constants.SELPERSON_SESSION);
		String names = "";
		String ids = "";
		if (pbos != null && pbos.length > 0) {
			for (int i = 0; i < pbos.length; i++) {
				if(names.equals("")){
				    names +=  pbos[i].getName();
					ids +=  pbos[i].getPersonId();
				}else{
					names += "," + pbos[i].getName();
					ids += "," + pbos[i].getPersonId();
				}
			}

		}
		personNames = names;
		personIds = ids;
		return "";
	}

	public String saveDiv() {
		try {
			XysKpiDeptObjBO obj = this.xysKpiDeptUCC
					.findXysKpiDeptObjBOById(objId);
			if (personIds != null && !personIds.equals("")) {
				String ids[] = personIds.split(",");
				for (int i = 0; i < ids.length; i++) {
					XysDeptKpiDivBO bo = this.xysKpiDeptUCC
							.findEqualsXysDeptKpiDivBO(planId, ids[i]);
					if (bo == null) {
						bo = new XysDeptKpiDivBO();
						bo.setDeptKpiScore(obj.getScore());
						bo.setWeight(weight);
						bo.setObjId(objId);
						bo.setPlanId(obj.getPlanId());
						bo.setPersonId(ids[i]);
						xysKpiDeptUCC.saveXysDeptKpiDivBO(bo);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String getInitEdit() {
		try {
			if (super.getRequestParameter("objId") != null) {
				objId = super.getRequestParameter("objId");
				XysKpiDeptObjBO obj = this.xysKpiDeptUCC
						.findXysKpiDeptObjBOById(objId);
				planId = obj.getPlanId();
				weight = "";
				personIds = "";
				personNames = "";
				super.getHttpSession().setAttribute(Constants.SELPERSON_SESSION, null);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return initEdit;
	}

	public void setInitEdit(String initEdit) {
		this.initEdit = initEdit;
	}

	public String getPersonIds() {
		return personIds;
	}

	public void setPersonIds(String personIds) {
		this.personIds = personIds;
	}

	public String getPersonNames() {
		return personNames;
	}

	public void setPersonNames(String personNames) {
		this.personNames = personNames;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

}
