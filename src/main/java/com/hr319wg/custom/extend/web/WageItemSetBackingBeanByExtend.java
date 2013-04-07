package com.hr319wg.custom.extend.web;

import java.util.ArrayList;
import java.util.List;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.wage.pojo.bo.WageCostFieldBO;
import com.hr319wg.wage.web.WageItemSetBackingBean;

public class WageItemSetBackingBeanByExtend extends WageItemSetBackingBean {

	public void queryWageItem() throws SysException {
		this.setOrderByName(false);
		if ((super.getRequestParameter("form1:orderByName") != null) && (super.getRequestParameter("form1:orderByName").equals("true"))) {
			this.setOrderByName(true);
		}
		WageCostFieldBO[] temp = this.getWageitemsetucc().queryItem(this.getUnitId(), 3, this.getOrderByName());
		if (temp == null) {
			temp = new WageCostFieldBO[] {};
		}
		List list = new ArrayList();
		for (int i = 0; i < temp.length; i++) {
			InfoItemBO bo = SysCacheTool.findInfoItem("", temp[i].getCostField());
			if ((bo != null) && (!"0".equals(bo.getItemStatus()))){
				list.add(temp[i]);
			}
		}
		this.setWageBos((WageCostFieldBO[]) list.toArray(new WageCostFieldBO[list.size()]));
	}
}
