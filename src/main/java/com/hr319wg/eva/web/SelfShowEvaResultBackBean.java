package com.hr319wg.eva.web;

import java.util.List;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.eva.pojo.bo.EvaPlanBO;
import com.hr319wg.eva.ucc.IEvaPlanUCC;
import com.hr319wg.sys.cache.SysCacheTool;

public class SelfShowEvaResultBackBean extends BaseBackingBean {
	private IEvaPlanUCC evaplanucc;
	private String pageInit;
	private String personId;
	private List planList;

	public String getPageInit() {
		try{
			personId=super.getUserInfo().getUserId();
			planList=evaplanucc.getAllTableModeEvaPlanBOByPersonId(personId);
			if(planList!=null&&planList.size()>0){
				for(int i=0;i<planList.size();i++){
					EvaPlanBO bo=(EvaPlanBO)planList.get(i);
					bo.setCreatePersonName(SysCacheTool.findPersonById(bo.getCreatePersonId()).getName());
					planList.set(i, bo);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return pageInit;
	}

	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}

	public List getPlanList() {
		return planList;
	}

	public void setPlanList(List planList) {
		this.planList = planList;
	}

	public IEvaPlanUCC getEvaplanucc() {
		return evaplanucc;
	}

	public void setEvaplanucc(IEvaPlanUCC evaplanucc) {
		this.evaplanucc = evaplanucc;
	}
}
