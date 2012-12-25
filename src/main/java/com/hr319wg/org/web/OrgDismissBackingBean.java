package com.hr319wg.org.web;

import com.hr319wg.common.Constants;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.pojo.vo.OrgSetVO;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.portal.IUUManager;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;

public class OrgDismissBackingBean extends BaseBackingBean
{
  private OrgSetVO orgsetvo = new OrgSetVO();
  private IOrgUCC orgucc;
  private String pageInit;

  public String getPageInit()
  {
    return this.pageInit;
  }

  public void setPageInit(String pageInit) {
    this.pageInit = pageInit;
  }

  public OrgSetVO getOrgsetvo() {
    return this.orgsetvo;
  }

  public void setOrgsetvo(OrgSetVO orgsetvo) {
    this.orgsetvo = orgsetvo;
  }

  public IOrgUCC getOrgucc() {
    return this.orgucc;
  }

  public void setOrgucc(IOrgUCC orgucc) {
    this.orgucc = orgucc;
  }

  public String saveDismiss() {
    try {
      String ids = getServletRequest().getParameter("oids");
      if ((ids != null) && (!"".equals(ids))) {
        String[] idarray = ids.split(",");
        this.orgucc.checkOrgSubValidOrg(idarray);
        this.orgucc.checkPerByOrg(idarray);
        this.orgucc.checkPostByOrg(idarray);
        this.orgucc.updateDismissOrg(this.orgsetvo, idarray);
        SysCache.setMap(idarray, 3, 5);
        //同步财务系统,添加一条机构撤销记录
        for(int i=0;i<idarray.length;i++){
        	OrgBO bo = SysCacheTool.findOrgById(idarray[i]);
			SqlUtil.updateData("insert into b001_bd (change_date,change_type,old_mainDeptID,new_mainDeptID,dept_id,dept_type,dept_name) values " +
        					"(getdate(),'撤销','"+bo.getSuperId()+"','"+bo.getSuperId()+"','"+bo.getOrgId()+"','"+("089110".equals(bo.getorgType())?"单位":"部门")+"','"+bo.getName()+"')");        	
        }
        if (!"".equals(Constants.UUM_SERVICE_NAME)) {
          try {
            IUUManager uumanager = (IUUManager)SysContext.getBean(Constants.UUM_SERVICE_NAME);
            if (uumanager != null)
            {
              for (int i = 0; i < idarray.length; i++)
                uumanager.organizationRemove(idarray[i], super.getUserInfo().getUserId(), "1");
            }
          }
          catch (Exception e)
          {
          }
        }
      }
    }
    catch (Exception e)
    {
      getServletRequest().setAttribute("message", e.getMessage());
      getServletRequest().setAttribute("flag", "1");
      return "close";
    }
    this.orgsetvo = null;
    getServletRequest().setAttribute("message", "撤销成功!");
    return "close";
  }
}