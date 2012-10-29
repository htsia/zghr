<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.org.ucc.impl.OrgUCC" %>
<%@ page import="com.hr319wg.post.ucc.impl.PostUCC" %>
<%@ page import="com.hr319wg.post.pojo.bo.PostBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="java.util.List" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    OrgBO dept = (OrgBO) request.getAttribute("OrgBO");
    PersonBO person = (PersonBO) request.getAttribute("PersonBO");
    if (dept == null || person == null) {
        return;
    }
    OrgUCC ucc = (OrgUCC) SysContext.getBean("org_orgUCCImpl");
    PostUCC postucc = (PostUCC) SysContext.getBean("post_postUCCImpl");
    int weave = ucc.getDeptWeave(dept.getOrgId());
    User user = (User) session.getAttribute(Constants.USER_INFO);
    TableVO tableb706 = postucc.queryPageInfo("B706", null, dept.getOrgId(), user, null, null);
    TableVO tableb707 = postucc.queryPageInfo("B707", null, dept.getOrgId(), user, null, null);
    String changeRecord = "";
    if (tableb706 != null && tableb706.getRowData() != null && tableb706.getRowData().length > 0) {
        for (int j = 0; j < tableb706.getRowData().length; j++) {
            Hashtable ht = tableb706.getRowData()[j].cellArray2Hash();
            CellVO cv =(CellVO)ht.get("B706701");
            if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                changeRecord +=cv.getValue()+"<br>";
            }
        }
    }
%>
   <table width=600 class="style1" align="center">
       <tr><td colspan=8 align="center" bgcolor="gray"><strong>部门职责说明书</strong></td></tr>
       <tr>
           <td><strong>部门名称</strong></td><td><%=dept.getName()%></td>
           <td><strong>编制人数</strong></td><td><%=weave%></td>
           <td><strong>批准日期</strong></td><td><%=CommonFuns.filterNull(dept.getOrgCreateDate())%></td>
       </tr>

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>岗位编制与任职情况</strong></td></tr>

       <tr>
           <td colspan=2><strong>岗位名称</strong></td>
           <td colspan=2><strong>编制人数</strong></td>
           <td colspan=2><strong>现任职人员</strong></td>
       </tr>
       <%
           PostBO[] pbArray = postucc.queryPost(" and p.orgTreeId like '" + dept.getTreeId() + "%'");
           if (pbArray != null) {
               for (int i = 0; i < pbArray.length; i++) {
                   out.println("<tr>");
                   out.println("<td colspan=2>" + pbArray[i].getName() + "</td>");
                   out.println("<td colspan=2>" + CommonFuns.filterNull(pbArray[i].getWorkOut()) + "</td>");
                   List names = postucc.queryPersonBOByPost(pbArray[i].getPostId());
                   String namedes = "";
                   if (names != null && names.size() > 0) {
                       for (int j = 0; j < names.size(); j++) {
                           PersonBO pb=(PersonBO)names.get(j);
                           namedes += " " + pb.getName();
                       }
                    }
                       out.println("<td colspan=2>" + namedes + "</td>");
                       out.println("</tr>");
                   }
               }
       %>
       <tr><td colspan=8 align="center" bgcolor="gray"><strong>部门使命</strong></td></tr>
       <tr><td colspan=8 align="center" height=40><%=CommonFuns.filterNull(dept.getOrgTask())%></td></tr>

       <tr><td colspan=8 align="center" bgcolor="gray"><strong>部门职责变更</strong></td></tr>
       <tr><td colspan=8 align="center" height=40>
           <%=changeRecord%>
       </td></tr>

        <tr><td colspan=8 align="center" bgcolor="gray"><strong>部门职责</strong></td></tr>
        <tr><td colspan=2 align="center" height=20><strong>职责概述</strong></td><td colspan=4 align="center" height=20><strong>职责内容</strong></td></tr>
        <%
          if (tableb707 != null && tableb707.getRowData() != null && tableb707.getRowData().length > 0) {
              for (int j = 0; j < tableb707.getRowData().length; j++) {
                  Hashtable ht = tableb707.getRowData()[j].cellArray2Hash();
                  String row="<tr><td colspan=2 align=center height=20>";
                  CellVO cv =(CellVO)ht.get("B707701");
                  if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                      row+=cv.getValue();
                  }
                  row+="</td><td colspan=4 align=center height=20>";
                  cv =(CellVO)ht.get("B707702");
                  if (cv!=null && cv.getValue()!=null && !"".equals(cv.getValue())){
                      row+=cv.getValue();
                  }
                  row+="</td></tr>";
                  out.println(row);
              }
           }
        %>
        <tr><td colspan=2 align="center" height=20></td><td colspan=4 align="center" height=20></td></tr>
   </table>