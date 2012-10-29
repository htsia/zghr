package com.hr319wg.xys.eva.web;

import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjScoreBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360SbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysBeginGradeErrorBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjScoreBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonScoreBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightExcPersBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;
import com.hr319wg.xys.eva.ucc.IXys360UCC;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC;

public class XysBeginGradeErrorMgrBackBean extends BaseBackingBean {
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private IXys360UCC xys360UCC;
	private IXysKpiDeptUCC xysKpiDeptUCC;
    private IXysKpiPersonUCC xysKpiPersonUCC;
    private String pageInit;
    private String planId;
    private List errorList;
    private String errorId;
    private String objType;
    private PageVO mypage=new PageVO();
    private String objId;
    
    public String beginAgain(){
    	try{
    		XysBeginGradeErrorBO bo=xysEvaPlanUCC.findXysBeginGradeErrorBO(errorId);
    		if(objType!=null&&!objType.equals("")&&objId==null&&objId.equals("")){
    			if(objType.equals("1")){//部门KPI考核
    				boolean flage=true;
    	    		String error="";
    				XysKpiDeptObjBO obj =xysKpiDeptUCC.findXysKpiDeptObjBOById(objId) ;
					PersonBO pbo1 = SysCacheTool.findPersonById(obj.getPersonId());
					OrgBO org = SysCacheTool.findOrgById(pbo1.getDeptId());
					if(!obj.getKeyStatus().equals("3")){
						flage=false;
						error+=org.getName() + "[" + pbo1.getName()+ "]的指标未通过审批！   ";
					}
					List weightList = xysEvaPlanUCC.getXysWeightSetBO(bo.getPlanId(),pbo1.getPostId(),XysWeightSetBO.TYPE_KPI);// 考核该岗位的设置
					if (weightList == null || weightList.size() <= 0) {
						flage=false;
						error+=org.getName() + "[" + pbo1.getName()+ "]未设置KPI考岗位和主体！  ";
					}
					List keyList = xysKpiDeptUCC.getXysKpiObjKeyBOByObjId(obj.getObjId());// 取得所有指标
					if(keyList==null||keyList.size()<=0){
						flage=false;
						error+=org.getName() + "[" + pbo1.getName()+ "]未设置KPI考核指标！";
					}
					if(!flage){
						bo.setError(error);
						xysEvaPlanUCC.saveXysBeginGradeErrorBO(bo);
					}else{
						List sbjList = xysKpiDeptUCC.getXysKpiDeptSbjBOByObjId(obj
								.getObjId());
						if (sbjList == null || sbjList.size() <= 0) {
							if (weightList != null && weightList.size() > 0) {
								for (int j = 0; j < weightList.size(); j++) {
									XysWeightSetBO set = (XysWeightSetBO) weightList
											.get(j);
									List pList = xysKpiDeptUCC
											.getPersonIdsByPostId(set
													.getEvaPostId());// 取得这个岗位下所有人
									if (pList != null && pList.size() > 0) {
										for (int m = 0; m < pList.size(); m++) {
											String pid = (String) pList.get(m);
											XysKpiDeptSbjBO sbj = xysKpiDeptUCC
													.findEqualsXysKpiDeptSbjBO(
															obj.getObjId(), pid);
											XysWeightExcPersBO pers = xysEvaPlanUCC
													.findEqualsXysWeightExcPersBO(
															set.getSetId(), pid);
											if (!pid.equals(obj.getPersonId())
													&& null == sbj && null == pers) {// 不是被考核人本人以及未加入的人员
												sbj = new XysKpiDeptSbjBO(); // 创建主体
												sbj.setObjId(obj.getObjId());
												sbj.setPersonId(pid);
												xysKpiDeptUCC
														.saveXysKpiDeptSbjBO(sbj);
												if (keyList != null
														&& keyList.size() > 0) {// 分数表
													for (int n = 0; n < keyList
															.size(); n++) {
														XysKpiObjKeyBO key = (XysKpiObjKeyBO) keyList
																.get(n);
														XysKpiDeptObjScoreBO score = new XysKpiDeptObjScoreBO();
														score.setObjId(obj
																.getObjId());
														score.setSbjId(sbj
																.getSbjId());
														score.setObjKeyId(key
																.getObjKeyId());
														xysKpiDeptUCC
																.saveXysKpiDeptObjScoreBO(score);
													}
												}
											}
										}
									}
								}
							}
						}
						obj.setGradeStatus("0");
						xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);
						xysEvaPlanUCC.deleteXysBeginGradeErrorBO(errorId);
					}
    			}
    			if(objType.equals("2")){//人员KPI
    				boolean flage=true;
    	    		String error="";
    	    		XysKpiPersonObjBO obj =this.xysKpiPersonUCC.findXysKpiPersonObjBOById(objId);
					PersonBO pbo1 = SysCacheTool.findPersonById(obj.getPersonId());
					OrgBO org = SysCacheTool.findOrgById(pbo1.getDeptId());
					if(!obj.getKeyStatus().equals("3")){
						error+=org.getName() + "[" + pbo1.getName()+ "]的指标未通过审批！  ";;
						flage=false;
					}
					List weightList = xysEvaPlanUCC.getXysWeightSetBO(bo.getPlanId(),pbo1.getPostId(),XysWeightSetBO.TYPE_KPI);// 考核该岗位的设置
					if (weightList == null || weightList.size() <= 0) {
						error+=org.getName() + "[" + pbo1.getName()+ "]未设置KPI考岗位和主体！  ";
						flage=false;
					}
					List keyList = xysKpiDeptUCC.getXysKpiObjKeyBOByObjId(obj.getObjId());// 取得所有指标
					if(keyList==null||keyList.size()<=0){
						error+=org.getName() + "[" + pbo1.getName()+ "]未设置KPI考核指标！   ";
						flage=false;
					}
					if(!flage){
						bo.setError(error);
						xysEvaPlanUCC.saveXysBeginGradeErrorBO(bo);
					}else{
						List sbjList = xysKpiPersonUCC.getXysKpiPersonSbjBOByObjId(obj.getObjId());
						if (sbjList == null || sbjList.size() <= 0) {
							
							if (weightList != null && weightList.size() > 0) {
								for (int j = 0; j < weightList.size(); j++) {
									XysWeightSetBO set = (XysWeightSetBO) weightList
											.get(j);
									List pList = xysKpiDeptUCC.getPersonIdsByPostId(set.getEvaPostId());// 取得这个岗位下所有人
									if (pList != null && pList.size() > 0) {
										for (int m = 0; m < pList.size(); m++) {
											String pid = (String) pList.get(m);
											XysKpiPersonSbjBO sbj = xysKpiPersonUCC
													.findEqualsXysKpiPersonSbjBO(
															obj.getObjId(), pid);
											XysWeightExcPersBO pers = xysEvaPlanUCC
													.findEqualsXysWeightExcPersBO(
															set.getSetId(), pid);
											if (!pid.equals(obj.getPersonId())
													&& null == sbj && null == pers) {// 没有加入的非本人，以及未排除的
												sbj = new XysKpiPersonSbjBO(); // 创建主体
												sbj.setObjId(obj.getObjId());
												sbj.setPersonId(pid);
												xysKpiPersonUCC.saveXysKpiPersonSbjBO(sbj);
												if (keyList != null
														&& keyList.size() > 0) {// 分数表
													for (int n = 0; n < keyList
															.size(); n++) {
														XysKpiObjKeyBO key = (XysKpiObjKeyBO) keyList
																.get(n);
														XysKpiPersonScoreBO score = new XysKpiPersonScoreBO();
														score.setObjId(obj
																.getObjId());
														score.setSbjId(sbj
																.getSbjId());
														score.setObjKeyId(key
																.getObjKeyId());
														xysKpiPersonUCC
																.saveXysKpiPersonScoreBO(score);
													}
												}
											}
										}
									}
								}
							}
						}
						obj.setGradeStatus("0");
						xysKpiPersonUCC.saveXysKpiPersonObjBO(obj);
						xysEvaPlanUCC.deleteXysBeginGradeErrorBO(errorId);
					}
    			}
    			if(objType.equals("3")){//360
    				boolean flage=true;
    	    		String error="";
    	    		Xys360ObjBO obj = xys360UCC.findXys360ObjBOById(objId);
					PersonBO pbo = SysCacheTool.findPersonById(obj
							.getPersonId());
					OrgBO org = SysCacheTool.findOrgById(pbo.getDeptId());
					if (obj.getTemplateId() == null
							|| obj.getTemplateId().equals("")) {
						error+=org.getName() + "[" + pbo.getName()+ "]未设置打分模版  !";
						flage = false;
					}
					List weightList = xysEvaPlanUCC.getXysWeightSetBO(bo.getPlanId(),
							pbo.getPostId(),XysWeightSetBO.TYPE_360 );// 考核该岗位的设置
					if (weightList == null || weightList.size() <= 0) {
						error+=org.getName() + "[" + pbo.getName()+ "]未设置考岗位核主体！ ";
						flage = false;
					}
					List keyList = xys360UCC.getXys360ObjKeyBOByObjId(obj.getObjId());// 取得所有指标
					if(keyList==null||keyList.size()<=0){
						error+=org.getName() + "[" + pbo.getName()+ "]未设置360考核指标！ ";
						flage = false;
					}
					if(!flage){
						bo.setError(error);
						xysEvaPlanUCC.saveXysBeginGradeErrorBO(bo);
					}else{
						List sbjList = this.xys360UCC.getXys360SbjBOByObjId(obj
								.getObjId());
						if (sbjList == null || sbjList.size() <= 0) {
							if (weightList != null && weightList.size() > 0) {
								for (int j = 0; j < weightList.size(); j++) {
									XysWeightSetBO set = (XysWeightSetBO) weightList
											.get(j);
									List pList = xys360UCC.getPersonIdsByPostId(set
											.getEvaPostId());// 取得这个岗位下所有人
									if (pList != null && pList.size() > 0) {
										for (int m = 0; m < pList.size(); m++) {
											String pid = (String) pList.get(m);
											Xys360SbjBO sbj = this.xys360UCC
													.findEqualsXys360SbjBO(
															obj.getObjId(), pid);
											XysWeightExcPersBO pers = xysEvaPlanUCC
													.findEqualsXysWeightExcPersBO(
															set.getSetId(), pid);
											if (!pid.equals(obj.getPersonId())
													&& null == sbj && null == pers) {// 不是被考核人本人以及未加入的人员
												sbj = new Xys360SbjBO();
												sbj.setObjId(obj.getObjId());
												sbj.setPersonId(pid);
												xys360UCC.saveXys360SbjBO(sbj);
												if (keyList != null
														&& keyList.size() > 0) {// 分数表
													for (int n = 0; n < keyList
															.size(); n++) {
														Xys360ObjKeyBO key = (Xys360ObjKeyBO) keyList
																.get(n);
														Xys360ObjScoreBO score = new Xys360ObjScoreBO();
														score.setKeyId(key
																.getKeyId());
														score.setObjId(obj
																.getObjId());
														score.setSbjId(sbj
																.getSbjId());
														xys360UCC
																.saveXys360ObjScoreBO(score);
													}
												}
											}
										}
									}
								}
							}
						}
						obj.setGradeStatus("0");
						xys360UCC.saveXys360ObjBO(obj);
						xysEvaPlanUCC.deleteXysBeginGradeErrorBO(errorId);
					}
    			}
    		}
    		super.showMessageDetail("操作成功！");
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return "";
    }
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
	}
	public PageVO getMypage() {
		return mypage;
	}
	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}
	public String getObjType() {
		return objType;
	}
	public void setObjType(String objType) {
		this.objType = objType;
	}
	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}
	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
	}
	public IXys360UCC getXys360UCC() {
		return xys360UCC;
	}
	public void setXys360UCC(IXys360UCC xys360ucc) {
		xys360UCC = xys360ucc;
	}
	public IXysKpiDeptUCC getXysKpiDeptUCC() {
		return xysKpiDeptUCC;
	}
	public void setXysKpiDeptUCC(IXysKpiDeptUCC xysKpiDeptUCC) {
		this.xysKpiDeptUCC = xysKpiDeptUCC;
	}
	public IXysKpiPersonUCC getXysKpiPersonUCC() {
		return xysKpiPersonUCC;
	}
	public void setXysKpiPersonUCC(IXysKpiPersonUCC xysKpiPersonUCC) {
		this.xysKpiPersonUCC = xysKpiPersonUCC;
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

	public void doQuery(){
		try{
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			errorList=xysEvaPlanUCC.getXysBeginGradeErrorBO(mypage, planId, objType);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getPageInit() {
		if(super.getRequestParameter("objType")!=null){
			objType=super.getRequestParameter("objType");
		}
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		doQuery();
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
	public List getErrorList() {
		return errorList;
	}
	public void setErrorList(List errorList) {
		this.errorList = errorList;
	}
	public String getErrorId() {
		return errorId;
	}
	public void setErrorId(String errorId) {
		this.errorId = errorId;
	}
    
    
}
