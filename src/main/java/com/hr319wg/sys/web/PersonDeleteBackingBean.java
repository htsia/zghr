package com.hr319wg.sys.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;

public class PersonDeleteBackingBean extends BaseBackingBean
{
  private IPersonUCC personucc;
  private WageAPI wageapi;
  private String pageInit;

  public String getPageInit()
  {
    try
    {
      String perIds = getServletRequest().getParameter("perids");
      getServletRequest().setAttribute("perIds", perIds);
    }
    catch (Exception e)
    {
    }
    return this.pageInit;
  }

  public void setPageInit(String pageInit) {
    this.pageInit = pageInit;
  }

  public WageAPI getWageapi() {
    return this.wageapi;
  }
  public void setWageapi(WageAPI api) {
    this.wageapi = api;
  }

  public IPersonUCC getPersonucc() {
    return this.personucc;
  }
  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public String delete() {
    try {
      String ids = getServletRequest().getParameter("pids");
      if ((ids != null) && (!"".equals(ids))) {
        String[] idList = ids.split(",");
        for (int i = 0; i < idList.length; i++)
        {
          this.personucc.deleteUserInfo(idList[i]);
          this.wageapi.DeletePerson(idList[i]);
          this.personucc.DeletePerson(idList[i]);
          this.personucc.ClearData(idList[i]);
          //同步财务中间库,添加一条人员删除记录
  		  PersonBO p=SysCacheTool.findPersonById(idList[i]);
  	  	  SqlUtil.updateData("insert into a001_bd (user_id,change_date,change_type,old_dept_id,new_dept_id,user_type,name,user_code) values " +
  	      		"('"+p.getPersonId()+"',getdate(),'删除','"+p.getDeptId()+"','"+p.getDeptId()+"','"+p.getPersonType()+"','"+p.getName()+"','"+p.getPersonCode()+"')");
  	  	  SqlUtil.updateData("delete from a001 where id='"+p.getPersonId()+"'");
        }

        SysCache.setMap(idList, 2, 6);
      }
    } catch (Exception e) {
      this.msg.setMainMsg(e, getClass());
      getServletRequest().setAttribute("flag", "1");
    }
    getServletRequest().setAttribute("message", "成功完成业务!");
    return "close";
  }
}