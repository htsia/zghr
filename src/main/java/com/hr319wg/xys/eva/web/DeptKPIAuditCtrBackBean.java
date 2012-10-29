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
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptSbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;
import com.hr319wg.xys.eva.pojo.vo.XysKpiDeptObjVO;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;

/**
 * Created by IntelliJ IDEA. User: Administrator Date: 12-6-11 Time: 上午9:22 To
 * change this template use File | Settings | File Templates.
 */
public class DeptKPIAuditCtrBackBean extends BaseBackingBean {
	// 查看计划
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private String pageInit;
	private PageVO mypage = new PageVO();
	private List planList;
	private IEvaGradeUCC evaGradeUCC;
	private String planId;
	private boolean selectAll = false;
	private IXysKpiDeptUCC xysKpiDeptUCC;

	// 开始打分
	public String beginGrade() {
		try {
			List objList = xysKpiDeptUCC.getXysKpiDeptObjBO(null, planId, null);
			if (objList != null && objList.size() > 0) {
				String result = xysKpiDeptUCC.beginGradeByPlanId(planId);
				super.showMessageDetail(result);
			} else {
				super.showMessageDetail("没有设置考核客体无法执行开启打分操作！");
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
			bo.setDeptKpiStatus("2");
			xysEvaPlanUCC.saveXysEvaPlanBO(bo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public IXysKpiDeptUCC getXysKpiDeptUCC() {
		return xysKpiDeptUCC;
	}

	public void setXysKpiDeptUCC(IXysKpiDeptUCC xysKpiDeptUCC) {
		this.xysKpiDeptUCC = xysKpiDeptUCC;
	}

	public void queryAll(ValueChangeEvent event) {
		selectAll = "true".equals(event.getNewValue().toString());
		doQuery();
	}

	public boolean isSelectAll() {
		return selectAll;
	}

	public void setSelectAll(boolean selectAll) {
		this.selectAll = selectAll;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
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

	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}

	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
	}

	// 查看分数
	private String initQry;
	private List objList;

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
				XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				objList = xysKpiDeptUCC.getXysKpiDeptObjBO(mypage, planId, null);
				if (objList != null && objList.size() > 0) {
					for (int i = 0; i < objList.size(); i++) {
						XysKpiDeptObjBO obj = (XysKpiDeptObjBO) objList.get(i);
						PersonBO pbo = SysCacheTool.findPersonById(obj
								.getPersonId());
						obj.setPlanName(bo.getPlanName());
						obj.setYear(bo.getYear());
						obj.setPersonName(pbo.getName());
						obj.setDeptName(SysCacheTool.findOrgById(obj.getDeptId())
								.getName());
						obj.setPostName(PostTool.getPostName(pbo.getPostId()));
						List sbjList = xysKpiDeptUCC.getXysKpiDeptSbjBOByObjId(obj
								.getObjId()); 
						int sbjSize=sbjList.size();
						int sign = 0;
						if (sbjList != null && sbjSize > 0) {
							for (int j = 0; j <sbjSize; j++) {
								XysKpiDeptSbjBO sbj = (XysKpiDeptSbjBO) sbjList
										.get(j);
								if (sbj.getScore() != null
										&& !sbj.getScore().equals("")) {
									sign++;
								}
							}
						}
						obj.setAllCount(String.valueOf(sbjSize));
						obj.setSignCount(String.valueOf(sign));
						obj.setNoSignCount(String.valueOf(sbjSize- sign));
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

	public String getObjId() {
		return objId;
	}

	public void setObjId(String objId) {
		this.objId = objId;
	}

	public void querySbj() {
		try {
			sbjList = xysKpiDeptUCC.getXysKpiDeptSbjBOByObjId(objId);
			if (sbjList != null && sbjList.size() > 0) {
				for (int i = 0; i < sbjList.size(); i++) {
					XysKpiDeptSbjBO sbj = (XysKpiDeptSbjBO) sbjList.get(i);
					PersonBO pbo = SysCacheTool.findPersonById(sbj
							.getPersonId());
					sbj.setPersonName(pbo.getName());
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
	private String initDataCtrObj;
	private List dataCtrObjList;

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

	public void queryDataCtr() {
		try {
			if (mypage.getCurrentPage() == 0) {
				mypage.setCurrentPage(1);
			}
			mypage.setPageSize(30);
			dataCtrObjList = this.xysKpiDeptUCC.getXysKpiDeptObjVO(mypage,
					planId);
			int size = dataCtrObjList.size();
			if (dataCtrObjList != null && size > 0) {
				for (int i = 0; i < size; i++) {
					XysKpiDeptObjVO vo = (XysKpiDeptObjVO) dataCtrObjList
							.get(i);
					PersonBO pbo = SysCacheTool
							.findPersonById(vo.getPersonId());
					vo.setPersonId(pbo.getName());
					vo.setDeptId(SysCacheTool.findOrgById(vo.getDeptId())
							.getName());
					vo.setPostId(PostTool.getPostName(vo.getPostId()));
					if ((vo.getWeightLeader() == null || vo.getWeightLeader()
							.equals(""))
							&& (vo.getWeightPreLeader() == null || vo
									.getWeightPreLeader().equals(""))
							&& (vo.getWeightOtherLeader() == null || vo
									.getWeightOtherLeader().equals(""))) {
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
							List prelist=this.xysKpiDeptUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_PRE_LEADER);
							int preSbjSize=prelist.size();
							if(prelist!=null&&preSbjSize>0){
								for(int j=0;j<preSbjSize;j++){
									XysKpiDeptSbjBO sbj=(XysKpiDeptSbjBO)prelist.get(j);
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
							List zjlist=this.xysKpiDeptUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_LEADER);
							int zjSbjSize=zjlist.size();
							if(zjlist!=null&&zjSbjSize>0){
								for(int j=0;j<zjSbjSize;j++){
									XysKpiDeptSbjBO sbj=(XysKpiDeptSbjBO)zjlist.get(j);
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
							List otherlist=this.xysKpiDeptUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_OTHER_LEADER);
							int otherSbjSize=otherlist.size();
							if(otherlist!=null&&otherSbjSize>0){
								for(int j=0;j<otherSbjSize;j++){
									XysKpiDeptSbjBO sbj=(XysKpiDeptSbjBO)otherlist.get(j);
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
								List prelist=this.xysKpiDeptUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_PRE_LEADER);
								int preSbjSize=prelist.size();
								if(prelist!=null&&preSbjSize>0){
									for(int j=0;j<preSbjSize;j++){
										XysKpiDeptSbjBO sbj=(XysKpiDeptSbjBO)prelist.get(j);
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
								List zjlist=this.xysKpiDeptUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_LEADER);
								int zjSbjSize=zjlist.size();
								if(zjlist!=null&&zjSbjSize>0){
									for(int j=0;j<zjSbjSize;j++){
										XysKpiDeptSbjBO sbj=(XysKpiDeptSbjBO)zjlist.get(j);
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
								List otherlist=this.xysKpiDeptUCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_OTHER_LEADER);
								int otherSbjSize=otherlist.size();
								if(otherlist!=null&&otherSbjSize>0){
									for(int j=0;j<otherSbjSize;j++){
										XysKpiDeptSbjBO sbj=(XysKpiDeptSbjBO)otherlist.get(j);
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getInitDataCtrObj() {
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
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
	//查看打分情况
	private String initDataInfo;
	private String level;
	
	public void queryDataInfo(){
		try{
			XysKpiDeptObjBO obj=this.xysKpiDeptUCC.findXysKpiDeptObjBOById(objId);
			PersonBO pbo1=SysCacheTool.findPersonById(obj.getPersonId());
			sbjList = xysKpiDeptUCC.checkSbjGradeData(objId,level);
			if (sbjList != null && sbjList.size() > 0) {
				for (int i = 0; i < sbjList.size(); i++) {
					XysKpiDeptSbjBO sbj = (XysKpiDeptSbjBO) sbjList.get(i);
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
