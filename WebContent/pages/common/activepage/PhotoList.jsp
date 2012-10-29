<%@page import="java.io.File"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.emp.ucc.IAddressUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.emp.pojo.vo.AddressVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<script language=javascript src="/js/list.js"></script>
<input type="hidden" name="pageFlag">
<input type="hidden" name="pageNum">

<%
    String basepath = application.getRealPath("/");
    AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");

    //从request里得到TableVO,键值request.getAttribute(tableId)
    String tableId = request.getParameter("target");
    if (tableId == null || "".equals(tableId.trim())) {
        tableId = Constants.OBJECT;
    }
    //从request得到TableVO
    TableVO table = (TableVO) request.getAttribute(tableId);
    //如果request里没有，则从session里取
    if (table == null) {
        table = (TableVO) session.getAttribute(tableId);
    }
    //每页显示的记录数
    String rowNum = (String) session.getAttribute("rowNum");

    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    out.println("<table width=100% border=0 cellpadding=0 cellspacing=0 align=center class='table03' id='paget'>");
    //第几页
    String pageNum = (String) session.getAttribute("pageNum");
    //总页数
    int toalPageNum = table.getRecordNum() / Integer.parseInt(rowNum);
    if (table.getRecordNum() % Integer.parseInt(rowNum) > 0) {
        toalPageNum++;
    }
    //分页部分在列表页面占一行,并且只占一列
    out.println("<tr >");
    //如果有前台函数，则分页部分合并单元格比原来列数多一列
    out.println("<td id=\"locked\" nowrap style='z-index:3' class='locked_top' >");
    //画分页部分
    StringBuffer turnpage = new StringBuffer("&nbsp;<font color=red>共计" + table.getRecordNum() + "条记录&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    turnpage.append("共" + toalPageNum + "页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    turnpage.append("<input  class=input type=text size=5 name=rowNum value=" + Integer.parseInt(rowNum) + " onkeypress=\"gotoNextPage('1')\">条/页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
    turnpage.append("当前第 " + pageNum + " 页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

    if (pageNum == null)
        pageNum = "1";
    int next = (Integer.parseInt(pageNum) / 10 + 1) * 10 + 1;
    int upper = (Integer.parseInt(pageNum) / 10) * 10;
    if (Integer.parseInt(pageNum) % 10 == 0) {
        next = Integer.parseInt(pageNum) + 1;
        upper = Integer.parseInt(pageNum) - 10;
    }
    if (Integer.parseInt(pageNum) > 10 && Integer.parseInt(pageNum) < toalPageNum && toalPageNum > 10 && upper > 0) {
        turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + upper + "')\">上一页</a>&nbsp;");
    }
    for (int k = upper + 1; k <= toalPageNum && k < next; k++) {
        turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + k + "')\">" + k + "</a>&nbsp;");
    }
    if (Integer.parseInt(pageNum) > 0 && Integer.parseInt(pageNum) < toalPageNum && toalPageNum > 10 && next < toalPageNum) {
        turnpage.append("<a style='cursor:hand' onclick=\"forpage('" + next + "')\">下一页</a>&nbsp;");
    }
    out.println(turnpage.toString());
    out.println("</font></td>");

    out.println("</tr>");
    out.println("</table>");

%>
   <table  cellspacing=10 border=0>
        <%
            IAddressUCC rc = (IAddressUCC) SysContext.getBean("emp_addressUCC");
            if (table != null && table.getRowData()!=null && table.getRowData().length>0) {
                RecordVO[] rows = table.getRowData();
                String keyName = request.getParameter("keyName");
                int rownum = rows == null ? 0 : rows.length;
                // 处理主键
                if (keyName == null || "".equals(keyName)) {
                    if (table.getSetId() != null && !"".equals(table.getSetId())) {
                        keyName = table.getSetPk();//子集的主键
                    } else if (rownum > 0) {
                        String setType = rows[0].getCell()[0].getSetId().substring(0, 1);//子集是A类还是B类
                        keyName = InfoSetBO.getPkType(setType);
                    }
                }


                int idIndex = rows[0].getCellIndex(keyName);
                for (int i = 0; i < rows.length; i++) {
                    PersonBO pb = SysCacheTool.findPersonById(rows[i].getCell()[idIndex].getValue());
                    String id = pb.getPersonId();
                    String name = pb.getName();
                    String dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId());
                    String post = CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                    String img = "/images/common/nophoto.JPG";
                    if (pb.getImageId() != null) {
                        img = "/file/tmp/" + pb.getImageId() + ".JPG";
                        if (!aucc.checkAttachFileExist(basepath, pb.getImageId())) {
                            aucc.getFileContentToFile(basepath, pb.getImageId());
                        }
                    }
                    File f = new File(basepath+img);
                    if(!f.exists()){
                    	img = "/images/common/nophoto.JPG";
                    }
                    AddressVO avo = rc.getAddressInfo(pb.getPersonId());
                    String officetel = "";
                    String mobile = "";
                    String email = "";
                    if (avo != null) {
                        officetel = CommonFuns.filterNull(avo.getOfficeTel());
                        mobile = CommonFuns.filterNull(avo.getMobile());
                        email = CommonFuns.filterNull(avo.getEmail());
                    }
        %>
                <tr>
                    <td width=180 align="left" valign="top">
                            <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                            <strong>姓名:</strong><%=name%><br>
                            <strong>部门:</strong><%=dept%><br>
                            <strong>岗位:</strong><%=post%><br>
                            <strong>办公电话:</strong><%=officetel%><br>
                            <strong>移动电话:</strong><%=mobile%><br>
                            <strong>电子邮件:</strong><br><%=email%><br>
                     </td>
         <%
                    i++;
                    if (i>=rows.length) break;
                    pb = SysCacheTool.findPersonById(rows[i].getCell()[idIndex].getValue());
                    id = pb.getPersonId();
                    name = pb.getName();
                    dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                    post = CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                    img="/images/common/nophoto.JPG";
                    avo = rc.getAddressInfo(pb.getPersonId());
                    officetel="";
                    mobile="";
                    email="";
                    if (avo!=null){
                         officetel=CommonFuns.filterNull(avo.getOfficeTel());
                         mobile=CommonFuns.filterNull(avo.getMobile());
                         email=CommonFuns.filterNull(avo.getEmail());
                     }
             if (pb.getImageId() != null) {
                 img = "/file/tmp/" + pb.getImageId() + ".JPG";
                 if (!aucc.checkAttachFileExist(basepath, pb.getImageId())) {
                     aucc.getFileContentToFile(basepath, pb.getImageId());
                 }
             }
             f = new File(basepath+img);
             if(!f.exists()){
             	img = "/images/common/nophoto.JPG";
             }

        %>
                    <td width=180 align="left" valign="top">
                            <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                            <strong>姓名:</strong><%=name%><br>
                            <strong>部门:</strong><%=dept%><br>
                            <strong>岗位:</strong><%=post%><br>
                            <strong>办公电话:</strong><%=officetel%><br>
                            <strong>移动电话:</strong><%=mobile%> <br>
                            <strong>电子邮件:</strong><br><%=email%> <br>
                     </td>
                  <%
                               i++;
                               if (i>=rows.length) break;
                               pb = SysCacheTool.findPersonById(rows[i].getCell()[idIndex].getValue());
                               id = pb.getPersonId();
                               name = pb.getName();
                               dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                               post=CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                              img="/images/common/nophoto.JPG";
                      if (pb.getImageId() != null) {
                          img = "/file/tmp/" + pb.getImageId() + ".JPG";
                          if (!aucc.checkAttachFileExist(basepath, pb.getImageId())) {
                              aucc.getFileContentToFile(basepath, pb.getImageId());
                          }
                      }
                      f = new File(basepath+img);
                      if(!f.exists()){
                      	img = "/images/common/nophoto.JPG";
                      }       
                              avo = rc.getAddressInfo(pb.getPersonId());
                              officetel="";
                              mobile="";
                              email="";
                              if (avo!=null){
                                   officetel=CommonFuns.filterNull(avo.getOfficeTel());
                                   mobile=CommonFuns.filterNull(avo.getMobile());
                                   email=CommonFuns.filterNull(avo.getEmail());
                               }
                   %>
                               <td width=180 align="left" valign="top">
                                   <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                   <strong>姓名:</strong><%=name%><br>
                                   <strong>部门:</strong><%=dept%><br>
                                   <strong>岗位:</strong><%=post%><br>
                                   <strong>办公电话:</strong><%=officetel%> <br>
                                   <strong>移动电话:</strong><%=mobile%> <br>
                                   <strong>电子邮件:</strong><br><%=email%><br>
                                </td>

                    <%
                                 i++;
                                 if (i>=rows.length) break;
                                 pb = SysCacheTool.findPersonById(rows[i].getCell()[idIndex].getValue());
                                 id = pb.getPersonId();
                                 name = pb.getName();
                                 dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                                 post=CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                                 img="/images/common/nophoto.JPG";
                        if (pb.getImageId() != null) {
                            img = "/file/tmp/" + pb.getImageId() + ".JPG";
                            if (!aucc.checkAttachFileExist(basepath, pb.getImageId())) {
                                aucc.getFileContentToFile(basepath, pb.getImageId());
                            }
                        }
                        f = new File(basepath+img);
                        if(!f.exists()){
                        	img = "/images/common/nophoto.JPG";
                        }
                                avo = rc.getAddressInfo(pb.getPersonId());
                                officetel="";
                                mobile="";
                                email="";
                                if (avo!=null){
                                     officetel=CommonFuns.filterNull(avo.getOfficeTel());
                                     mobile=CommonFuns.filterNull(avo.getMobile());
                                     email=CommonFuns.filterNull(avo.getEmail());
                                 }
                     %>
                                 <td width=180 align="left" valign="top">
                                     <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                     <strong>姓名:</strong><%=name%><br>
                                     <strong>部门:</strong><%=dept%><br>
                                     <strong>岗位:</strong><%=post%><br>
                                     <strong>办公电话:</strong><%=officetel%> <br>
                                     <strong>移动电话:</strong><%=mobile%><br>
                                     <strong>电子邮件:</strong><br><%=email%><br>
                                  </td>

                </tr>
        <%
                }
            }
        %>
    </table>
    <script type="text/javascript">
        var rowNum = <%=rowNum%>;
    </script>