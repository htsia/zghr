package com.hr319wg.custom.extend.web;

import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.wage.web.WageSetPersonBackingBean;

public class WageSetPersonBackingBeanByExtend extends WageSetPersonBackingBean {

	private String personStr;
	private IWageDataService dataService;
	
	
	public String getPersonStr() {
		return personStr;
	}

	public void setPersonStr(String personStr) {
		this.personStr = personStr;
	}

	public IWageDataService getDataService() {
		return dataService;
	}

	public void setDataService(IWageDataService dataService) {
		this.dataService = dataService;
	}

	public String save() {
		try {
			if (this.personStr != null && !"".equals(this.personStr.trim())) {
				String[]personIDs=this.personStr.split("--");
				String[] personId = personIDs[0].split(",");
				String personCode=null;
				if(personIDs.length==2){
					personCode=personIDs[1];
				}
				this.getWagesetpersonucc().batchAddPerson(this.getSetId(), personId);
				this.getWagesetpersonucc().batchAdd(super.getUserInfo().getUserId(), this.getSetId(), personId);
				this.dataService.batchUpdateWageSetPersonSort(this.getSetId(), personIDs[0], personCode);
				this.personStr=null;
				super.showMessageDetail("人员已成功加入账套");
			}
		} catch (Exception e) {
			this.personStr=null;
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return list();
	}
}
