package com.hr319wg.xys.eva.web;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.faces.event.ValueChangeEvent;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.myfaces.custom.fileupload.UploadedFile;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.eva.pojo.bo.EvaGradeBO;
import com.hr319wg.eva.pojo.bo.EvaGradeItemBO;
import com.hr319wg.eva.ucc.IEvaGradeUCC;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysDeptKpiDivBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiDeptObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysKpiPersonObjBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadDeptSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysSpreadSetItemBO;
import com.hr319wg.xys.eva.ucc.IXys360UCC;
import com.hr319wg.xys.eva.ucc.IXysEvaObjUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiDeptUCC;
import com.hr319wg.xys.eva.ucc.IXysKpiPersonUCC;
import com.hr319wg.xys.eva.ucc.IXysSpreadMgrUCC;

public class XysEvaPlanCaclBackBean extends BaseBackingBean {
	 //查看计划
    private IXysEvaPlanUCC xysEvaPlanUCC;
    private String pageInit;
    private PageVO mypage = new PageVO();
    private List planList;
    private IEvaGradeUCC evaGradeUCC;
    private String planId;
    private boolean selectAll = false;
    
    public void auditResult(){
    	try{
    		XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
    		bo.setStatus(XysEvaPlanBO.STATUS_JGBP);
    		xysEvaPlanUCC.saveXysEvaPlanBO(bo);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
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
	            if(mypage.getCurrentPage()==0){
	               mypage.setCurrentPage(1);
	            }
	            if(selectAll){
	                planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage,super.getUserInfo().getOrgId(),null);
	            }else{
	                planList = xysEvaPlanUCC.getXysEvaPlanBO(mypage,super.getUserInfo().getOrgId(),new String[]{XysEvaPlanBO.STATUS_ZHIXING});
	            }
	            if(planList!=null&&planList.size()>0){
	                for(int i=0;i<planList.size();i++){
	                    XysEvaPlanBO bo=(XysEvaPlanBO)planList.get(i);
	                    EvaGradeBO grade=evaGradeUCC.getGradeByID(bo.getPlanGrade());
	                    bo.setPlanGrade(grade.getGradeName());
	                    bo.setPlanType(CodeUtil.interpertCode(bo.getPlanType()));
	                    planList.set(i,bo);
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
	
	
	//个人KPI计算
	private String initPersKpi;
	private IXysKpiPersonUCC xysKpiPersonUCC;
	private String superId;
	private String initPersKpiIndex;
	private List persKpiObjList;
	
	public void caclPersKpi(){
		try{
			xysKpiPersonUCC.caclPersonKpiByPlanId(planId);
			super.showMessageDetail("计算成功！");
		}catch(Exception e){
			super.showMessageDetail("计算失败！");
			e.printStackTrace();
		}
	}
	public List getPersKpiObjList() {
		return persKpiObjList;
	}
	public void setPersKpiObjList(List persKpiObjList) {
		this.persKpiObjList = persKpiObjList;
	}
	public String getInitPersKpiIndex() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
				XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				if(bo.getStatus().equals(XysEvaPlanBO.STATUS_ZHIXING)){
					this.deptDesabled="0";
				}else{
					this.deptDesabled="1";
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initPersKpiIndex;
	}
	public void setInitPersKpiIndex(String initPersKpiIndex) {
		this.initPersKpiIndex = initPersKpiIndex;
	}
	public String getSuperId() {
		return superId;
	}
	public void setSuperId(String superId) {
		this.superId = superId;
	}
	public String first1() {
		mypage.setCurrentPage(1);
		queryPersonKpi();
		return "";
	}

	public String pre1() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryPersonKpi();
		return "";
	}

	public String next1() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryPersonKpi();
		return "";
	}

	public String last1() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryPersonKpi();
		return "";
	}
	public void queryPersonKpi(){
		try{
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			if(planId!=null&&!planId.equals("")){
				if(superId==null||superId.equals("")){
					superId=super.getUserInfo().getDeptId();
				}
				
				if(queryValue!=null&&!queryValue.equals("")){
					String where=" and bo.personId in(select po.personId from PersonBO po " +
							   "where po.name like '%"+queryValue+"%' or po.shortName like '%"+queryValue+"%' or po.personCode like '%"+queryValue+"%')";
					persKpiObjList=this.xysKpiPersonUCC.getXysKpiPersonObjBOByQueryValue(mypage, planId, where);
				}else{
					persKpiObjList = xysKpiPersonUCC.getXysKpiPersonObjBO(mypage, planId,superId);
				}
				if (persKpiObjList != null && persKpiObjList.size() > 0) {
					for (int i = 0; i < persKpiObjList.size(); i++) {
						XysKpiPersonObjBO obj = (XysKpiPersonObjBO) persKpiObjList.get(i);
						PersonBO pbo = SysCacheTool.findPersonById(obj
								.getPersonId());
						obj.setPersonName(pbo.getName());
						obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
								.getName());
						obj.setPostName(PostTool.getPostName(pbo.getPostId()));
						if(obj.getScoreError()!=null&&obj.getScoreError().equals("1")){
							obj.setScore("<font color='red'>"+CommonFuns.filterNull(obj.getScore())+"</font>");
						}
						persKpiObjList.set(i, obj);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitPersKpi() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		if(super.getRequestParameter("superId")!=null){
			superId=super.getRequestParameter("superId");
		}
		queryPersonKpi();
		return initPersKpi;
	}
	public void setInitPersKpi(String initPersKpi) {
		this.initPersKpi = initPersKpi;
	}
	public IXysKpiPersonUCC getXysKpiPersonUCC() {
		return xysKpiPersonUCC;
	}
	public void setXysKpiPersonUCC(IXysKpiPersonUCC xysKpiPersonUCC) {
		this.xysKpiPersonUCC = xysKpiPersonUCC;
	}
	
	//个人360计算
	private IXys360UCC xys360UCC;
	private String initPers360Index;
	private String initPers360;
	private List pers360ObjList;

	public void caclPers360(){
		try{
			xys360UCC.caclPerson360ByPlanId(planId);
			super.showMessageDetail("计算成功！");
		}catch(Exception e){
			super.showMessageDetail("计算失败！");
			e.printStackTrace();
		}
	}
	public IXys360UCC getXys360UCC() {
		return xys360UCC;
	}
	public void setXys360UCC(IXys360UCC xys360ucc) {
		xys360UCC = xys360ucc;
	}
	public String getInitPers360Index() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
				XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				if(bo.getStatus().equals(XysEvaPlanBO.STATUS_ZHIXING)){
					this.deptDesabled="0";
				}else{
					this.deptDesabled="1";
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initPers360Index;
	}
	public void setInitPers360Index(String initPers360Index) {
		this.initPers360Index = initPers360Index;
	}
	public String first2() {
		mypage.setCurrentPage(1);
		queryPerson360();
		return "";
	}

	public String pre2() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryPerson360();
		return "";
	}

	public String next2() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryPerson360();
		return "";
	}

	public String last2() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryPerson360();
		return "";
	}
	
