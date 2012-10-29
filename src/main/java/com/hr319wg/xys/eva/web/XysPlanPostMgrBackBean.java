package com.hr319wg.xys.eva.web;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.xys.eva.pojo.bo.EvaExcPostBO;
import com.hr319wg.xys.eva.pojo.bo.EvaRelBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaModeSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaRoleBO;
import com.hr319wg.xys.eva.pojo.bo.XysLevelWeightSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysPostRoleRelBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightExcPersBO;
import com.hr319wg.xys.eva.pojo.bo.XysWeightSetBO;
import com.hr319wg.xys.eva.pojo.vo.EvaPersonVO;
import com.hr319wg.xys.eva.pojo.vo.PostEvaVO;
import com.hr319wg.xys.eva.ucc.IRelSetUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaRoleUCC;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-5-27
 * Time: 下午2:38
 * To change this template use File | Settings | File Templates.
 */
public class XysPlanPostMgrBackBean extends BaseBackingBean{
    private IXysEvaPlanUCC xysEvaPlanUCC;
    private IXysEvaRoleUCC xysEvaRoleUcc;
    private IRelSetUCC relSetUCC;
    private String pageInit;
    private String superId;
    private String superName;
    private PageVO mypage = new PageVO();
    private List postList;
    private String showMode;
    private String planId;
    private String postId;
    private String initIndex;
    private String postIds;
    
