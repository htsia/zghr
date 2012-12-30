package com.hr319wg.org.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.faces.model.SelectItem;

import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.org.pojo.bo.OrgEditTemplateBO;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.RecordVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.util.CommonFuns;

public class OrgEditBackingBean extends BaseBackingBean
{
  private String table;
  private String list;
  private IOrgUCC orgucc;
  private String mb;
  private List mbList;
  private String setId;
  private String fk;
  private String pk;

  public String getFk()
  {
    return this.fk;
  }
  public void setFk(String id) {
    this.fk = id;
  }

  public String getPk() {
    return this.pk;
  }
  public void setPk(String id) {
    this.pk = id;
  }

  public String getSetId() {
    return this.setId;
  }
  public void setSetId(String id) {
    this.setId = id;
  }
  public String getPageInit() {
    if (getServletRequest().getParameter("setId") != null) {
      this.setId = getServletRequest().getParameter("setId");
      this.fk = getServletRequest().getParameter("fk");
      this.pk = getServletRequest().getParameter("pk");
      this.mbList = new ArrayList();
      try {
        List list = this.orgucc.findOrgTemplate(this.setId);
        SelectItem si0 = new SelectItem();
        si0.setLabel("==全部项目==");
        si0.setValue("-1");
        this.mbList.add(si0);
        for (int i = 0; i < list.size(); i++) {
          OrgEditTemplateBO oo = (OrgEditTemplateBO)list.get(i);
          SelectItem si = new SelectItem();
          si.setLabel(oo.getTempDes());
          si.setValue(oo.getTempid());
          this.mbList.add(si);
        }
      }
      catch (Exception e)
      {
      }
    }
    return this.pageInit;
  }

  public List getMbList() {
    return this.mbList;
  }
  public void setMbList(List list) {
    this.mbList = list;
  }

  public String getMb() {
    return this.mb;
  }
  public void setMb(String b) {
    this.mb = b;
  }

