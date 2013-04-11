package com.hr319wg.custom.extend.web;
import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.sys.api.UserAPI;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.web.WageDateBackingBean;


public class WageDateBackingBeanByExtend extends WageDateBackingBean{

	public String getPageInit() {
	    this.setQryStatus(null);
	    return preInit();
	  }

	  public String getPageHistoryInit() {
		  this.setQryStatus("5");
		  return preInit();
	  }
	
	private String preInit() {
	    try {
	      this.setCanOperNew(UserAPI.checkButtonOperate(super.getUserInfo(), "064804"));

	      if (("true".equals(super.getRequestParameter("Init"))) || ("true".equals(super.getRequestParameter("final")))) {
	        this.setUnitId(null);
	        this.setfinalTax(super.getRequestParameter("final"));
	        this.setSetList(new ArrayList());
	        
	        List<OrgBO> orgList= super.getUserInfo().getHaveQueryOrgScale();

	        User user =super.getUserInfo();
	        if (user.ischo()) {
	          List list = this.getWagesetucc().queryAllSet();
	          for (int i = 0; i < list.size(); i++) {
	            SelectItem item = new SelectItem();
	            WageSetBO set = (WageSetBO)list.get(i);
	        	if(!"1".equals(set.getNoUse())){
	        		item.setLabel(set.getName());
	        		item.setValue(set.getSetId());
	        		this.getSetList().add(item);
	            }
	          }
	        } else {
	          List list = this.getWagesetucc().queryAllSet(user);
	          for (int i = 0; i < list.size(); i++) {
	            SelectItem item = new SelectItem();
	            WageSetBO set = (WageSetBO)list.get(i);
	            for(OrgBO org : orgList){
	            	if(!"1".equals(set.getNoUse()) && set.getUnitId().equals(org.getOrgId())){
	            		item.setLabel(set.getName());
	            		item.setValue(set.getSetId());
	            		this.getSetList().add(item);
	            		break;
	            	}
	            }
	          }
	        }

	        if ((this.getSetList() != null) && (this.getSetList().size() > 0) && ((this.getSetId() == null) || (this.getSetId().trim().length() == 0))) {
	          this.setSetId(((SelectItem)this.getSetList().get(0)).getValue().toString());
	          this.setSetName(((SelectItem)this.getSetList().get(0)).getLabel());
	        }
	        dateList();
	      }
	      else {
	        for (int i = 0; (this.getSetList() != null) && (i < this.getSetList().size()); i++) {
	          SelectItem set = (SelectItem)this.getSetList().get(i);
	          if (this.getSetId().equals(set.getValue()))
	            this.setSetName(set.getLabel());
	        }
	      }
	    }
	    catch (SysException e) {
	      super.showMessageDetail("´íÎó:" + e.getMessage());
	    }
	    return this.pageInit;
	  }

}