  //加载考核关系
    public String loadEvaRel2(){
        try{
			System.out.println("===========开始加载================");
			if(superId!=null&&superId.equals("")){
				List postList=xysEvaPlanUCC.getEvaPostBOByPlanId(null, superId, planId, "1");
				if(postList!=null&&postList.size()>0){
					for(int i=0;i<postList.size();i++){
						PostBO post = (PostBO)postList.get(i);
						List relList = relSetUCC.getAllEvaRelBOByPostId(post.getPostId());
						if (relList != null && relList.size() > 0) {
							for (int j = 0; j < relList.size(); j++) {
								EvaRelBO rel = (EvaRelBO) relList.get(j);
								if(type.equals(XysWeightSetBO.TYPE_KPI)){
									if(!rel.getEvaType().equals(XysWeightSetBO.EVA_TYPE_LEADER)&&
											!rel.getEvaType().equals(XysWeightSetBO.EVA_TYPE_OTHER_LEADER)&&
											!rel.getEvaType().equals(XysWeightSetBO.EVA_TYPE_PRE_LEADER)){
										continue;
									}
								}
								XysWeightSetBO kpi = xysEvaPlanUCC.findEqualsXysWeightSetBO(planId,post.getPostId(),
												rel.getEvaPostId(),type);
								if (kpi == null) {
									kpi = new XysWeightSetBO();
									kpi.setPostId(post.getPostId());
									kpi.setType(type);
									kpi.setEvaPostId(rel.getEvaPostId());
									kpi.setEvaType(rel.getEvaType());
									kpi.setPlanId(planId);
									xysEvaPlanUCC.saveXysWeightSetBO(kpi);
								}
							}
						}
					}
				}
			}
			System.out.println("===========加载结束================");
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }
    public String getPostIds() {
		return postIds;
	}

	public void setPostIds(String postIds) {
		this.postIds = postIds;
	}

	public IXysEvaRoleUCC getXysEvaRoleUcc() {
		return xysEvaRoleUcc;
	}

	public void setXysEvaRoleUcc(IXysEvaRoleUCC xysEvaRoleUcc) {
		this.xysEvaRoleUcc = xysEvaRoleUcc;
	}

	public IRelSetUCC getRelSetUCC() {
        return relSetUCC;
    }

    public void setRelSetUCC(IRelSetUCC relSetUCC) {
        this.relSetUCC = relSetUCC;
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

    public String getPostId() {
        return postId;
    }

    public void setPostId(String postId) {
        this.postId = postId;
    }

    public String excPost(){
        try{
        	 if(postIds!=null&&!postIds.equals("")){
        		 String ids[]=postIds.split(",");
        		 for(int i=0;i<ids.length;i++){
        			 EvaExcPostBO bo=new EvaExcPostBO();
                     bo.setPostId(ids[i]);
                     bo.setPlanId(planId);
                     xysEvaPlanUCC.saveEvaExcPostBO(bo);
                     XysEvaModeSetBO mode=xysEvaPlanUCC.getXysEvaModeSetBO(planId,ids[i]);
                     if(mode!=null){
                    	 xysEvaPlanUCC.deleteXysEvaModeSetBO(mode.getSetId());
                     }
        		 }
        	 }
             
        }catch (Exception e){
           e.printStackTrace();
        }
        return "";
    }
    public String evaPost(){
        try{
             if(postIds!=null&&!postIds.equals("")){
            	 String ids[]=postIds.split(",");
            	 for(int i=0;i<ids.length;i++){
            		 EvaExcPostBO bo=xysEvaPlanUCC.findEqualsEvaExcPostBO(planId,ids[i]);
                     xysEvaPlanUCC.deleteEvaExcPostBO(bo.getExcId());
            	 }
             }
        }catch (Exception e){
           e.printStackTrace();
        }
        return "";
    }
    public String getPlanId() {
        return planId;
    }

    public void setPlanId(String planId) {
        this.planId = planId;
    }

    public String getShowMode() {
        return showMode;
    }

    public void setShowMode(String showMode) {
        this.showMode = showMode;
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
               postList=new ArrayList();
               if(showMode==null||showMode.equals("")){
                   showMode="1";
               }
               if(superId==null||superId.equals("")){
            	   superId=super.getUserInfo().getOrgId(); 
               }
               //初始化模型权重
               List pList=xysEvaPlanUCC.getEqualsPostBOByPlanId(planId);
               Hashtable setMap=xysEvaPlanUCC.getXysEvaModeSetBOByPlanForMap(planId);
               Hashtable relMap=relSetUCC.getAllXysPostRoleRelBOForMap();
               Hashtable roleMap=new Hashtable();
               List rlist=xysEvaRoleUcc.getXysEvaRoleBOByOrgId(null,null);
               if(rlist!=null&&rlist.size()>0){
            	  for(int i=0;i<rlist.size();i++){
            		  XysEvaRoleBO bo=(XysEvaRoleBO)rlist.get(i);
            		  roleMap.put(bo.getRoleId(),bo);
            	  }
               }
               if(pList!=null&&pList.size()>0){
            	  for(int i=0;i<pList.size();i++){
            		  PostBO bo = (PostBO)pList.get(i);
            		  XysEvaModeSetBO setBo=(XysEvaModeSetBO)setMap.get(bo.getPostId());
            		  if(setBo==null){
            			  XysPostRoleRelBO rel=(XysPostRoleRelBO)relMap.get(bo.getPostId());
            			  if(rel!=null){
            				  XysEvaRoleBO role=(XysEvaRoleBO)roleMap.get(rel.getRoleId());
            				  if(role!=null){
            					  setBo=new XysEvaModeSetBO();
            					  setBo.setPlanId(planId);
            					  setBo.setPostId(bo.getPostId());
            					  setBo.setWeight360(CommonFuns.filterNull(role.getWeight360()));
            					  setBo.setWeightKpi(CommonFuns.filterNull(role.getWeightKpi()));
            					  setBo.setWeightXspj(CommonFuns.filterNull(role.getWeightXspj()));
            					  xysEvaPlanUCC.saveXysEvaModeSetBO(setBo);
            				  }
            			  }
            		  }
            	  }
               }
               List list= xysEvaPlanUCC.getEvaPostBOByPlanId(mypage, superId,planId,showMode);
               Hashtable map=this.xysEvaPlanUCC.getXysEvaModeSetBOByPlanForMap(planId);
               Hashtable errorMap=this.xysEvaPlanUCC.getIllegalPostBOByPlanIdForMap(planId);
               if (list != null && list.size() > 0) {
                   for (int i = 0; i < list.size(); i++) {
                       PostBO bo = (PostBO) list.get(i);
                       XysEvaModeSetBO set=(XysEvaModeSetBO)map.get(bo.getPostId());
                       PostEvaVO vo=new PostEvaVO();
                       vo.setPostId(bo.getPostId());
                       vo.setPostName(bo.getName());
                       vo.setDeptName(SysCacheTool.findOrgById(bo.getOrgId()).getName());
                       vo.setPostClass(CodeUtil.interpertCode(bo.getPostClass()));
                       if(set!=null){
                           vo.setWeight360(CommonFuns.filterNull(set.getWeight360()));
                           vo.setWeightKpi(CommonFuns.filterNull(set.getWeightKpi()));
                           vo.setWeightXspj(CommonFuns.filterNull(set.getWeightXspj()));
                       }
                       PostBO pbo=(PostBO)errorMap.get(bo.getPostId());
                       if(pbo!=null){
                    	   vo.setError("<font color='red'>否</font>");
                       }else{
                    	   vo.setError("是");
                       }
                       postList.add(vo);
                   }
               }
           } catch (Exception e) {
               e.printStackTrace();
           }
       }

    public IXysEvaPlanUCC getXysEvaPlanUCC() {
        return xysEvaPlanUCC;
    }

    public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
        this.xysEvaPlanUCC = xysEvaPlanUCC;
    }

