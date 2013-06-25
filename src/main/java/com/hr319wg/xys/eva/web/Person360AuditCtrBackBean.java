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
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360SbjBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;
import com.hr319wg.xys.eva.pojo.vo.Xys360ObjVO;
import com.hr319wg.xys.eva.ucc.IXys360UCC;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;

public class Person360AuditCtrBackBean extends BaseBackingBean {
	 //查看计划
    private IXysEvaPlanUCC xysEvaPlanUCC;
    private String pageInit;
    private PageVO mypage = new PageVO();
    private List planList;
    private IEvaGradeUCC evaGradeUCC;
    private String planId;
    private boolean selectAll = false;
    private IXys360UCC xys360UCC;
    
    public String beginGrade(){
    	 try{
    		 List objList = xys360UCC.getXys360ObjBOByPlanId(null, planId, null);
    		 if(objList!=null&&objList.size()>0){
    			 String result=xys360UCC.beginGradeByPlanId(planId);
    			 super.showMessageDetail(result);
    		 }else{
    			 super.showMessageDetail("没有设置考核客体无法执行开启打分操作！");
    		 }
         }catch (Exception e){
             e.printStackTrace();
         }
         return "";
    }
    //结束打分
    public String endGrade(){
        try{
            XysEvaPlanBO bo=xysEvaPlanUCC.findXysEvaPlanBOById(planId);
            bo.setPerson360Status("2");
            xysEvaPlanUCC.saveXysEvaPlanBO(bo);
        }catch (Exception e){
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
	public IXys360UCC getXys360UCC() {
		return xys360UCC;
	}
	public void setXys360UCC(IXys360UCC xys360ucc) {
		xys360UCC = xys360ucc;
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
	public String getSuperId() {
		return superId;
	}
	public void setSuperId(String superId) {
		this.superId = superId;
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
				XysEvaPlanBO bo = xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				if(queryValue!=null&&!queryValue.equals("")){
					String where=" and bo.personId in(select po.personId from PersonBO po " +
							   "where po.name like '%"+queryValue+"%' or po.shortName like '%"+queryValue+"%' or po.personCode like '%"+queryValue+"%')";
					objList=xys360UCC.getXys360ObjBOByQueryValue(mypage, planId, where);
				}else{
					objList =xys360UCC.getXys360ObjBOByPlanId(mypage, planId,superId);
				}
				Xys360ObjBO obj=null;
				PersonBO pbo=null;
				int objSize=objList.size();
				Xys360SbjBO sbj=null;
				List sbjList=null; 
				if (objList != null && objSize > 0) {
					for (int i = 0; i < objSize; i++) {
						obj = (Xys360ObjBO) objList.get(i);
						pbo = SysCacheTool.findPersonById(obj
								.getPersonId());
						obj.setPlanName(bo.getPlanName());
						obj.setYear(bo.getYear());
						obj.setPersonName(pbo.getName());
						obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
								.getName());
						obj.setPostName(PostTool.getPostName(pbo.getPostId()));
						sbjList= xys360UCC.getXys360SbjBOByObjId(obj.getObjId());
						int sign = 0;
						int sbjSize=sbjList.size();
						if (sbjList != null && sbjSize > 0) {
							for (int j = 0; j < sbjSize; j++) {
								sbj = (Xys360SbjBO) sbjList.get(j);
								if (sbj.getScore() != null
										&& !sbj.getScore().equals("")) {
									sign++;
								}
							}
						}
						obj.setAllCount(String.valueOf(sbjSize));
						obj.setSignCount(String.valueOf(sign));
						obj.setNoSignCount(String.valueOf(sbjSize - sign));
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
		
		
		public String getSbjId() {
			return sbjId;
		}
		public void setSbjId(String sbjId) {
			this.sbjId = sbjId;
		}
		public String deleteSbj(){
			try{
				List scoreList=this.xys360UCC.getXys360ObjScoreBOBySbjId(sbjId);
				if(scoreList!=null&&scoreList.size()>0){
					this.xys360UCC.deleteAll(scoreList);
				}
				this.xys360UCC.deleteXys360SbjBO(sbjId);
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

		public void querySbj() {
			try {
				sbjList = xys360UCC.getXys360SbjBOByObjId(objId);
				if (sbjList != null && sbjList.size() > 0) {
					for (int i = 0; i < sbjList.size(); i++) {
						Xys360SbjBO sbj = (Xys360SbjBO) sbjList.get(i);
						PersonBO pbo = SysCacheTool.findPersonById(sbj
								.getPersonId());
						sbj.setPersonCode(pbo.getPersonCode());
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
					String where=" and bo.personId in(select po.personId from PersonBO po " +
							   "where po.name like '%"+queryValue+"%' or po.shortName like '%"+queryValue+"%' or po.personCode like '%"+queryValue+"%')";
					dataCtrObjList=this.xys360UCC.getXys360ObjVOByQueryValue(mypage, planId, where);
				}else{
					dataCtrObjList=this.xys360UCC.getXys360ObjVO(mypage, planId, superId);
				}
				int size=dataCtrObjList.size();
				if(dataCtrObjList!=null&&size>0){
					for(int i=0;i<size;i++){
						Xys360ObjVO vo=(Xys360ObjVO)dataCtrObjList.get(i);
						PersonBO pbo=SysCacheTool.findPersonById(vo.getPersonId());
						vo.setPersonId(pbo.getName());
						vo.setDeptId(SysCacheTool.findOrgById(vo.getDeptId()).getName());
						vo.setPostId(PostTool.getPostName(vo.getPostId()));
						if((vo.getWeightLeader()==null||vo.getWeightLeader().equals(""))
							&&(vo.getWeightPreLeader()==null||vo.getWeightPreLeader().equals(""))
							&&(vo.getWeightOtherLeader()==null||vo.getWeightOtherLeader().equals(""))
							&&(vo.getWeightVis()==null||vo.getWeightVis().equals(""))
							&&(vo.getWeightOtherVis()==null||vo.getWeightOtherVis().equals(""))
							&&(vo.getWeightLower()==null||vo.getWeightLower().equals(""))){
							vo.setErrorDes("<font color='red'>未设置KPI层次权重</font>");
								continue;
						}
						
						boolean flag=true;//默认合法
						int preCount=0;//上上级打分人数
						int zjCount=0;//直接上级打分人数
						int otherCount=0;//其他上级打分人数
						int tjCount=0;//同级打分人数
						int otherTjCount=0;//其他同级
						int xjCount=0;//下级
						
						//上上级
						if(vo.getWeightPreLeader()!=null&&!vo.getWeightPreLeader().equals("")&&!vo.getWeightPreLeader().equals("0")){
							List prelist=this.xys360UCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_PRE_LEADER);
							int preSbjSize=prelist.size();
							if(prelist!=null&&preSbjSize>0){
								for(int j=0;j<preSbjSize;j++){
									Xys360SbjBO sbj=(Xys360SbjBO)prelist.get(j);
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
							List zjlist=this.xys360UCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_LEADER);
							int zjSbjSize=zjlist.size();
							if(zjlist!=null&&zjSbjSize>0){
								for(int j=0;j<zjSbjSize;j++){
									Xys360SbjBO sbj=(Xys360SbjBO)zjlist.get(j);
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
							List otherlist=this.xys360UCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_OTHER_LEADER);
							int otherSbjSize=otherlist.size();
							if(otherlist!=null&&otherSbjSize>0){
								for(int j=0;j<otherSbjSize;j++){
									Xys360SbjBO sbj=(Xys360SbjBO)otherlist.get(j);
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
						//同级
						if(vo.getWeightVis()!=null&&!vo.getWeightVis().equals("")&&!vo.getWeightVis().equals("0")){
							List tjlist=this.xys360UCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_VIS);
							int tjSbjSize=tjlist.size();
							if(tjlist!=null&&tjSbjSize>0){
								for(int j=0;j<tjSbjSize;j++){
									Xys360SbjBO sbj=(Xys360SbjBO)tjlist.get(j);
									if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
										tjCount++;
									}
								}
								vo.setWeightVis(tjSbjSize+"/"+tjCount);
							}else{
								vo.setWeightVis("0/0");
							}
							if(tjCount==0){
								flag=false;
							}
						}
						
						//其他同级
						if(vo.getWeightOtherVis()!=null&&!vo.getWeightOtherVis().equals("")&&!vo.getWeightOtherVis().equals("0")){
							List otherTjlist=this.xys360UCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_OTHER_VIS);
							int otherTjSbjSize=otherTjlist.size();
							if(otherTjlist!=null&&otherTjSbjSize>0){
								for(int j=0;j<otherTjSbjSize;j++){
									Xys360SbjBO sbj=(Xys360SbjBO)otherTjlist.get(j);
									if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
										otherTjCount++;
									}
								}
								vo.setWeightOtherVis(otherTjSbjSize+"/"+otherTjCount);
							}else{
								vo.setWeightOtherVis("0/0");
							}
							if(otherTjCount==0){
								flag=false;
							}
						}
						//下级
						if(vo.getWeightLower()!=null&&!vo.getWeightLower().equals("")&&!vo.getWeightLower().equals("0")){
							List xjlist=this.xys360UCC.checkSbjGradeData(vo.getObjId(),XysWeightSetBO.EVA_TYPE_LOWER);
							int xjSbjSize=xjlist.size();
							if(xjlist!=null&&xjSbjSize>0){
								for(int j=0;j<xjSbjSize;j++){
									Xys360SbjBO sbj=(Xys360SbjBO)xjlist.get(j);
									if(sbj.getScore()!=null&&!sbj.getScore().equals("")){
										xjCount++;
									}
								}
								vo.setWeightLower(xjSbjSize+"/"+xjCount);
							}else{
								vo.setWeightLower("0/0");
							}
							if(xjCount==0){
								flag=false;
							}
						}
						if(!flag){
							vo.setErrorDes("<font color='red'>缺失打分分数</font>");
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
		//查看层次明细
		private String initDataInfo;
		private String evaType;
		
		public void queryDataInfo(){
			try{
				Xys360ObjBO obj=this.xys360UCC.findXys360ObjBOById(objId);
				PersonBO pbo1=SysCacheTool.findPersonById(obj.getPersonId());
				sbjList=xys360UCC.checkSbjGradeData(objId,evaType);
				if(sbjList!=null&&sbjList.size()>0){
					for(int i=0;i<sbjList.size();i++){
						Xys360SbjBO sbj = (Xys360SbjBO) sbjList.get(i);
						PersonBO pbo = SysCacheTool.findPersonById(sbj
								.getPersonId());
						sbj.setPersonName(pbo.getName());
						sbj.setPersonCode(pbo.getPersonCode());
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
				evaType=super.getRequestParameter("level");
			}
			queryDataInfo();
			return initDataInfo;
		}
		public void setInitDataInfo(String initDataInfo) {
			this.initDataInfo = initDataInfo;
		}
		public String getEvaType() {
			return evaType;
		}
		public void setEvaType(String evaType) {
			this.evaType = evaType;
		}
		
		
}
