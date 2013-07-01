package com.hr319wg.xys.eva.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.PageVO;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.post.util.PostTool;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360ObjKeyBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempItemBO;
import com.hr319wg.xys.eva.pojo.bo.Xys360TempSetBO;
import com.hr319wg.xys.eva.pojo.bo.XysEvaPlanBO;
import com.hr319wg.xys.eva.ucc.IRelSetUCC;
import com.hr319wg.xys.eva.ucc.IXys360TempUCC;
import com.hr319wg.xys.eva.ucc.IXys360UCC;
import com.hr319wg.xys.eva.ucc.IXysEvaPlanUCC;
import com.hr319wg.xys.eva.ucc.IXysEvaRoleUCC;

public class Xys360SetBackBean extends BaseBackingBean {
	private IXys360UCC xys360UCC;
	private IXysEvaPlanUCC xysEvaPlanUCC;
	private IXys360TempUCC xys360TempUCC;
	private String initIndex;
	private String superId;
	private String planId;
	private String pageInit;
	private String superName;
	private PageVO mypage = new PageVO();
	private List objList;
	private String objId;
	private boolean disabled;
	private IXysEvaRoleUCC xysEvaRoleUcc;
	private IRelSetUCC relSetUCC;
	private String queryValue;
	
	
	public String getQueryValue() {
		return queryValue;
	}
	public void setQueryValue(String queryValue) {
		this.queryValue = queryValue;
	}
	public IRelSetUCC getRelSetUCC() {
		return relSetUCC;
	}
	public void setRelSetUCC(IRelSetUCC relSetUCC) {
		this.relSetUCC = relSetUCC;
	}
	public IXysEvaRoleUCC getXysEvaRoleUcc() {
		return xysEvaRoleUcc;
	}
	public void setXysEvaRoleUcc(IXysEvaRoleUCC xysEvaRoleUcc) {
		this.xysEvaRoleUcc = xysEvaRoleUcc;
	}
	public boolean isDisabled() {
		return disabled;
	}
	public void setDisabled(boolean disabled) {
		this.disabled = disabled;
	}
	public IXys360TempUCC getXys360TempUCC() {
		return xys360TempUCC;
	}
	public void setXys360TempUCC(IXys360TempUCC xys360TempUCC) {
		this.xys360TempUCC = xys360TempUCC;
	}
	public String loadPost(){
		try{
			this.xys360UCC.load360OjbByPlanId(planId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String deleteObj() {
		try {
			xys360UCC.deleteXys360ObjBO(objId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public IXys360UCC getXys360UCC() {
		return xys360UCC;
	}

	public void setXys360UCC(IXys360UCC xys360ucc) {
		xys360UCC = xys360ucc;
	}

	public String getInitIndex() {
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
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
			if (superId == null || superId.equals("")) {
				superId = super.getUserInfo().getOrgId();
			}
			if(planId!=null&&!planId.equals("")){
				XysEvaPlanBO planbo=xysEvaPlanUCC.findXysEvaPlanBOById(planId);
				if(planbo.getPerson360Status()!=null&&!planbo.getPerson360Status().equals("")){
					disabled=true;
				}else{
					disabled=false;
				}
				if(queryValue!=null&&!queryValue.equals("")){
					String where=" and bo.personId in(select po.personId from PersonBO po " +
							   "where po.name like '%"+queryValue+"%' or po.shortName like '%"+queryValue+"%' or po.personCode like '%"+queryValue+"%')";
					objList=xys360UCC.getXys360ObjBOByQueryValue(mypage, planId, where);
				}else{
					objList = xys360UCC.getXys360ObjBOByPlanId(mypage, planId,superId);
				}
				if (objList != null && objList.size() > 0) {
					for (int i = 0; i < objList.size(); i++) {
						Xys360ObjBO obj = (Xys360ObjBO) objList.get(i);
						if(obj.getTemplateId()!=null&&!obj.getTemplateId().equals("")){
							Xys360TempBO tmp=this.xys360TempUCC.findXys360TempBO(obj.getTemplateId());
							obj.setTemplateName(tmp.getTempName());
						}else{
							obj.setTemplateId("NO-SET");
						}
						PersonBO pbo = SysCacheTool.findPersonById(obj
								.getPersonId());
						obj.setPersonName(pbo.getName());
						obj.setDeptName(SysCacheTool.findOrgById(pbo.getDeptId())
								.getName());
						obj.setPostName(PostTool.getPostName(pbo.getPostId()));
						objList.set(i, obj);
					}
				}
			}else{
				objList = new ArrayList();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getPageInit() {
	  	String act=super.getRequestParameter("act");
    	if("init".equals(act)){
    		planId = null;
    		superId = null;
    	}
		if (super.getRequestParameter("superId") != null) {
			superId = super.getRequestParameter("superId");
		}
		if (super.getRequestParameter("planId") != null) {
			planId = super.getRequestParameter("planId");
		}
		doQuery();
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getSuperName() {
		if(superId!=null&&!superId.equals("")){
    		superName=SysCacheTool.findOrgById(superId).getName();
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

	public List getObjList() {
		return objList;
	}

	public void setObjList(List objList) {
		this.objList = objList;
	}

	public String getObjId() {
		return objId;
	}

	public void setObjId(String objId) {
		this.objId = objId;
	}

	public IXysEvaPlanUCC getXysEvaPlanUCC() {
		return xysEvaPlanUCC;
	}

	public void setXysEvaPlanUCC(IXysEvaPlanUCC xysEvaPlanUCC) {
		this.xysEvaPlanUCC = xysEvaPlanUCC;
	}
	//选择模版
	private String objIds;
	private String templateId;
	private String initSel;
	private List tempList;
	
	public String selTemplate(){
		try{
			if(objIds!=null&&!objIds.equals("")&&templateId!=null&&!templateId.equals("")){
				List itemList=this.xys360TempUCC.getXys360TempItemBOByTempId(templateId);
				String ids[]=objIds.split(",");
				for(int i=0;i<ids.length;i++){
					Xys360ObjBO obj=this.xys360UCC.findXys360ObjBOById(ids[i]);
					if(obj!=null){
						List list=xys360UCC.getXys360ObjKeyBOByObjId(obj.getObjId());
						if(list!=null&&list.size()>0){
							this.xys360TempUCC.deleteAll(list);
						}
					}
					if(itemList!=null&&itemList.size()>0){
						for(int j=0;j<itemList.size();j++){
							Xys360TempItemBO item=(Xys360TempItemBO)itemList.get(j);
							Xys360TempSetBO setbo=this.xys360TempUCC.findXys360TempSetBOById(item.getSetId());
							Xys360ObjKeyBO key=new Xys360ObjKeyBO();
							key.setObjId(obj.getObjId());
							key.setKeyName(item.getItemName());
							key.setHiValue(item.getHiValue());
							key.setKeyDesc(item.getItemDesc());
							key.setKeyType(setbo.getSetType());
							key.setLowValue(item.getLowValue());
							key.setWeight(item.getWeight());
							xys360UCC.saveXys360ObjKeyBO(key);
						}
					}
					obj.setTemplateId(templateId);
					this.xys360UCC.saveXys360ObjBO(obj);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "";
	}
	public String getInitSel() {
		try{
			tempList=this.xys360TempUCC.getAllXys360TempBO();
		}catch(Exception e){
			e.printStackTrace();
		}
		return initSel;
	}
	public void setInitSel(String initSel) {
		this.initSel = initSel;
	}
	public List getTempList() {
		return tempList;
	}
	public void setTempList(List tempList) {
		this.tempList = tempList;
	}
	public String getObjIds() {
		return objIds;
	}
	public void setObjIds(String objIds) {
		this.objIds = objIds;
	}
	public String getTemplateId() {
		return templateId;
	}
	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}
	
	//增加部门考核岗位
	private String postIds;

	public String addPost() {
	    try {
	        if (postIds != null && !postIds.equals("")) {
	            String ids[] = postIds.split(",");
	            for (int i = 0; i < ids.length; i++) {
	                if (ids[i] != null && !ids[i].equals("")) {
	                    List pids = xys360UCC.getPersonIdsByPostId(ids[i]);
	                    if (pids != null && pids.size() > 0) {
	                        for (int j = 0; j < pids.size(); j++) {
	                            String pid = (String) pids.get(j);
	                            Xys360ObjBO obj = xys360UCC.findEqualsXys360ObjBO(planId, pid);
	                            if (obj == null) {
	                                obj = new Xys360ObjBO();
	                                PersonBO pbo=SysCacheTool.findPersonById(pid);
	                                obj.setPersonId(pid);
	                                obj.setPlanId(planId);
	                                obj.setPostId(pbo.getPostId());
	                                xys360UCC.saveXys360ObjBO(obj);
	                            }
	                        }
	                    }
	                }
	            }
	        }
	        postIds="";
	    } catch (Exception e) {
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

}