	public void queryPerson360(){
		try{
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			if(planId!=null&&!planId.equals("")){
				if(superId==null||superId.equals("")){
					superId=super.getUserInfo().getDeptId();
				}
				if(queryValue!=null&&!queryValue.equals("")){
					String where=" and bo.personId in(select po.personId from PersonBO po " +
							   "where po.name like '%"+queryValue+"%' or po.shortName like '%"+queryValue+"%' or po.personCode like '%"+queryValue+"%')";
					pers360ObjList=this.xys360UCC.getXys360ObjBOByQueryValue(mypage, planId, where);
				}else{
					pers360ObjList = xys360UCC.getXys360ObjBOByPlanId(mypage, planId,superId);
				}
				if (pers360ObjList != null && pers360ObjList.size() > 0) {
					for (int i = 0; i < pers360ObjList.size(); i++) {
						Xys360ObjBO obj = (Xys360ObjBO) pers360ObjList.get(i);
						PersonBO pbo = SysCacheTool.findPersonById(obj
								.getPersonId());
						obj.setPersonName(pbo.getName());
						obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
								.getName());
						obj.setPostName(PostTool.getPostName(pbo.getPostId()));
						if(obj.getScoreError()!=null&&obj.getScoreError().equals("1")){
							obj.setScore("<font color='red'>"+CommonFuns.filterNull(obj.getScore())+"</font>");
						}
						pers360ObjList.set(i, obj);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitPers360() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		if(super.getRequestParameter("superId")!=null){
			superId=super.getRequestParameter("superId");
		}
		queryPerson360();
		return initPers360;
	}
	public void setInitPers360(String initPers360) {
		this.initPers360 = initPers360;
	}
	public List getPers360ObjList() {
		return pers360ObjList;
	}
	public void setPers360ObjList(List pers360ObjList) {
		this.pers360ObjList = pers360ObjList;
	}
	//部门计算
	private String initDeptObj;
	private IXysKpiDeptUCC xysKpiDeptUCC;
	private List deptList;
	private IXysSpreadMgrUCC xysSpreadMgrUCC;
	private String deptDesabled;
	
	
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
	public void useSpread(){
		try{
			List list=this.xysKpiDeptUCC.getXysKpiDeptObjBO(null, planId, null);
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					XysKpiDeptObjBO obj=(XysKpiDeptObjBO)list.get(i);
					if(obj.getGradeItem()!=null&&!obj.getGradeItem().equals("")){
						List deptItemList=xysSpreadMgrUCC.getXysSpreadDeptSetBO(planId, obj.getDeptId());
						if(deptItemList==null||deptItemList.size()==0){
							XysSpreadSetBO setbo=xysSpreadMgrUCC.findEqualsXysSpreadSetBO(planId,obj.getGradeItem());
							List itemList=xysSpreadMgrUCC.getXysSpreadSetItemBOBySetId(setbo.getSetId());
							if(itemList!=null&&itemList.size()>0){
								for(int j=0;j<itemList.size();j++){
									XysSpreadSetItemBO item=(XysSpreadSetItemBO)itemList.get(j);
									XysSpreadDeptSetBO dept=new XysSpreadDeptSetBO();
									dept.setPlanId(planId);
									dept.setDeptId(obj.getDeptId());
									dept.setGradeItem(item.getGradeItem());
									dept.setCtrCount(item.getCtrCount());
									dept.setCtrType(item.getCtrType());
									dept.setChgGradeItem(item.getChgGradeItem());
									xysSpreadMgrUCC.saveXysSpreadDeptSetBO(dept);
								}
							}
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public void caclDept(){
		try{
			xysKpiDeptUCC.caclDeptKpiByPlanId(planId);
			XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
			List list=this.evaGradeUCC.getAllGradeItem(bo.getPlanGrade());
			List oList=this.xysKpiDeptUCC.getXysKpiDeptObjBO(null, planId, null);
			List setList=this.xysSpreadMgrUCC.getXysSpreadSetBOByPlanId(planId);
			if(oList!=null&&oList.size()>0){
				for(int i=0;i<oList.size();i++){
					XysKpiDeptObjBO obj=(XysKpiDeptObjBO)oList.get(i);
					List divList=this.xysKpiDeptUCC.getXysDeptKpiDivBOByObjId(obj.getObjId());
					if(divList!=null&&divList.size()>0){
							for(int j=0;j<divList.size();j++){
								XysDeptKpiDivBO div=(XysDeptKpiDivBO)divList.get(j);
								div.setDeptKpiScore(CommonFuns.filterNull(obj.getScore()));
								this.xysKpiDeptUCC.saveXysDeptKpiDivBO(div);
							}
					}
					if(obj.getScore()!=null&&!obj.getScore().equals("")){
						double score=Double.parseDouble(obj.getScore());
						if(list!=null&&list.size()>0){
							for(int j=0;j<list.size();j++){
								EvaGradeItemBO grade=(EvaGradeItemBO)list.get(j);
								double hiScore=Double.parseDouble(grade.getHighValue());
								double lowScore=Double.parseDouble(grade.getLowValue());
								if((score>=lowScore&&score<hiScore)||(hiScore==100&&score>=100)){
									obj.setGradeItem(grade.getItemID());
									obj.setScoreSort(String.valueOf(i+1));
									xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);
								}
							}
						}
					}
				}
			}
			if(setList!=null&&setList.size()>0){//强制分布
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaGradeItemBO grade=(EvaGradeItemBO)list.get(i);
						XysSpreadSetBO spread=this.xysSpreadMgrUCC.findEqualsXysSpreadSetBO(planId,grade.getItemID());
						if(spread!=null&&spread.getCtrCount()!=null&&!spread.getCtrCount().equals("")){
							List obList=this.xysKpiDeptUCC.getXysKpiDeptObjBO(planId,grade.getItemID());
							int ctrSize=0;
							if(spread.getCtrType().equals("1")){
								ctrSize=Integer.parseInt(spread.getCtrCount());
							}else{
								double size1=Math.round(oList.size()*Double.parseDouble(spread.getCtrCount())/100);
    							NumberFormat format=NumberFormat.getInstance();
    							format.setMaximumFractionDigits(0);
    							ctrSize=Integer.parseInt(String.valueOf(format.format(size1)));
							}
							if(ctrSize<=obList.size()){
								for(int j=0;j<obList.size();j++){
									XysKpiDeptObjBO obj=(XysKpiDeptObjBO)obList.get(j);
									if(j<ctrSize){
										continue;
									}else{
										obj.setGradeItem(spread.getChgGradeItem());
										xysKpiDeptUCC.saveXysKpiDeptObjBO(obj);
									}
								}
							}else{
								continue;
							}
						}
					}
				}
			}
			super.showMessageDetail("计算成功！");
		}catch(Exception e){
			super.showMessageDetail("计算失败！");
			e.printStackTrace();
		}
	}
	public String first3() {
		mypage.setCurrentPage(1);
		queryDept();
		return "";
	}

	public String pre3() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryDept();
		return "";
	}

	public String next3() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryDept();
		return "";
	}

	public String last3() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryDept();
		return "";
	}
	public void queryDept(){
		try{
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
			if(bo.getStatus().equals(XysEvaPlanBO.STATUS_ZHIXING)){
				this.deptDesabled="0";
			}else{
				this.deptDesabled="1";
			}
			List list=this.evaGradeUCC.getAllGradeItem(bo.getPlanGrade());
			Hashtable map=new Hashtable();
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					EvaGradeItemBO grade=(EvaGradeItemBO)list.get(i);
					map.put(grade.getItemID(), grade.getItemName());
				}
			}
			deptList= xysKpiDeptUCC.getXysKpiDeptObjBO(mypage, planId, null);
			if (deptList != null && deptList.size() > 0) {
				for (int i = 0; i < deptList.size(); i++) {
					XysKpiDeptObjBO obj = (XysKpiDeptObjBO) deptList.get(i);
					PersonBO pbo = SysCacheTool.findPersonById(obj
							.getPersonId());
					obj.setPlanName(bo.getPlanName());
					obj.setYear(bo.getYear());
					obj.setPersonName(pbo.getName());
					obj.setDeptName(SysCacheTool.findOrgById(obj.getDeptId())
							.getName());
					obj.setPostName(PostTool.getPostName(pbo.getPostId()));
					if(obj.getGradeItem()!=null&&!obj.getGradeItem().equals("")){
						obj.setGradeItem((String)map.get(obj.getGradeItem()));
					}
					if(obj.getScoreError()!=null&&obj.getScoreError().equals("1")){
						obj.setScore("<font color='red'>"+CommonFuns.filterNull(obj.getScore())+"</font>");
					}
					deptList.set(i, obj);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitDeptObj() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		queryDept();
		return initDeptObj;
	}
	public void setInitDeptObj(String initDeptObj) {
		this.initDeptObj = initDeptObj;
	}
	public IXysKpiDeptUCC getXysKpiDeptUCC() {
		return xysKpiDeptUCC;
	}
	public void setXysKpiDeptUCC(IXysKpiDeptUCC xysKpiDeptUCC) {
		this.xysKpiDeptUCC = xysKpiDeptUCC;
	}
	public List getDeptList() {
		return deptList;
	}
	public void setDeptList(List deptList) {
		this.deptList = deptList;
	}
	//综合计算
	private String initEvaObjIndex;
	private String initEvaObj;
	private List evaObjList;
	private String queryValue;
	private IXysEvaObjUCC xysEvaObjUcc;
	private String showMode="1";
	private String objId;
	private String itemId;
	
	
	public String getItemId() {
		return itemId;
	}
	public void setItemId(String itemId) {
		this.itemId = itemId;
	}
	public void chgNatureGrade(){
		try{
			XysEvaObjBO obj=this.xysEvaObjUcc.findXysEvaObjBOById(objId);
			obj.setNatureGrade(itemId);
			xysEvaObjUcc.saveXysEvaObjBO(obj);
			super.showMessageDetail("调整成功！");
			itemId="";
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public void chgForceGrade(){
		try{
			XysEvaObjBO obj=this.xysEvaObjUcc.findXysEvaObjBOById(objId);
			obj.setForceGrade(itemId);
			xysEvaObjUcc.saveXysEvaObjBO(obj);
			super.showMessageDetail("调整成功！");
			itemId="";
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getObjId() {
		return objId;
	}
	public void setObjId(String objId) {
		this.objId = objId;
	}
	public void changMode(ValueChangeEvent event){
		showMode=event.getNewValue().toString();
	}
	public String getShowMode() {
		return showMode;
	}
	public void setShowMode(String showMode) {
		this.showMode = showMode;
	}
	public void caclEvaObj2(){
		try{
			XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
		    List gradeList=this.evaGradeUCC.getAllGradeItem(bo.getPlanGrade());
		    List deptList=this.xysKpiDeptUCC.getXysKpiDeptObjBO(null, planId,null);
		    if(deptList!=null&&deptList.size()>0){
		    	for(int i=0;i<deptList.size();i++){
		    		XysKpiDeptObjBO dept=(XysKpiDeptObjBO)deptList.get(i);
		    		String deptId=dept.getDeptId();
		    		List objList=this.xysEvaObjUcc.getXysEvaObjBOForSort(planId, deptId);
		    		if(objList!=null&&objList.size()>0){
		    			for(int j=0;j<objList.size();j++){
		    				XysEvaObjBO obj=(XysEvaObjBO)objList.get(j);
		    				obj.setForceSort(String.valueOf(j+1));
		    				xysEvaObjUcc.saveXysEvaObjBO(obj);
		    			}
		    		}
		    		List deptSetList=this.xysSpreadMgrUCC.getXysSpreadDeptSetBO(planId, deptId);
		    		if(deptSetList!=null&&deptSetList.size()>0){
		    			if(gradeList!=null&&gradeList.size()>0){
		    				for(int j=0;j<gradeList.size();j++){
		    					EvaGradeItemBO item=(EvaGradeItemBO)gradeList.get(j);
		    					XysSpreadDeptSetBO set=xysSpreadMgrUCC.findEquealsXysSpreadDeptSetBO(planId, deptId, item.getItemID());
		    					List oList=this.xysEvaObjUcc.getXysEvaObjBOForGrade(planId, deptId, item.getItemID());
		    					if(set!=null&&set.getCtrCount()!=null&&!set.getCtrCount().equals("")){
		    						int size=0;
		    						if(set.getCtrType().equals("1")){//控制数量
		    							size=Integer.parseInt(set.getCtrCount());
		    						}else{//控制比例
		    							double size1=Math.round(objList.size()*Double.parseDouble(set.getCtrCount())/100);
		    							NumberFormat format=NumberFormat.getInstance();
		    							format.setMaximumFractionDigits(0);
		    							size=Integer.parseInt(String.valueOf(format.format(size1)));
		    						}
		    						if(size<=oList.size()){
		    							if(oList!=null&&oList.size()>0){
		    								for(int m=0;m<oList.size();m++){
		    									XysEvaObjBO obj=(XysEvaObjBO)oList.get(m);
		    									if(m<size){
		    										obj.setForceGrade(obj.getNatureGrade());
		    									}else{
		    										obj.setForceGrade(set.getChgGradeItem());
		    									}
		    									xysEvaObjUcc.saveXysEvaObjBO(obj);
		    								}
		    							}
		    						}else{
		    							if(oList!=null&&oList.size()>0){
		    								for(int m=0;m<oList.size();m++){
		    									XysEvaObjBO obj=(XysEvaObjBO)oList.get(m);
		    									obj.setForceGrade(obj.getNatureGrade());
		    									xysEvaObjUcc.saveXysEvaObjBO(obj);
		    								}
		    							}
		    						}
		    					}
		    				}
		    			}
		    		}else{//未设置强制分布按自然分布
		    			if(objList!=null&&objList.size()>0){
			    			for(int j=0;j<objList.size();j++){
			    				XysEvaObjBO obj=(XysEvaObjBO)objList.get(j);
			    				obj.setForceSort(String.valueOf(j+1));
			    				obj.setForceGrade(obj.getNatureGrade());
			    				xysEvaObjUcc.saveXysEvaObjBO(obj);
			    			}
			    		}
		    		}
		    	}
		    }
		    super.showMessageDetail("计算成功！");
		}catch(Exception e){
			super.showMessageDetail("计算失败！");
			e.printStackTrace();
		} 
	}
	
	
	public void caclEvaObj(){
		try{
			xysEvaObjUcc.caclEvaObjBOByPlanId(planId);
			List objList=this.xysEvaObjUcc.getXysEvaObjBOForSort(planId,null);
			XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
			List gradeList=this.evaGradeUCC.getAllGradeItem(bo.getPlanGrade());
			if(objList!=null&&objList.size()>0){
				for(int i=0;i<objList.size();i++){
					XysEvaObjBO obj=(XysEvaObjBO)objList.get(i);
					obj.setNatureSort(String.valueOf(i+1));
					double score=Double.parseDouble(obj.getTotalScore());
					if(gradeList!=null&&gradeList.size()>0){
						for(int j=0;j<gradeList.size();j++){
							EvaGradeItemBO grade=(EvaGradeItemBO)gradeList.get(j);
							double hiValue=Double.parseDouble(grade.getHighValue());
							double lowValue=Double.parseDouble(grade.getLowValue());
							if((score>=lowValue&&score<hiValue)||(score>=100&&hiValue==100)){
								obj.setNatureGrade(grade.getItemID());
							}
						}
					}
					this.xysEvaObjUcc.saveXysEvaObjBO(obj);
				}
			}
			super.showMessageDetail("计算成功！");
		}catch(Exception e){
			super.showMessageDetail("计算失败！");
			e.printStackTrace();
		}
	}
	public IXysEvaObjUCC getXysEvaObjUcc() {
		return xysEvaObjUcc;
	}
	public void setXysEvaObjUcc(IXysEvaObjUCC xysEvaObjUcc) {
		this.xysEvaObjUcc = xysEvaObjUcc;
	}
	public String getInitEvaObjIndex() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
				XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				if(bo.getStatus().equals(XysEvaPlanBO.STATUS_ZHIXING)){
					this.deptDesabled="0";
				}else{
					this.deptDesabled="1";
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initEvaObjIndex;
	}
	public void setInitEvaObjIndex(String initEvaObjIndex) {
		this.initEvaObjIndex = initEvaObjIndex;
	}
	
	public String first4() {
		mypage.setCurrentPage(1);
		queryEvaObj();
		return "";
	}

	public String pre4() {
		if (mypage.getCurrentPage() > 1) {
			mypage.setCurrentPage(mypage.getCurrentPage() - 1);
		}
		queryEvaObj();
		return "";
	}

	public String next4() {
		if (mypage.getCurrentPage() < mypage.getTotalPage()) {
			mypage.setCurrentPage(mypage.getCurrentPage() + 1);
		}
		queryEvaObj();
		return "";
	}

	public String last4() {
		mypage.setCurrentPage(mypage.getTotalPage());
		queryEvaObj();
		return "";
	}
	public void queryEvaObj(){
		try{
			if(mypage.getCurrentPage()==0){
				mypage.setCurrentPage(1);
			}
			if(queryValue!=null&&!queryValue.equals("")){
				String where=" and bo.personId in(select po.personId from PersonBO po " +
						   "where po.name like '%"+queryValue+"%' or po.shortName like '%"+queryValue+"%' or po.personCode like '%"+queryValue+"%')";
				evaObjList=this.xysEvaObjUcc.getXysEvaObjBOByQueryValue(mypage, planId, where);
			}else{
				evaObjList=this.xysEvaObjUcc.getXysEvaObjBOByPlanId(mypage, planId, superId,showMode);
			}
			if(planId!=null&&!planId.equals("")){
				XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				List list=this.evaGradeUCC.getAllGradeItem(bo.getPlanGrade());
				Hashtable map=new Hashtable();
				if(list!=null&&list.size()>0){
					for(int i=0;i<list.size();i++){
						EvaGradeItemBO grade=(EvaGradeItemBO)list.get(i);
						map.put(grade.getItemID(), grade.getItemName());
					}
				}
				if(evaObjList!=null&&evaObjList.size()>0){
					for(int i=0;i<evaObjList.size();i++){
						XysEvaObjBO obj=(XysEvaObjBO)evaObjList.get(i);
						PersonBO pbo = SysCacheTool.findPersonById(obj
								.getPersonId());
						obj.setPersonName(pbo.getName());
						obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
								.getName());
						obj.setPostName(PostTool.getPostName(pbo.getPostId()));
						if(obj.getNatureGrade()!=null&&!obj.getNatureGrade().equals("")){
						   obj.setNatureGrade((String)map.get(obj.getNatureGrade()));
						}
						if(obj.getForceGrade()!=null&&!obj.getForceGrade().equals("")){
						   obj.setForceGrade((String)map.get(obj.getForceGrade()));
						}
						evaObjList.set(i, obj);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitEvaObj() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		if(super.getRequestParameter("superId")!=null){
			superId=super.getRequestParameter("superId");
		}
		if(super.getRequestParameter("showMode")!=null){
			showMode=super.getRequestParameter("showMode");
		}
		queryEvaObj();
		return initEvaObj;
	}
	public void setInitEvaObj(String initEvaObj) {
		this.initEvaObj = initEvaObj;
	}
	public List getEvaObjList() {
		return evaObjList;
	}
	public void setEvaObjList(List evaObjList) {
		this.evaObjList = evaObjList;
	}
	public String getQueryValue() {
		return queryValue;
	}
	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}
	//选择等级
	private String initGrade;
	private List itemList;

	public String getInitGrade() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
			}
			XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
			itemList=this.evaGradeUCC.getAllGradeItem(bo.getPlanGrade());
		}catch(Exception e){
			e.printStackTrace();
		}
		return initGrade;
	}
	public void setInitGrade(String initGrade) {
		this.initGrade = initGrade;
	}
	public List getItemList() {
		return itemList;
	}
	public void setItemList(List itemList) {
		this.itemList = itemList;
	}
	
	// 指标导入
	private String initUpload;
	private UploadedFile excelFile;

	public String uploadFile(){
		try{
			String fileName = excelFile.getName();
			String type = fileName.substring(fileName.indexOf(".") + 1);
			if (type.equals("xls")) {
				Workbook wb =Workbook.getWorkbook(excelFile.getInputStream());
                Sheet sheet = wb.getSheet(0);
                
                Map map=new HashMap();
				int rows = sheet.getRows();
				for (int i = 1; i < rows; i++) {//从第二行开始读取
					Cell[] cell = sheet.getRow(i);
					String personCode=CommonFuns.filterNull(cell[3].getContents());
					if(personCode!=null&&!personCode.equals("")){
						String personId=SysCacheTool.findPersonByCode(personCode).getPersonId();
						XysEvaObjBO obj=this.xysEvaObjUcc.findEqualsXysEvaObjBO(planId, personId);
						obj.setNatureSort(CommonFuns.filterNull(cell[8].getContents()));
						String grade1="";
						if(map.get(planId+":"+CommonFuns.filterNull(cell[9].getContents()))==null){
							grade1=this.xysEvaObjUcc.getGradeByNameAndPlanId(planId, CommonFuns.filterNull(cell[9].getContents()));
							map.put(planId+":"+CommonFuns.filterNull(cell[9].getContents()), grade1);
						}else{
							grade1=(String)map.get(planId+":"+CommonFuns.filterNull(cell[9].getContents()));
						}
						obj.setNatureGrade(CommonFuns.filterNull(grade1));
						obj.setForceSort(CommonFuns.filterNull(cell[10].getContents()));
						String grade2="";
						if(map.get(planId+":"+CommonFuns.filterNull(cell[11].getContents()))==null){
							grade2=this.xysEvaObjUcc.getGradeByNameAndPlanId(planId, CommonFuns.filterNull(cell[9].getContents()));
							map.put(planId+":"+CommonFuns.filterNull(cell[11].getContents()), grade2);
						}else{
							grade2=(String)map.get(planId+":"+CommonFuns.filterNull(cell[11].getContents()));
						}
						obj.setForceGrade(grade2);
						xysEvaObjUcc.saveXysEvaObjBO(obj);
					}
				}
			}else{
				super.showMessageDetail("只允许上传Excel（.xls）文档！");
				return "";
			}
		}catch(Exception e){
			super.showMessageDetail("Excel（.xls）文档遭到破坏请重新编辑！");
			e.printStackTrace();
			return "";
		}
		return "success";
	} 
	public String getInitUpload() {
		if(super.getRequestParameter("planId")!=null){
			planId=super.getRequestParameter("planId");
		}
		return initUpload;
	}
	public void setInitUpload(String initUpload) {
		this.initUpload = initUpload;
	}
	public UploadedFile getExcelFile() {
		return excelFile;
	}
	public void setExcelFile(UploadedFile excelFile) {
		this.excelFile = excelFile;
	}
	
	
}