    public String getPageInit() {
        if(super.getRequestParameter("planId")!=null){
            planId=super.getRequestParameter("planId");
        }
        if(super.getRequestParameter("showMode")!=null){
            showMode=super.getRequestParameter("showMode");
        }
        if(super.getRequestParameter("superId")!=null){
            superId=super.getRequestParameter("superId");
        }
        doQuery();
        return pageInit;
    }

    public void setPageInit(String pageInit) {
        this.pageInit = pageInit;
    }

    public String getSuperId() {
        return superId;
    }

    public void setSuperId(String superId) {
        this.superId = superId;
    }

    public String getSuperName() {
        if(superId!=null&&!superId.equals("")){
           superName= SysCacheTool.findOrgById(superId).getName();
        }
        return superName;
    }

    public void setSuperName(String superName) {
        this.superName = superName;
    }

    public PageVO getMypage() {
        return mypage;
    }

    public void setMypage(PageVO mypage) {
        this.mypage = mypage;
    }

    public List getPostList() {
        return postList;
    }

    public void setPostList(List postList) {
        this.postList = postList;
    }

    //编辑考核模型
    private String initEdit;
    private XysEvaModeSetBO setBO=new XysEvaModeSetBO();

    public String saveMode(){
        try{
            int weightKpi=Integer.parseInt(CommonFuns.filterNullToZero(setBO.getWeightKpi()));
            int weight360=Integer.parseInt(CommonFuns.filterNullToZero(setBO.getWeight360()));
            int weightXspj=Integer.parseInt(CommonFuns.filterNullToZero(setBO.getWeightXspj()));
            int weight=weight360+weightKpi+weightXspj;
            if(weight==100){
                setBO.setPlanId(planId);
                setBO.setPostId(postId);
                xysEvaPlanUCC.saveXysEvaModeSetBO(setBO);
            }else{
                super.showMessageDetail("权重和必须等于100");
                return "";
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "success";
    }

    public String getInitEdit() {
        try{
             if(super.getRequestParameter("planId")!=null){
                 planId=super.getRequestParameter("planId");
                 postId=super.getRequestParameter("postId");
                 setBO=xysEvaPlanUCC.getXysEvaModeSetBO(planId,postId);
                 if(setBO==null){
                    setBO=new XysEvaModeSetBO();
                 }
             }
        }catch (Exception e){
            e.printStackTrace();
        }
        return initEdit;
    }

    public void setInitEdit(String initEdit) {
        this.initEdit = initEdit;
    }

    public XysEvaModeSetBO getSetBO() {
        return setBO;
    }

    public void setSetBO(XysEvaModeSetBO setBO) {
        this.setBO = setBO;
    }
    //权重设置
    private String initWeightList;
    private String postName;
    private String type;
    private String operateName;
    private String setId;
    private List weightList;
    private String weightEdit;
    private XysWeightSetBO setBo=new XysWeightSetBO();
    private String editType;
    private String setIds;
    
    public void deleteAll(){
		try{
			if(setIds!=null&&!setIds.equals("")){
				String[] ids=setIds.split(",");
				for(int i=0;i<ids.length;i++){
					this.xysEvaPlanUCC.deleteXysWeightSetBO(ids[i]);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
    public String getSetIds() {
		return setIds;
	}
	public void setSetIds(String setIds) {
		this.setIds = setIds;
	}
	public String getEditType() {
        return editType;
    }

    public void setEditType(String editType) {
        this.editType = editType;
    }
    public String saveWeight(){
        try{
            XysWeightSetBO bo=xysEvaPlanUCC.findEqualsXysWeightSetBO(planId,postId,setBo.getEvaPostId(),type);
            if(bo!=null&&editType.equals("add")){
               super.showMessageDetail("该岗位已经设置，无法重复设置");
               return "";
            }else{
               setBo.setType(type);
               setBo.setPostId(postId);
               setBo.setPlanId(planId);
               xysEvaPlanUCC.saveXysWeightSetBO(setBo);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return "success";
    }
    public String getWeightEdit() {
        try{
            if(super.getRequestParameter("postId")!=null){
                postId=super.getRequestParameter("postId");
                planId=super.getRequestParameter("planId");
                type=super.getRequestParameter("type");
                setBo.initRow();
                editType="add";
            }else if(super.getRequestParameter("setId")!=null){
                setId=super.getRequestParameter("setId");
                setBo=xysEvaPlanUCC.findXysWeightSetBOById(setId);
                planId=setBo.getPlanId();
                postId=setBo.getPostId();
                type=setBo.getType();
                editType="update";
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return weightEdit;
    }

    public void setWeightEdit(String weightEdit) {
        this.weightEdit = weightEdit;
    }

    public XysWeightSetBO getSetBo() {
        return setBo;
    }

    public void setSetBo(XysWeightSetBO setBo) {
        this.setBo = setBo;
    }

    public List getWeightList() {
        return weightList;
    }

    public void setWeightList(List weightList) {
        this.weightList = weightList;
    }

    public String deleteSet(){
        try{
           xysEvaPlanUCC.deleteXysWeightSetBO(setId);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }
    
  //加载考核关系
    public String loadEvaRel(){
        try{
			System.out.println("===========开始加载================");
			PostBO post = SysCacheTool.findPost(postId);
			List relList = relSetUCC.getAllEvaRelBOByPostId(post.getPostId());
			if (relList != null && relList.size() > 0) {
				for (int j = 0; j < relList.size(); j++) {
					EvaRelBO rel = (EvaRelBO) relList.get(j);
					if(type.equals(XysWeightSetBO.TYPE_KPI)){
						if(!rel.getEvaType().equals(XysWeightSetBO.EVA_TYPE_LEADER)&&
								!rel.getEvaType().equals(XysWeightSetBO.EVA_TYPE_OTHER_LEADER)&&
								!rel.getEvaType().equals(XysWeightSetBO.EVA_TYPE_PRE_LEADER)){
							continue;
						}
					}
					XysWeightSetBO kpi = xysEvaPlanUCC.findEqualsXysWeightSetBO(planId,post.getPostId(),
									rel.getEvaPostId(),type);
					if (kpi == null) {
						kpi = new XysWeightSetBO();
						kpi.setPostId(post.getPostId());
						kpi.setType(type);
						kpi.setEvaPostId(rel.getEvaPostId());
						kpi.setEvaType(rel.getEvaType());
						kpi.setPlanId(planId);
						xysEvaPlanUCC.saveXysWeightSetBO(kpi);
					}
				}
			}

			System.out.println("===========加载结束================");
        }catch (Exception e){
            e.printStackTrace();
        }
        return "";
    }
    public void queryWeight(){
        try{
        	 List list=xysEvaPlanUCC.getXysWeightSetBO(planId,postId,type);
        	 if(list==null||list.size()<=0){
        		 loadEvaRel();
        	 }
             weightList=xysEvaPlanUCC.getXysWeightSetBO(planId,postId,type);
             if(weightList!=null&&weightList.size()>0){
                 for(int i=0;i<weightList.size();i++){
                      XysWeightSetBO bo=(XysWeightSetBO)weightList.get(i);
                      PostBO post=SysCacheTool.findPost(bo.getEvaPostId());
                      bo.setEvaPostId(post.getName());
                      bo.setDeptName(SysCacheTool.findOrgById(post.getOrgId()).getName());
                      weightList.set(i,bo);
                 }
             }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public String getInitWeightList() {
        if(super.getRequestParameter("postId")!=null){
            postId=super.getRequestParameter("postId");
            planId=super.getRequestParameter("planId");
            postName=PostTool.getPostName(postId);
        }
        if(super.getRequestParameter("type")!=null){
            type=super.getRequestParameter("type");
            if(type.equals("1")){
               operateName="KPI主体设置";
            }else{
               operateName="360主体设置";
            }
        }
        queryWeight();
        return initWeightList;
    }

    public void setInitWeightList(String initWeightList) {
        this.initWeightList = initWeightList;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getOperateName() {
        return operateName;
    }

    public void setOperateName(String operateName) {
        this.operateName = operateName;
    }

    public String getSetId() {
        return setId;
    }

    public void setSetId(String setId) {
        this.setId = setId;
    }
    //查看关联的人员
    private String initPers;
    private List persList;
    private String personId;

    public String excPers(){
    	try{
    		XysWeightExcPersBO bo=new XysWeightExcPersBO();
    		bo.setPersonId(personId);
    		bo.setSetId(setId);
    		xysEvaPlanUCC.saveXysWeightExcPersBO(bo);
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return "";
    }
    public String selPers(){
    	try{
    		XysWeightExcPersBO bo=xysEvaPlanUCC.findEqualsXysWeightExcPersBO(setId, personId);
    		xysEvaPlanUCC.deleteXysWeightExcPersBO(bo.getExcId());
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	return "";
    }
	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public void queryPers(){
		try{
			persList=new ArrayList();
			List list=xysEvaPlanUCC.getPersonBOByWeightSetId(setId);
			if(list!=null&&list.size()>0){
				for(int i=0;i<list.size();i++){
					PersonBO pbo=(PersonBO)list.get(i);
					EvaPersonVO vo=new EvaPersonVO();
					vo.setPersonId(pbo.getPersonId());
					vo.setPersonName(pbo.getName());
					vo.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId()).getName());
					XysWeightExcPersBO bo=xysEvaPlanUCC.findEqualsXysWeightExcPersBO(setId,pbo.getPersonId());
					if(bo!=null){
						vo.setIsExc("1");
					}else{
						vo.setIsExc("0");
					}
					persList.add(vo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public String getInitPers() {
		if(super.getRequestParameter("setId")!=null){
			setId=super.getRequestParameter("setId");
		}
		queryPers();
		return initPers;
	}

	public void setInitPers(String initPers) {
		this.initPers = initPers;
	}

	public List getPersList() {
		return persList;
	}

	public void setPersList(List persList) {
		this.persList = persList;
	}
	//设置权重
	private String initLevel;
	private XysLevelWeightSetBO levelBo;
	
	public String saveLevel(){
		try{
			int weightPreLeader=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightPreLeader()));
			int weightLeader=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightLeader()));
			int weightotherLeader=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightOtherLeader()));
			int weightvis=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightVis()));
			int weightotherVis=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightOtherVis()));
			int weightlow=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightLower()));
			int weight=weightPreLeader+weightLeader+weightotherLeader+weightvis+weightotherVis+weightlow;
			if(weight==100){
				levelBo.setPlanId(planId);
				levelBo.setPostId(postId);
				levelBo.setType(type);
				xysEvaPlanUCC.saveXysLevelWeightSetBO(levelBo);
			}else{
				super.showMessageDetail("权重和必须是100！");
				return "";
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getInitLevel() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
			}
			if(super.getRequestParameter("postId")!=null){
				postId=super.getRequestParameter("postId");
			}
			if(super.getRequestParameter("type")!=null){
				type=super.getRequestParameter("type");
			}
			levelBo=this.xysEvaPlanUCC.findEqualsXysLevelWeightSetBO(planId, postId,type);
			if(null==levelBo){
				levelBo=new XysLevelWeightSetBO();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return initLevel;
	}
	public void setInitLevel(String initLevel) {
		this.initLevel = initLevel;
	}
	public XysLevelWeightSetBO getLevelBo() {
		return levelBo;
	}
	public void setLevelBo(XysLevelWeightSetBO levelBo) {
		this.levelBo = levelBo;
	}
	
    //批量设置
	private String initLevelBatch;
	
	public String saveLevelBatch(){
		try{
			int weightPreLeader=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightPreLeader()));
			int weightLeader=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightLeader()));
			int weightotherLeader=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightOtherLeader()));
			int weightvis=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightVis()));
			int weightotherVis=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightOtherVis()));
			int weightlow=Integer.parseInt(CommonFuns.filterNullToZero(levelBo.getWeightLower()));
			int weight=weightPreLeader+weightLeader+weightotherLeader+weightvis+weightotherVis+weightlow;
			if(weight==100){
				if(postIds!=null&&!postIds.equals("")){
					String ids[]=postIds.split(",");
					for(int i=0;i<ids.length;i++){
						XysLevelWeightSetBO bo=xysEvaPlanUCC.findEqualsXysLevelWeightSetBO(planId, ids[i], type);
						if(bo==null){
							bo=new XysLevelWeightSetBO();
						}	
						bo.setPlanId(planId);
						bo.setPostId(ids[i]);
						bo.setType(type);
						bo.setGradeType(CommonFuns.filterNull(levelBo.getGradeType()));
						bo.setWeightPreLeader(CommonFuns.filterNull(levelBo.getWeightPreLeader()));
						bo.setWeightLeader(CommonFuns.filterNull(levelBo.getWeightLeader()));
						bo.setWeightOtherLeader(CommonFuns.filterNull(levelBo.getWeightOtherLeader()));
						bo.setWeightVis(CommonFuns.filterNull(levelBo.getWeightVis()));
						bo.setWeightOtherVis(CommonFuns.filterNull(levelBo.getWeightOtherVis()));
						bo.setWeightLower(CommonFuns.filterNull(levelBo.getWeightLower()));
						xysEvaPlanUCC.saveXysLevelWeightSetBO(bo);
					}
				}
			}else{
				super.showMessageDetail("权重和必须是100！");
				return "";
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}
	public String getInitLevelBatch() {
		try{
			if(super.getRequestParameter("planId")!=null){
				planId=super.getRequestParameter("planId");
			}
			if(super.getRequestParameter("postIds")!=null){
				postIds=super.getRequestParameter("postIds");
			}
			if(super.getRequestParameter("type")!=null){
				type=super.getRequestParameter("type");
			}
			levelBo=new XysLevelWeightSetBO();
		}catch(Exception e){
			e.printStackTrace();
		}
		return initLevelBatch;
	}
	public void setInitLevelBatch(String initLevelBatch) {
		this.initLevelBatch = initLevelBatch;
	}
	
}
