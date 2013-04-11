package com.hr319wg.custom.extend.web;

import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.wage.pojo.bo.WageFormulaBO;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.hr319wg.wage.web.WageFormulaBackingBean;

public class WageFormulaBackingBeanByExtend extends WageFormulaBackingBean{

	public String getPageInit()
	  {
	    String act = super.getServletRequest().getParameter("act");
	    if ("list".equals(act)) {
	      this.setUnitId(super.getServletRequest().getParameter("unitId"));

	      String persId = super.getUserInfo().getUserId();
	      PersonBO person = SysCacheTool.findPersonById(persId);
	      String userUnitId=person.getGongZiGX();
	      WageUnitBO userUnit = SysCacheTool.findWageUnit(userUnitId);
	      if (userUnit == null) {
	        super.showMessageDetail("错误：用户没有发薪单位");
	        return "";
	      }

	      this.setOperRight(this.getUnitId().equals(userUnit.getUnitId()));

	      if (this.getFormula() == null){
	    	  this.setFormula(new WageFormulaBO());
	      }
	      this.getFormula().setUnitId(this.getUnitId());
	      list();
	    }
	    this.setUnitName(CodeUtil.interpertCode("OU", this.getFormula().getUnitId()));

	    return this.pageInit;
	  }
}