  public String getTable() {
    String tableId = getServletRequest().getParameter("tableId");
    try {
      this.setId = getServletRequest().getParameter("setId");
      this.fk = getServletRequest().getParameter("fk");
      this.pk = getServletRequest().getParameter("pk");
      String flag = getServletRequest().getParameter("flag");

      if ((tableId == null) || ("".equals(tableId.trim()))) {
        tableId = "OBJECT_DETAIL";
      }
      if ("2".equals(flag)) {
        User user = getUserInfo();
        TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
        if ((this.fk == null) || ("".equals(this.fk))) {
          if ("B001".equals(this.setId))
          {
            table = this.orgucc.findNewPage(this.setId, user);
          }
        } else if (this.setId != null) {
          InfoSetBO infoSet = SysCacheTool.findInfoSet(this.setId);
          if (InfoSetBO.RS_TYPE_SINGLE.equals(infoSet.getSet_rsType()))
            table = this.orgucc.queryPageInfo(this.setId, this.fk, "", user);
          else {
            table = this.orgucc.queryPageInfo(this.setId, this.pk, this.fk, user);
          }
        }
        getHttpSession().setAttribute(tableId, table);
      }
    }
    catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute(tableId);
      this.msg.setMainMsg(e, getClass());
    }
    return this.table;
  }

  public void setTable(String table) {
    this.table = table;
  }

  public String getList() {
    return this.list;
  }

  public String changeView() {
    try {
      InfoSetBO infoSet = SysCacheTool.findInfoSet(this.setId);
      TableVO table = null;
      if (InfoSetBO.RS_TYPE_SINGLE.equals(infoSet.getSet_rsType()))
        table = this.orgucc.queryPageInfo(this.setId, this.fk, "", super.getUserInfo());
      else {
        table = this.orgucc.queryPageInfo(this.setId, this.pk, this.fk, super.getUserInfo());
      }

      OrgEditTemplateBO oo = this.orgucc.findOrgTemplateByID(this.mb);
      if ((oo != null) && (oo.getFields() != null)) {
        List field = new ArrayList();
        for (int i = 0; i < table.getHeader().length; i++) {
          if (oo.getFields().indexOf(table.getHeader()[i].getItemId()) < 0) {
            table.getHeader()[i].setItemProperty(InfoItemBO.PROPERTY_CONTROL_HIDE);
            RecordVO[] rv = table.getRowData();
            if (rv != null) {
              for (int j = 0; j < rv.length; j++) {
                rv[j].getCell()[i].setItemProperty(InfoItemBO.PROPERTY_CONTROL_HIDE);
              }
            }
          }
        }
      }
      getHttpSession().setAttribute("OBJECT_DETAIL", table);
    }
    catch (Exception e)
    {
    }
    return "";
  }
  public void setList(String list) {
    this.list = list;
  }

  public IOrgUCC getOrgucc() {
    return this.orgucc;
  }

  public void setOrgucc(IOrgUCC orgucc) {
    this.orgucc = orgucc;
  }

  public String saveInputView()
  {
    boolean isEmpty = false;
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();

      TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
      Map dataMap = getServletRequest().getParameterMap();
      this.orgucc.updatePageInfo(table, dataMap, user);
      showMessageDetail("保存成功!");
    } catch (Exception e) {
      if (isEmpty) {
        System.out.println("时间:" + CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss") + "数据被清空:");
      }
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    return "";
  }

  public String saveOne() {
    boolean isEmpty = false;
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();
      String pkvalue = getServletRequest().getParameter("pk");

      OrgBO bo = SysCacheTool.findOrgById(pkvalue);
      
      TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
      Map dataMap = getServletRequest().getParameterMap();

      Map ee = new HashMap();
      ee.putAll(dataMap);

      String[] orgNames = (String[])(String[])dataMap.get("B001005");
      if ("B001".equals(table.getSetId())) {
        if (orgNames != null) {
          if ((orgNames[0] == null) || ("".equals(orgNames[0]))) {
            showMessageDetail("机构名称为空，不能保存!");
            isEmpty = true;
            return null;
          }
        } else {
          isEmpty = true;
          showMessageDetail("机构名称为空，不能保存!");
          return null;
        }
      }
      
      //同步财务中间库,添加一条部门信息维护记录
      if("B001".equals(table.getSetId()) && !bo.getName().equals(orgNames[0])){
    	  SqlUtil.updateData("insert into b001_bd (change_date,change_type,old_mainDeptID,new_mainDeptID,dept_id,dept_type,dept_name) values " +
					"(getdate(),'信息维护','"+bo.getSuperId()+"','"+bo.getSuperId()+"','"+bo.getOrgId()+"','"+("089110".equals(bo.getorgType())?"单位":"部门")+"','"+orgNames[0]+"')");
    	  SqlUtil.updateData("update b001 set b001005='"+orgNames[0]+"' where id='"+bo.getOrgId()+"'");
	  }
      
      byte[] photo = (byte[])(byte[])getHttpSession().getAttribute("B001082");
      if (photo != null) {
        Map imageMap = new HashMap();
        imageMap.put("B001082", photo);
        this.orgucc.updatePageInfo(table, ee, user, imageMap);
      }
      else {
        this.orgucc.updatePageInfo(table, ee, user);
      }
      if ((pkvalue != null) && (!"".equals(pkvalue))) {
        SysCache.setMap(new String[] { pkvalue }, 3, 5);
      }
      String[] superId = (String[])(String[])dataMap.get("B001002");
      if ((superId != null) && (superId.length > 0)) {
        SysCache.updateSubStrMap(3, null, superId[0]);
      }
      table = this.orgucc.queryPageInfo(getServletRequest().getParameter("setId"), getServletRequest().getParameter("pk"), getServletRequest().getParameter("fk"), user);
      showMessageDetail("保存成功!");
    } catch (Exception e) {
      if (isEmpty) {
        System.out.println("时间:" + CommonFuns.getSysDate("yyyy-MM-dd HH:mm:ss") + "数据被清空:");
      }

      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }

  public String addMany()
  {
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();
      String setId = getServletRequest().getParameter("setId");
      String fk = getServletRequest().getParameter("fk");
      String pk = getServletRequest().getParameter("pk");
      String flag = getServletRequest().getParameter("flag");

      TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
      table = this.orgucc.findNewPage(setId, user);
      getHttpSession().setAttribute(tableId, table);
      getServletRequest().setAttribute("flag", flag);
    }
    catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute(tableId);
      this.msg.setMainMsg(e, getClass());
    }
    return "info";
  }

  public String updateMany()
  {
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();
      String setId = getServletRequest().getParameter("setId");
      String fk = getServletRequest().getParameter("fk");
      String pk = getServletRequest().getParameter("pk");
      String flag = getServletRequest().getParameter("flag");

      TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
      table = this.orgucc.queryPageInfo(setId, pk, fk, user);
      getHttpSession().setAttribute(tableId, table);
      getServletRequest().setAttribute("flag", flag);
    }
    catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute(tableId);
      this.msg.setMainMsg(e, getClass());
    }
    return "info";
  }

  public String delMany()
  {
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();
      String[] delId = getServletRequest().getParameterValues("chk");
      String setId = getServletRequest().getParameter("setId");
      String fk = getServletRequest().getParameter("fk");
      String pk = getServletRequest().getParameter("pk");
      String flag = getServletRequest().getParameter("flag");

      TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
      this.orgucc.delPageInfo(table, delId, user);
      table = this.orgucc.queryPageInfo(setId, pk, fk, user);
      getHttpSession().setAttribute(tableId, table);
      showMessageDetail("删除成功!");
    } catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute(tableId);
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }
  public String setCurrent() {
    try {
      String setId = getServletRequest().getParameter("setId");
      String pk = getServletRequest().getParameter("curID");
      this.orgucc.setCurrent(setId, pk);
    }
    catch (Exception e)
    {
    }
    return "";
  }

  public String saveManyAdd()
  {
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();
      String setId = getServletRequest().getParameter("setId");
      String fk = getServletRequest().getParameter("fk");
      String pk = getServletRequest().getParameter("pk");
      String flag = getServletRequest().getParameter("flag");

      TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
      Map dataMap = getServletRequest().getParameterMap();
      this.orgucc.addPageInfo(table, dataMap, user);
      table = this.orgucc.queryPageInfo(setId, "", fk, user);
      getHttpSession().setAttribute(tableId, table);
      showMessageDetail("保存成功!");
    }
    catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute(tableId);
      this.msg.setMainMsg(e, getClass());
    }
    return "list";
  }

  public String saveManyUpdate()
  {
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();
      String setId = getServletRequest().getParameter("setId");
      String fk = getServletRequest().getParameter("fk");
      String pk = getServletRequest().getParameter("pk");

      TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
      Map dataMap = getServletRequest().getParameterMap();
      this.orgucc.updatePageInfo(table, dataMap, user);
      table = this.orgucc.queryPageInfo(setId, "", fk, user);
      getHttpSession().setAttribute(tableId, table);
      showMessageDetail("保存成功!");
    } catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute(tableId);
      this.msg.setMainMsg(e, getClass());
    }
    return "list";
  }

  public String back() {
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();
      String setId = getServletRequest().getParameter("setId");
      String fk = getServletRequest().getParameter("fk");
      String pk = getServletRequest().getParameter("pk");

      TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
      table = this.orgucc.queryPageInfo(setId, "", fk, user);
      getHttpSession().setAttribute(tableId, table);
    } catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute(tableId);
      this.msg.setMainMsg(e, getClass());
    }
    return "list";
  }
}