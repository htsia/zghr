package com.hr319wg.post.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.org.ucc.IOrgUCC;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.ucc.IPostUCC;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CommonFuns;

public class PostEditBackingBean extends BaseBackingBean
{
  private String OPER_ID = "0217";
  private List regTableList;
  private String table;
  private String list;
  private IOrgUCC orgucc;
  private IPostUCC postucc;
  private IUserReportUCC userreportucc;
  private IPersonUCC personucc;

  public IPersonUCC getPersonucc()
  {
    return this.personucc;
  }

  public void setPersonucc(IPersonUCC personucc) {
    this.personucc = personucc;
  }

  public void setUserreportucc(IUserReportUCC iur)
  {
    this.userreportucc = iur;
  }
  public IUserReportUCC getUserreportucc() {
    return this.userreportucc;
  }

  public List getRegTableList() {
    try {
      this.regTableList = this.userreportucc.queryUserRptToWeb(super.getUserInfo().getUserId(), this.OPER_ID, UserRptVO.TYPE_REG);
    }
    catch (Exception e) {
      this.regTableList = new ArrayList();
    }
    return this.regTableList;
  }
  public void setRegTableList(List li) {
    this.regTableList = li;
  }

  public String getTable() {
    String tableId = getServletRequest().getParameter("tableId");
    if ((tableId == null) || ("".equals(tableId.trim())))
      tableId = "OBJECT_DETAIL";
    try
    {
      User user = getUserInfo();
      String setId = getServletRequest().getParameter("setId");
      if (setId == null) {
        setId = (String)super.getHttpSession().getAttribute("doc_C_setId");
      }
      String fk = getServletRequest().getParameter("fk");
      String pk = getServletRequest().getParameter("pk");
      String flag = getServletRequest().getParameter("flag");
      String where = getServletRequest().getParameter("where");
      if (flag == null) flag = "2";
      if ("2".equals(flag)) {
        TableVO table = (TableVO)getHttpSession().getAttribute(tableId);
        if ((fk == null) || ("".equals(fk))) {
          if ("C001".equals(setId))
          {
            table = this.orgucc.findNewPage(setId, user);
          }
        } else {
          InfoSetBO infoSet = SysCacheTool.findInfoSet(setId);
          if (InfoSetBO.RS_TYPE_SINGLE.equals(infoSet.getSet_rsType()))
            table = this.orgucc.queryPageInfo(setId, fk, "", user);
          else {
            table = this.orgucc.queryPageInfo(setId, pk, fk, user);
          }
        }
        getHttpSession().setAttribute(tableId, table);
      }
      if ("C001".equals(setId)) {
        getHttpSession().removeAttribute("OBJECT");
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");

        TableVO table = new TableVO();
        String addcontion = "A001715='" + fk + "'";
        if(where!=null && !"".equals(where)){
        	addcontion+=" and "+where;
        }
        String sql = this.personucc.queryPersonList(table, "", "", "", 1, 100, "", null, "156", addcontion);
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf("1"));
        getHttpSession().setAttribute("OBJECT", table);
      }
    }
    catch (Exception e) {
      getHttpSession().removeAttribute(tableId);
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    return this.table;
  }

  public void setTable(String table) {
    this.table = table;
  }

  public IOrgUCC getOrgucc() {
    return this.orgucc;
  }

  public void setOrgucc(IOrgUCC orgucc) {
    this.orgucc = orgucc;
  }

  public String getList()
  {
    return this.list;
  }

  public void setList(String list) {
    this.list = list;
  }

  public IPostUCC getPostucc()
  {
    return this.postucc;
  }

  public void setPostucc(IPostUCC postucc) {
    this.postucc = postucc;
  }

  public String saveOne()
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

      if ((!user.ischo()) && (dataMap != null) && ("C001".equals(((String[])(String[])dataMap.get("setId"))[0]))) {
        boolean pmsPostType = false;
        Hashtable pmsCodes = user.getPmsOperateCode();
        List postTypes = (List)pmsCodes.get("0110");
        if (postTypes != null)
        {
          String strPostType = "";
          for (int i = 0; i < postTypes.size(); i++) {
            CodeItemBO item = (CodeItemBO)postTypes.get(i);
            if (item != null)
              strPostType = strPostType + item.getItemId() + ",";
          }
          String[] postCs = (String[])(String[])dataMap.get("C001001");
          String postClass = null;
          if ((postCs != null) && (postCs.length > 0)) {
            postClass = postCs[0];
          }
          if ((postClass != null) && (!"".equals(postClass)))
          {
            if (strPostType.indexOf(postClass) != -1)
              pmsPostType = true;
          }
          else {
            pmsPostType = true;
          }
          if (!pmsPostType) {
            CodeItemBO item = SysCacheTool.findCodeItem("0110", postClass);
            if (item != null)
              showMessageDetail("你没有权限将岗位分类代码修改成{" + item.getItemName() + "},请选择其他岗位分类代码!");
            else
              showMessageDetail("你没有修改岗位分类代码的权限,请选择其他岗位分类代码!");
            return "";
          }
        }
      }
      Map ee = new HashMap();
      ee.putAll(dataMap);
      if ("C001".equals(table.getSetId())) {
        String[] postId = (String[])(String[])ee.get("POSTID");
        if ((postId != null) && (postId.length > 0)) {
          PostBO bo = SysCacheTool.findPost(postId[0]);
          String[] orgIds = (String[])(String[])ee.get("C001010");
          if ((orgIds != null) && (orgIds.length > 0)) {
            String orgId = CommonFuns.filterNull(orgIds[0]);
            if (!orgId.equals(bo.getOrgId())) {
              String postCode = this.postucc.buildPostCode(orgId);
              ee.put("C001003", new String[] { CommonFuns.filterNull(postCode) });
            }
          }
        }
      }
      if ("C001".equals(table.getSetId())) {
        String[] postNames = (String[])(String[])dataMap.get("C001005");
        if (postNames != null) {
          if ((postNames[0] == null) || ("".equals(postNames[0]))) {
            showMessageDetail("岗位名称为空，不能保存!");
            isEmpty = true;
            return null;
          }
        } else {
          isEmpty = true;
          showMessageDetail("岗位名称为空，不能保存!");
          return null;
        }
      }

      this.orgucc.updatePageInfo(table, ee, user);
      String pkvalue = getServletRequest().getParameter("pk");
      if ((pkvalue != null) && (!"".equals(pkvalue))) {
        SysCache.setMap(new String[] { pkvalue }, 3, 7);
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

      TableVO table = this.orgucc.queryPageInfo(setId, pk, fk, user);
      getHttpSession().setAttribute(tableId, table);
      getServletRequest().setAttribute("flag", flag);
    } catch (Exception e) {
      e.printStackTrace();
      getHttpSession().removeAttribute(tableId);
      this.msg.setMainMsg(e, getClass());
    }
    return "info";
  }
  public String setCurrent() {
    try {
      String setId = getServletRequest().getParameter("setId");
      String pk = getServletRequest().getParameter("curID");
      this.postucc.setCurrent(setId, pk);
    }
    catch (Exception e)
    {
    }
    return "";
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
      getHttpSession().removeAttribute(tableId);
      e.printStackTrace();
      this.msg.setMainMsg(e, getClass());
    }
    return null;
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
      if ("C008".equals(setId))
        showMessageDetail("保存成功!工作时间比重的和应为100%!");
      else
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