package com.hr319wg.custom.extend.web;

import com.hr319wg.custom.wage.service.IWageDataService;
import com.hr319wg.wage.web.WageSetPersonBackingBean;

public class WageSetPersonBackingBeanByExtend extends WageSetPersonBackingBean {

	private IWageDataService dataService;
	
	
	public IWageDataService getDataService() {
		return dataService;
	}

	public void setDataService(IWageDataService dataService) {
		this.dataService = dataService;
	}


	public String save() {
		try {
			String personStr = super.getRequestParameter("form1:personStr");
			if ((personStr != null) && (!"".equals(personStr.trim()))) {
				String[] personId = personStr.split(",");
				this.getWagesetpersonucc().batchAddPerson(this.getSetId(), personId);
				this.getWagesetpersonucc().batchAdd(super.getUserInfo().getUserId(), this.getSetId(), personId);
				this.dataService.batchUpdateWageSetPersonSort(this.getSetId(), personId);
				super.showMessageDetail("人员已成功加入账套");
			}
		} catch (Exception e) {
			super.showMessageDetail("错误：" + e.getMessage());
		}
		return list();
	}
}
