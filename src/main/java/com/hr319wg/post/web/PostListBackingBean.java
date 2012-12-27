package com.hr319wg.post.web;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.Constants;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.custom.util.SqlUtil;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.post.ucc.IPostUCC;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCache;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.vo.RecordVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.pojo.vo.UserRptVO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.util.CommonFuns;

public class PostListBackingBean extends BaseBackingBean
{
  private String OPER_ID = "0217";
  private List regTableList;
  private IPostUCC postucc;
  private String postID;
  private String postName;
  private String superId;
  private String changeId;
  private String superName;
  private String postList;
  private IUserReportUCC userreportucc;

  public String getPostID()
  {
    return this.postID;
  }

  public void setPostID(String postID) {
    this.postID = postID;
  }

  public String getPageInit()
  {
    if (super.getRequestParameter("PostIDs") != null) {
      this.postID = super.getRequestParameter("PostIDs");
      String[] ids = this.postID.split(",");
      this.postName = "";
      for (int i = 0; i < ids.length; i++) {
        if ("".equals(this.postName)) {
          this.postName = CodeUtil.interpertCode(CodeUtil.TYPE_POST, ids[i]);
        }
        else {
          this.postName = (this.postName + "," + CodeUtil.interpertCode(CodeUtil.TYPE_POST, ids[i]));
        }
      }
    }
    return "";
  }
  public String changeSuper() {
    try {
      this.postucc.changePostSuper(this.postID, this.changeId);
      //增加人员变动信息
      ActivePageAPI api = (ActivePageAPI)SysContext.getBean("sys_activePageApi");
      String sql = "select wm_concat(id) from a001 where "+CommonFuns.splitInSql(this.postID.split(","), "a001715");
      String userID=api.queryForString(sql);
      if(userID!=null && !"".equals(userID)){
    	  //增加人员变动信息
    	  SqlUtil.updateData("insert into a001_bd (user_id,change_date,change_type,old_dept_id,new_dept_id,user_type,name,user_code) " +
    			  "select id,getdate(),'部门变动',a001705,'"+this.changeId+"',a001054,a001001,a001735 from a001 where "+CommonFuns.splitInSql(userID.split(","), "id"));			
    	  //人员信息修改
    	  SqlUtil.updateData("update a001 set a001705='"+this.changeId+"' where "+CommonFuns.splitInSql(userID.split(","), "id"));			    	  
      }
    }
    catch (Exception e)
    {
    	e.printStackTrace();
    }
    return "success";
  }
  public String getChangeId() {
    return this.changeId;
  }
  public void setChangeId(String changeId) {
    this.changeId = changeId;
  }

  public void setUserreportucc(IUserReportUCC iur)
  {
    this.userreportucc = iur;
  }
  public IUserReportUCC getUserreportucc() {
    return this.userreportucc;
  }

  public String getSuperName() {
    if (this.superId != null) {
      this.superName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, this.superId);
    }
    return this.superName;
  }
  public void setSuperName(String superName) {
    this.superName = superName;
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

  public IPostUCC getPostucc() {
    return this.postucc;
  }
  public void setPostucc(IPostUCC postucc) {
    this.postucc = postucc;
  }

  public String getPostName() {
    return this.postName;
  }
  public void setPostName(String postName) {
    this.postName = postName;
  }

  public String getSuperId() {
    return this.superId;
  }
  public void setSuperId(String superId) {
    this.superId = superId;
  }

  public String getPostList() {
    String pageFlag = getServletRequest().getParameter("pageFlag");
    String flag = getServletRequest().getParameter("flag");
    String sessionFlag = getServletRequest().getParameter("sessionFlag");
    if (sessionFlag == null) {
      getHttpSession().removeAttribute("OBJECT");
    }
    if ("1".equals(pageFlag)) {
      try {
        String rowNums = getServletRequest().getParameter("rowNum");
        int pageNum = (getServletRequest().getParameter("pageNum") == null) || ("".equals(getServletRequest().getParameter("pageNum"))) ? 1 : Integer.parseInt(getServletRequest().getParameter("pageNum"));

        String sql = (String)getHttpSession().getAttribute("activeSql");

        TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");
        int rowNum = Constants.ACTIVE_PAGE_SIZE;
        if (rowNums != null) {
          rowNum = Integer.parseInt(rowNums);
        }
        User user = getUserInfo();
        this.postucc.querySql(table, sql, user, pageNum, rowNum);
        getHttpSession().setAttribute("OBJECT", table);
        getHttpSession().setAttribute("activeSql", sql);
        getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
        getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
      }
      catch (Exception e) {
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
        getHttpSession().removeAttribute("OBJECT");
        e.printStackTrace();
        this.msg.setMainMsg(e, getClass());
      }
    }
    if ("1".equals(flag)) {
      try {
        getHttpSession().removeAttribute("OBJECT");
        getHttpSession().removeAttribute("activeSql");
        getHttpSession().removeAttribute("pageNum");
        getHttpSession().removeAttribute("rowNum");
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
        String sql = this.postucc.queryPostList(table, this.postName, this.superId, 1, rowNum, "00900", user);
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
    return this.postList;
  }

  public void setPostList(String postList) {
    this.postList = postList;
  }

  public String queryPost() {
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
      String sql = this.postucc.queryPostList(table, this.postName, this.superId, 1, rowNum, "00900", user);
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

  public String delPost() {
    try {
      String[] ids = getServletRequest().getParameterValues("chk");
      List list = new ArrayList();
      if ((ids != null) && (ids.length > 0)) {
        String showName = "";
        String showPost = "";
        for (int i = 0; i < ids.length; i++) {
          PostBO bo = SysCacheTool.findPost(ids[i]);
          if (bo != null) {
            int count1 = this.postucc.queryLowPostNumPost(ids[i]);
            if (count1 > 0)
              showPost = showPost + bo.getName() + "下还有岗位,不能删除!\\n";
            else {
              list.add(ids[i]);
            }
            int count = this.postucc.queryPersonByPost(ids[i]);
            if (count > 0) {
              showName = showName + bo.getName() + "岗位有人!\\n";
            }
          }
        }
        if ((showPost != null) && (!"".equals(showPost.trim()))) {
          getServletRequest().setAttribute("showPost", showPost);
        }

        if ((showName != null) && (!"".equals(showName.trim()))) {
          getServletRequest().setAttribute("showName", showName);
        }
        User user = getUserInfo();
        if ((list != null) && (list.size() > 0)) {
          String[] postids = (String[])(String[])list.toArray(new String[0]);
          this.postucc.deletePost(postids, user);

          int count = list.size();
          TableVO table = (TableVO)getHttpSession().getAttribute("OBJECT");
          if (table != null) {
            table.setSetPk("POSTID");
            Hashtable rs = table.rowArray2Hash();
            for (int i = 0; i < count; i++) {
              rs.remove(postids[i]);
            }
            int size2 = rs.size();
            RecordVO[] row = new RecordVO[size2];
            Enumeration values = rs.elements();
            while (values.hasMoreElements()) {
              size2--; row[size2] = ((RecordVO)values.nextElement());
            }
            table.setRowData(row);
            getHttpSession().setAttribute("OBJECT", table);
          }
        }

        SysCache.setMap(ids, 2, 7);
      }
    } catch (Exception e) {
      getHttpSession().removeAttribute("OBJECT");
      this.msg.setMainMsg(e, getClass());
    }
    return null;
  }
}