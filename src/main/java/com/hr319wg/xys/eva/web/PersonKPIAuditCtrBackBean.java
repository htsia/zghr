package com.hr319wg.xys.eva.web;

import java.util.List;

import javax.faces.event.ValueChangeEvent;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;
import com.hr319wg.xys.eva.pojo.vo.XysKpiPersonObjVO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC;

public class PersonKPIAuditCtrBackBean extends BaseBackingBean {
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private String pageInit;
	private PageVO mypage = new PageVO();
	private List planList;
	private IEvaGradeUCC evaGradeUCC;
	private String planId;
	private boolean selectAll = false;
	private IXysKpiDeptUCC xysKpiDeptUCC;
	private IXysKpiPersonUCC xysKpiPersonUCC;

	// 开始打分
	public String beginGrade() {
		try {
			List objList = xysKpiPersonUCC.getXysKpiPersonObjBO(null, planId,null);
			if(objList!=null&&objList.size()>0){
				String returnValue=xysKpiPersonUCC.beginGradeByPlanId(planId);
				super.showMessageDetail(returnValue);
			}else{
				super.showMessageDetail("没有考核客体无法开启打分！");
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	// 结束打分
	public String endGrade() {
		try {
			XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
			bo.setPersonKpiStatus("2");
			xysEvaPlanUCC.saveXysEvaPlanBO(bo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public void queryAll(ValueChangeEvent event) {
		selectAll = "true".equals(event.getNewValue().toString());
		doQuery();
	}

	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}

	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
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

	public void doQuery() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			if (selectAll) {
				planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage, super
						.getUserInfo().getOrgId(), null);
			} else {
				planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage, super
						.getUserInfo().getOrgId(),
						new String[] { XysEvaPlanBO.STATUS_ZHIXING });
			}
			if (planList != null && planList.size() > 0) {
				for (int i = 0; i < planList.size(); i++) {
					XysEvaPlanBO bo = (XysEvaPlanBO) planList.get(i);
					EvaGradeBO grade = evaGradeUCC.getGradeByID(bo
							.getPlanGrade());
					bo.setPlanGrade(grade.getGradeName());
					bo.setPlanType(CodeUtil.interpertCode(bo.getPlanType()));
					planList.set(i, bo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public PageVO getMypage() {
		return mypage;
	}

	public void setMypage(PageVO mypage) {
		this.mypage = mypage;
	}

	public List getPlanList() {
		return planList;
	}

	public void setPlanList(List planList) {
		this.planList = planList;
	}

	public IEvaGradeUCC getEvaGradeUCC() {
		return evaGradeUCC;
	}

	public void setEvaGradeUCC(IEvaGradeUCC evaGradeUCC) {
		this.evaGradeUCC = evaGradeUCC;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public boolean isSelectAll() {
		return selectAll;
	}

	public void setSelectAll(boolean selectAll) {
		this.selectAll = selectAll;
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

	// 查看分数
	private String initQry;
	private List objList;
	private String superId;
	private String initIndex;
	private String queryValue;
	
	
	public String getQueryValue() {
		return queryValue;
	}

	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}

	public String getInitIndex() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		return initIndex;
	}

	public void setInitIndex(String initIndex) {
		this.initIndex = initIndex;
	}

	public String getSuperId() {
		return superId;
	}

	public void setSuperId(String superId) {
		this.superId = superId;
	}

	public String first1() {
		mypage.setCurrentPage(1);
		queryObj();
		return "";
	}

	public String pre1() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryObj();
		return "";
	}

	public String next1() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryObj();
		return "";
	}

	public String last1() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryObj();
		return "";
	}

	public void queryObj() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			mypage.setPageSize(20);
			if(planId!=null&&!planId.equals("")){
				if(superId==null||superId.equals("")){
					superId=super.getUserInfo().getDeptId();
				}
				if(queryValue!=null&&!queryValue.equals("")){
					String where = " and bo.personId in(select po.personId from PersonBO po "
							+ "where po.name like '%"
							+ queryValue
							+ "%' or po.shortName like '%"
							+ queryValue
							+ "%' or po.personCode like '%" + queryValue + "%')";
					objList = xysKpiPersonUCC.getXysKpiPersonObjBOByQueryValue(
							mypage, planId, where);
				}else{
					objList = xysKpiPersonUCC.getXysKpiPersonObjBO(mypage, planId,superId);
				}
				if (objList != null && objList.size() > 0) {
					for (int i = 0; i < objList.size(); i++) {
						XysKpiPersonObjBO obj = (XysKpiPersonObjBO) objList.get(i);
						PersonBO pbo = SysCacheTool.findPersonById(obj
								.getPersonId());
						obj.setPersonName(pbo.getName());
						obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
								.getName());
						obj.setPostName(PostTool.getPostName(pbo.getPostId()));
						List sbjList = xysKpiPersonUCC.getXysKpiPersonSbjBOByObjId(obj
								.getObjId());
						int sbjSize=sbjList.size();
						int sign = 0;
						if (sbjList != null && sbjSize > 0) {
							for (int j = 0; j <sbjSize; j++) {
								XysKpiPersonSbjBO sbj = (XysKpiPersonSbjBO) sbjList
										.get(j);
								if (sbj.getScore() != null
										&& !sbj.getScore().equals("")) {
									sign++;
								}
							}
						}
						obj.setAllCount(String.valueOf(sbjSize));
						obj.setSignCount(String.valueOf(sign));
						obj.setNoSignCount(String.valueOf(sbjList.size() - sign));
						objList.set(i, obj);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getInitQry() {
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		if(super.getRequestParameter("superId")!=null){
			superId=super.getRequestParameter("superId");
		}
		queryObj();
		return initQry;
	}

	public void setInitQry(String initQry) {
		this.initQry = initQry;
	}

	public List getObjList() {
		return objList;
	}

	public void setObjList(List objList) {
		this.objList = objList;
	}

	// 查看打分详情
	private String initQryInfo;
	private List sbjList;
	private String objId;
	private String sbjId;
	
	public void deleteSbj(){
		try{
			List sList=this.xysKpiPersonUCC.getXysKpiPersonScoreBOBySbjId(sbjId);
			if(sList!=null&&sList.size()>0){
				xysKpiPersonUCC.deleteAll(sList);
			}
			xysKpiPersonUCC.deleteXysKpiPersonSbjBO(sbjId);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getSbjId() {
		return sbjId;
	}

	public void setSbjId(String sbjId) {
		this.sbjId = sbjId;
	}

	public String getObjId() {
		return objId;
	}

	public void setObjId(String objId) {
		this.objId = objId;
	}

	public void querySbj() {
		try {
			sbjList = xysKpiPersonUCC.getXysKpiPersonSbjBOByObjId(objId);
			if (sbjList != null && sbjList.size() > 0) {
				for (int i = 0; i < sbjList.size(); i++) {
					XysKpiPersonSbjBO sbj = (XysKpiPersonSbjBO) sbjList.get(i);
					PersonBO pbo = SysCacheTool.findPersonById(sbj
							.getPersonId());
					sbj.setPersonName(pbo.getName());
					sbj.setPersonCode(pbo.getPersonCode());
					sbj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
							.getName());
					sbj.setPostName(PostTool.getPostName(pbo.getPostId()));
					if (sbj.getScore() != null && !sbj.getScore().equals("")) {
						sbj.setIsSign("是");
					} else {
						sbj.setIsSign("否");
					}
					sbjList.set(i, sbj);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getInitQryInfo() {
		if (super.getRequestParameter("objId") != null) {
			objId = super.getRequestParameter("objId");
		}
		querySbj();
		return initQryInfo;
	}

	public void setInitQryInfo(String initQryInfo) {
		this.initQryInfo = initQryInfo;
	}

	public List getSbjList() {
		return sbjList;
	}

	public void setSbjList(List sbjList) {
		this.sbjList = sbjList;
	}
	//数据合法性监控
	private String initDataCtr;
	private String initDataCtrObj;
	private List dataCtrObjList;

	public String getInitDataCtr() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		if(super.getRequestParameter("superId")!=null){
			superId=super.getRequestParameter("superId");
		}
		return initDataCtr;
	}

	public void setInitDataCtr(String initDataCtr) {
		this.initDataCtr = initDataCtr;
	}
	
	public String first2() {
		mypage.setCurrentPage(1);
		queryDataCtr();
		return "";
	}

	public String pre2() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryDataCtr();
		return "";
	}

	public String next2() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryDataCtr();
		return "";
	}

	public String last2() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryDataCtr();
		return "";
	}
	public void queryDataCtr(){
		try{
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			if(superId==null||superId.equals("")){
				superId=super.getUserInfo().getDeptId();
			}
			mypage.setPageSize(10);
			if(queryValue!=null&&!queryValue.equals("")){
				String where = " and bo.personId in(select po.personId from PersonBO po "
						+ "where po.name like '%"
						+ queryValue
						+ "%' or po.shortName like '%"
						+ queryValue
						+ "%' or po.personCode like '%" + queryValue + "%')";
				dataCtrObjList=this.xysKpiPersonUCC.getXysKpiPersonObjVOByQueryValue(mypage, planId, where);
			}else{
				dataCtrObjList=this.xysKpiPersonUCC.getXysKpiPersonObjVO(mypage, planId, superId);
			}
			int size=dataCtrObjList.size();
			if(dataCtrObjList!=null&&size>0){
				for(int i=0;i<size;i++){
					XysKpiPersonObjVO vo=(XysKpiPersonObjVO)dataCtrObjList.get(i);
					PersonBO pbo=SysCacheTool.findPersonById(vo.getPersonId());
					vo.setPersonId(pbo.getName());
					vo.setDeptId(SysCacheTool.findOrgById(vo.getDeptId()).getName());
					vo.setPostId(PostTool.getPostName(vo.getPostId()));
					if((vo.getWeightLeader()==null||vo.getWeightLeader().equals(""))
						&&(vo.getWeightPreLeader()==null||vo.getWeightPreLeader().equals(""))
						&&(vo.getWeightOtherLeader()==null||vo.getWeightOtherLeader().equals(""))){
						vo.setErrorDes("<font color='red'>未设置KPI层次权重</font>");
						continue;
					}
					if(vo.getGradeType()!=null&&!vo.getGradeType().equals("")){
						if(vo.getGradeType().equals("1")){//合并
					
							boolean flag=false;//默认不合法
							int preCount=0;//上上级打分人数
							int zjCount=0;//直接上级打分人数
							int otherCount=0;//其他上级打分人数
							
							//上上级
							List prelist=this.xysKpiPersonUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_PRE_LEADER);
							int preSbjSize=prelist.size();
							if(prelist!=null&&preSbjSize>0){
								for(int j=0;j<preSbjSize;j++){
									XysKpiPersonSbjBO sbj=(XysKpiPersonSbjBO)prelist.get(j);
									if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
										preCount++;
										flag=true;
									}
								}
								vo.setWeightPreLeader(preSbjSize+"/"+preCount);
							}else{
								vo.setWeightPreLeader("0/0");
							}
							//直接上级
							List zjlist=this.xysKpiPersonUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_LEADER);
							int zjSbjSize=zjlist.size();
							if(zjlist!=null&&zjSbjSize>0){
								for(int j=0;j<zjSbjSize;j++){
									XysKpiPersonSbjBO sbj=(XysKpiPersonSbjBO)zjlist.get(j);
									if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
										zjCount++;
										flag=true;
									}
								}
								vo.setWeightLeader(zjSbjSize+"/"+zjCount);
							}else{
								vo.setWeightLeader("0/0");
							}
							//其他上级
							List otherlist=this.xysKpiPersonUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_OTHER_LEADER);
							int otherSbjSize=otherlist.size();
							if(otherlist!=null&&otherSbjSize>0){
								for(int j=0;j<otherSbjSize;j++){
									XysKpiPersonSbjBO sbj=(XysKpiPersonSbjBO)otherlist.get(j);
									if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
										otherCount++;
										flag=true;
									}
								}
								vo.setWeightOtherLeader(otherSbjSize+"/"+otherCount);
							}else{
								vo.setWeightOtherLeader("0/0");
							}
							if(!flag){
								vo.setErrorDes("<font color='red'>缺失打分分数</font>");
							}
						}else{//不合并
							boolean flag=true;//默认合法
							int preCount=0;//上上级打分人数
							int zjCount=0;//直接上级打分人数
							int otherCount=0;//其他上级打分人数
							
							//上上级
							if(vo.getWeightPreLeader()!=null&&!vo.getWeightPreLeader().equals("")&&!vo.getWeightPreLeader().equals("0")){
								List prelist=this.xysKpiPersonUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_PRE_LEADER);
								int preSbjSize=prelist.size();
								if(prelist!=null&&preSbjSize>0){
									for(int j=0;j<preSbjSize;j++){
										XysKpiPersonSbjBO sbj=(XysKpiPersonSbjBO)prelist.get(j);
										if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
											preCount++;
										}
									}
									vo.setWeightPreLeader(preSbjSize+"/"+preCount);
								}else{
									vo.setWeightPreLeader("0/0");
								}
								if(preCount==0){
									flag=false;
								}
							}
							//直接上级
							if(vo.getWeightLeader()!=null&&!vo.getWeightLeader().equals("")&&!vo.getWeightLeader().equals("0")){
								List zjlist=this.xysKpiPersonUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_LEADER);
								int zjSbjSize=zjlist.size();
								if(zjlist!=null&&zjSbjSize>0){
									for(int j=0;j<zjSbjSize;j++){
										XysKpiPersonSbjBO sbj=(XysKpiPersonSbjBO)zjlist.get(j);
										if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
											zjCount++;
										}
									}
									vo.setWeightLeader(zjSbjSize+"/"+zjCount);
								}else{
									vo.setWeightLeader("0/0");
								}
								if(zjCount==0){
									flag=false;
								}
							}
							//其他上级
							if(vo.getWeightOtherLeader()!=null&&!vo.getWeightOtherLeader().equals("")&&!vo.getWeightOtherLeader().equals("0")){
								List otherlist=this.xysKpiPersonUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_OTHER_LEADER);
								int otherSbjSize=otherlist.size();
								if(otherlist!=null&&otherSbjSize>0){
									for(int j=0;j<otherSbjSize;j++){
										XysKpiPersonSbjBO sbj=(XysKpiPersonSbjBO)otherlist.get(j);
										if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
											otherCount++;
										}
									}
									vo.setWeightOtherLeader(otherSbjSize+"/"+otherCount);
								}else{
									vo.setWeightOtherLeader("0/0");
								}
								if(otherCount==0){
									flag=false;
								}
							}
							if(!flag){
								vo.setErrorDes("<font color='red'>缺失打分分数</font>");
							}
						}
					}else{//未设置层次权重
						vo.setErrorDes("<font color='red'>未设置KPI层次权重</font>");
					}
					dataCtrObjList.set(i,vo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitDataCtrObj() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		if(super.getRequestParameter("superId")!=null){
			superId=super.getRequestParameter("superId");
		}
		queryDataCtr();
		return initDataCtrObj;
	}

	public void setInitDataCtrObj(String initDataCtrObj) {
		this.initDataCtrObj = initDataCtrObj;
	}

	public List getDataCtrObjList() {
		return dataCtrObjList;
	}

	public void setDataCtrObjList(List dataCtrObjList) {
		this.dataCtrObjList = dataCtrObjList;
	}
	//查看层次打分明细
	private String initDataInfo;
	private String level;
	
	public void queryDataInfo(){
		try{
			XysKpiPersonObjBO obj=this.xysKpiPersonUCC.findXysKpiPersonObjBOById(objId);
			PersonBO pbo1=SysCacheTool.findPersonById(obj.getPersonId());
			sbjList=this.xysKpiPersonUCC.checkSbjGradeData(objId,level);
			if(sbjList!=null&&sbjList.size()>0){
				for (int i = 0; i < sbjList.size(); i++) {
					XysKpiPersonSbjBO sbj = (XysKpiPersonSbjBO) sbjList.get(i);
					PersonBO pbo = SysCacheTool.findPersonById(sbj
							.getPersonId());
					sbj.setPersonName(pbo.getName());
					sbj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
							.getName());
					sbj.setPostName(PostTool.getPostName(sbj.getPostId()));
					if (sbj.getScore() != null && !sbj.getScore().equals("")) {
						sbj.setIsSign("是");
					} else {
						sbj.setIsSign("否");
					}
					sbjList.set(i, sbj);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitDataInfo() {
		if(super.getRequestParameter("objId")!=null){
			objId=super.getRequestParameter("objId");
		}
		if(super.getRequestParameter("level")!=null){
			level=super.getRequestParameter("level");
		}
		queryDataInfo();
		return initDataInfo;
	}

	public void setInitDataInfo(String initDataInfo) {
		this.initDataInfo = initDataInfo;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
	
}
