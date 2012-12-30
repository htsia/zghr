package com.hr319wg.org.web;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.org.util.OrgTool;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.RecordVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.wage.util.WageTools;

public class OrgDismissListBackingBean extends BaseBackingBean
{
  private IOrgUCC orgucc;
  private String orgList;
  private String orgName;
  private String superId;
  private String orgType;
  private String backRefresh;
  private String delRefresh;

  public IOrgUCC getOrgucc()
  {
    return this.orgucc;
  }

  public void setOrgucc(IOrgUCC orgucc) {
    this.orgucc = orgucc;
  }

  public String getBackRefresh() {
    return this.backRefresh;
  }

  public void setBackRefresh(String backRefresh) {
    this.backRefresh = backRefresh;
  }

  public String getDelRefresh() {
    return this.delRefresh;
  }

  public void setDelRefresh(String delRefresh) {
    this.delRefresh = delRefresh;
  }

  public String getOrgList() {
    String pageFlag = getServletRequest().getParameter("pageFlag");
    String flag = getServletRequest().getParameter("flag");
    String sessionFlag = getServletRequest().getParameter("sessionFlag");
    if (sessionFlag == null) {
      getHttpSession().removeAttribute("OBJECT");
    }
    if ("1".equals(pageFlag)) {
      try
      {
        String rowNums = getServletRequest().getParameter("rowNum");
        int pageNum = (getServletRequest().getParameter("pageNum") == null) || ("".equals(getServletRequest().getParameter("pageNum"))) ? 1 : Integer.parseInt(getServletRequest().getParameter("pageNum"));

        String sql = (String)getHttpSession().getAttribute("activeSql");

        TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");
        int rowNum = Constants.ACTIVE_PAGE_SIZE;
        if (rowNums != null) {
          rowNum = Integer.parseInt(rowNums);
        }
        User user = getUserInfo();
        this.orgucc.querySql(table, sql, user, pageNum, rowNum);
        getHttpSession().setAttribute("OBJECT", table);
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
        getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      }
      catch (Exception e) {
        e.printStackTrace();
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        getHttpSession().removeAttribute("OBJECT");
        this.msg.setMainMsg(e, getClass());
      }
    }
    if ("1".equals(flag))
    {
      getHttpSession().removeAttribute("OBJECT");
      getHttpSession().removeAttribute("activeSql");
      getHttpSession().removeAttribute("pageNum");
      getHttpSession().removeAttribute("rowNum");
      try {
        String superOrg = getServletRequest().getParameter("superId");
        if ((superOrg != null) && (!"".equals(superOrg))) {
          this.superId = superOrg;
        }
        TableVO table = new TableVO();
        String rowNums = (String)getHttpSession().getAttribute("rowNum");
        int rowNum = Constants.ACTIVE_PAGE_SIZE;
        if (rowNums != null) {
          rowNum = Integer.parseInt(rowNums);
        }
        User user = getUserInfo();
        String sql = this.orgucc.queryOrgList(table, this.orgName, this.superId, this.orgType, 1, rowNum, "00901", user, "1");
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf("1"));
        getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
        getHttpSession().setAttribute("OBJECT", table);
      } catch (Exception e) {
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        getHttpSession().removeAttribute("OBJECT");
        e.printStackTrace();
        this.msg.setMainMsg(e, getClass());
      }
    }
    return this.orgList;
  }

  public void setOrgList(String orgList) {
    this.orgList = orgList;
  }

  public String getOrgName() {
    return this.orgName;
  }

  public void setOrgName(String orgName) {
    this.orgName = orgName;
  }

  public String getSuperId() {
    return this.superId;
  }

  public void setSuperId(String superId) {
    this.superId = superId;
  }

  public String getOrgType() {
    return this.orgType;
  }

  public void setOrgType(String orgType) {
    this.orgType = orgType;
  }

  public String queryOrg()
  {
    try
    {
      TableVO table = new TableVO();
      String rowNums = (String)getHttpSession().getAttribute("rowNum");
      int rowNum = Constants.ACTIVE_PAGE_SIZE;
      if (rowNums != null) {
        rowNum = Integer.parseInt(rowNums);
      }
      User user = getUserInfo();
      String sql = this.orgucc.queryOrgList(table, this.orgName, this.superId, this.orgType, 1, rowNum, "00901", user, "2");
      getHttpSession().setAttribute("activeSql", sql);
      getHttpSession().setAttribute("pageNum", String.valueOf("1"));
      getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      getHttpSession().setAttribute("OBJECT", table);
    } catch (Exception e) {
      getHttpSession().removeAttribute("activeSql");
      getHttpSession().removeAttribute("pageNum");
      getHttpSession().removeAttribute("rowNum");
      getHttpSession().removeAttribute("OBJECT");
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }

    return null;
  }

  public String backOrg()
  {
    try
    {
      if (this.orgName != null)
        this.orgName = new String(this.orgName.getBytes("ISO-8859-1"), "GBK");
      String[] ids = getServletRequest().getParameterValues("chk");
      String showName = "";
      List list = new ArrayList();
      if ((ids != null) && (ids.length > 0))
      {
        for (int i = 0; i < ids.length; i++) {
          OrgBO bo = SysCacheTool.findOrgById(ids[i]);
          if (bo != null) {
            String orgCode = bo.getOrgCode();
            if ((orgCode != null) && (!"".equals(orgCode))) {
              orgCode = OrgTool.getBackOrgCode(orgCode);
              int count1 = this.orgucc.queryOrgCodeCount(orgCode, bo.getOrgId());
              if (count1 > 0) {
                OrgBO bo1 = SysCacheTool.findOrgByCode(orgCode);
                if (bo1 != null)
                  showName = bo.getName() + "的机构代码与" + bo1.getName() + "重复，请维护机构代码！";
                else
                  showName = bo.getName() + "的机构代码重复！";
              }
              else {
                list.add(ids[i]);
              }
            }
            else {
              list.add(ids[i]);
            }
          }
        }
      }
      if ((showName != null) && (!"".equals(showName.trim()))) {
        getServletRequest().setAttribute("showName", showName);
      }
      if ((list != null) && (list.size() > 0)) {
        String[] orgids = (String[])(String[])list.toArray(new String[0]);
        this.orgucc.updateBackOrg(orgids);

        int count = orgids.length;
        TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");
        table.setSetPk("ORGUID");
        Hashtable rs = table.rowArray2Hash();
        for (int i = 0; i < count; i++) {
          rs.remove(orgids[i]);
        }
        int size2 = rs.size();
        RecordVO[] row = new RecordVO[size2];
        Enumeration values = rs.elements();
        while (values.hasMoreElements()) {
          size2--; row[size2] = ((RecordVO)values.nextElement());
        }
        table.setRowData(row);
        getHttpSession().setAttribute("OBJECT", table);

        SysCache.setMap(orgids, 3, 5);
        this.backRefresh = "1";
        
        //同步财务系统,添加一条机构撤销恢复记录
        for(int i=0;i<orgids.length;i++){
        	OrgBO bo = SysCacheTool.findOrgById(orgids[i]);
			SqlUtil.updateData("insert into b001_bd (change_date,change_type,old_mainDeptID,new_mainDeptID,dept_id,dept_type,dept_name) values " +
        					"(getdate(),'撤销恢复','"+bo.getSuperId()+"','"+bo.getSuperId()+"','"+bo.getOrgId()+"','"+("089110".equals(bo.getorgType())?"单位":"部门")+"','"+bo.getName()+"')");
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute("OBJECT");
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String delOrg()
  {
    try
    {
      if (this.orgName != null)
        this.orgName = new String(this.orgName.getBytes("ISO-8859-1"), "GBK");
      String[] ids = getServletRequest().getParameterValues("chk");
      String showName = "";
      List list = new ArrayList();
      if (ids != null) {
        for (int i = 0; i < ids.length; i++) {
          if (WageTools.checkWageUnit(ids[i]))
            showName = showName + CodeUtil.interpertCode(CodeUtil.TYPE_ORG, ids[i]) + "是发薪机构，不能删除!\\n";
          else {
            list.add(ids[i]);
          }
        }
      }
      if ((list != null) && (list.size() > 0)) {
        String[] orgids = (String[])(String[])list.toArray(new String[0]);
        User user = getUserInfo();
        this.orgucc.checkDelOrgSubOrg(orgids);
        
        //同步财务系统,添加一条机构删除记录
        for(int i=0;i<orgids.length;i++){
        	OrgBO bo = SysCacheTool.findOrgById(orgids[i]);
  			SqlUtil.updateData("insert into b001_bd (change_date,change_type,old_mainDeptID,new_mainDeptID,dept_id,dept_type,dept_name) values " +
        					"(getdate(),'删除','"+bo.getSuperId()+"','"+bo.getSuperId()+"','"+bo.getOrgId()+"','"+("089110".equals(bo.getorgType())?"单位":"部门")+"','"+bo.getName()+"')");
  			SqlUtil.updateData("delete from b001 where id='"+bo.getOrgId()+"'");
        }
        
        this.orgucc.deleteOrg(orgids, user);

        int count = orgids.length;
        TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");
        table.setSetPk("ORGUID");
        Hashtable rs = table.rowArray2Hash();
        for (int i = 0; i < count; i++) {
          rs.remove(orgids[i]);
        }
        int size2 = rs.size();
        RecordVO[] row = new RecordVO[size2];
        Enumeration values = rs.elements();
        while (values.hasMoreElements()) {
          size2--; row[size2] = ((RecordVO)values.nextElement());
        }
        table.setRowData(row);
        getHttpSession().setAttribute("OBJECT", table);

        SysCache.setMap(orgids, 2, 5);
      }
      this.delRefresh = "1";
      
      if ((showName != null) && (!"".equals(showName.trim())))
        super.showMessageDetail(showName);
    }
    catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute("OBJECT");
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }
}