package com.hr319wg.custom.attence.web;

import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.attence.pojo.bo.AttMonthBO;
import com.hr319wg.custom.attence.service.IAttBusiService;
import com.hr319wg.util.CommonFuns;

public class AttResultEditBackingBean extends BaseBackingBean {
	private User user = super.getUserInfo();
	private String pageInit;
	private IAttBusiService attBusiService;
	private AttMonthBO bo;
	
	
	public String getPageInit() {
		List<AttMonthBO> list;
		try {
			list = this.attBusiService.getAttMonthBO(user.getUserId(), CommonFuns.getSysDate("yyyy-MM"));
			if(list!=null && list.size()>0){
				this.bo=list.get(0);
			}
		} catch (SysException e) {
			e.printStackTrace();
		}
		return pageInit;
	}
	public void setPageInit(String pageInit) {
		this.pageInit = pageInit;
	}
	public IAttBusiService getAttBusiService() {
		return attBusiService;
	}
	public void setAttBusiService(IAttBusiService attBusiService) {
		this.attBusiService = attBusiService;
	}
	
	public void save(){
		
	}

}
