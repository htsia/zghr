<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.emp.pojo.bo.EmpBlackSheetBO" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function doAdd(){
         window.showModalDialog("/employee/add/addBlack.jsf", null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
         return true;
    }
    function doDelete(id){
        if (confirm("确定要删除吗?")){
            disPlayProcessBar();
            document.all("form1:personIds").value=id;
            document.all("form1:delete").click();
        }
    }
</script>

<x:saveState value="#{emp_blacksheetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_blacksheetBB.pageInit}"/>

    <f:verbatim>
    <table height=96% width=100% >
     <tr><td height=8 class=td_title>
    </f:verbatim>
           <h:graphicImage value="/images/tips.gif" />
           <h:outputText value="黑名单"/>
     <f:verbatim>
         </td>
      </tr>

      <tr>
      <td  height=8 align="right">
     </f:verbatim>
          <h:outputText value="记录数:#{emp_blacksheetBB.mypage.totalRecord}"></h:outputText>
          <h:outputText value="  "></h:outputText>
          <h:outputText value="页数:#{emp_blacksheetBB.mypage.totalPage}"></h:outputText>
          <h:outputText value="  "></h:outputText>
          <h:outputText value="每页有#{emp_blacksheetBB.mypage.pageSize}"></h:outputText>
          <h:outputText value="  "></h:outputText>
          <h:outputText value="当前为第#{emp_blacksheetBB.mypage.currentPage}页"></h:outputText>
          <h:commandButton value="首页" action="#{emp_blacksheetBB.first}" styleClass="button01"></h:commandButton>
          <h:commandButton value="上页" action="#{emp_blacksheetBB.pre}" styleClass="button01"></h:commandButton>
          <h:commandButton value="下页" action="#{emp_blacksheetBB.next}" styleClass="button01"></h:commandButton>
          <h:commandButton value="尾页" action="#{emp_blacksheetBB.last}" styleClass="button01"></h:commandButton>

          <h:inputText value="#{emp_blacksheetBB.name}"></h:inputText>
          <h:commandButton styleClass="button01" value="查询" action="#{emp_blacksheetBB.queryList}"></h:commandButton>
          <h:commandButton styleClass="button01" value="新增" action="#{emp_blacksheetBB.queryList}" onclick="return doAdd();"></h:commandButton>
          <h:inputHidden id="personIds" value="#{emp_blacksheetBB.personIds}"></h:inputHidden>
          <h:commandButton styleClass="button01" id="delete" value="删除" action="#{emp_blacksheetBB.delete}" style="display:none"></h:commandButton>
    <f:verbatim>
      </td>
      </tr>

      <tr><td align="top">
          <div style='width:100%;height:100%;overflow:auto' id=datatable>
              <table width="98%">
              <%
                  List list = (List) session.getAttribute("Black");
                  if (list != null && list.size() > 0) {
                      AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");
                      String basepath = application.getRealPath("/");
                      for (int i = 0; i < list.size(); i++) {
                          EmpBlackSheetBO black = (EmpBlackSheetBO) list.get(i);
                          String img = "/images/common/nophoto.JPG";
                          String reason = CommonFuns.filterNull(black.getReson());
                          if (black.getImg() != null && !"".equals(black.getImg())) {
                              img = "/file/tmp/" + black.getImg() + ".JPG";
                              if (!aucc.checkAttachFileExist(basepath, black.getImg())) {
                                  aucc.getFileContentToFile(basepath, black.getImg());
                              }
                          }
                          out.println("<tr>");

              %>
                          <td><table>
                          <tr>
                          <td>
                                <img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt="">
                          </td>
                          <td>
                                <strong>姓名:</strong><%=black.getPersName()%> &nbsp;&nbsp;<input type="button" value="删除" class="button01" onclick="doDelete('<%=black.getPersID()%>')"><br>
                                <strong>性别:</strong><%=black.getSex()%><br>
                                <strong>出生日期:</strong><%=black.getBirthDay()%><br>
                                <strong>身份证:</strong><%=black.getIdCard()%><br>
                                <strong>原单位:</strong><%=black.getOrgName()%><br>
                                <hr>
                                <strong>证明人:</strong><%=black.getOperName()%><br>
                                <strong>联系电话:</strong><%=black.getOperTel()%><br>
                          </td>
                          </tr>
                          <tr>
                              <td colspan=2>
                                  <strong>原因:</strong><%=reason%>
                              </td>
                          </tr>

                          </table></td>
                  <%
                         i++;
                         if (i<list.size()){
                             black = (EmpBlackSheetBO) list.get(i);
                             img = "/images/common/nophoto.JPG";
                             reason = CommonFuns.filterNull(black.getReson());
                             if (black.getImg() != null && !"".equals(black.getImg())) {
                                 img = "/file/tmp/" + black.getImg() + ".JPG";
                                 if (!aucc.checkAttachFileExist(basepath, black.getImg())) {
                                     aucc.getFileContentToFile(basepath, black.getImg());
                                 }
                             }
                  %>
                          <td><table>
                                  <tr>
                                  <td>
                                        <img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt="">
                                  </td>
                                  <td>
                                        <strong>姓名:</strong><%=black.getPersName()%>&nbsp;&nbsp;<input type="button" value="删除" class="button01" onclick="doDelete('<%=black.getPersID()%>')"><br>
                                        <strong>性别:</strong><%=black.getSex()%><br>
                                        <strong>出生日期:</strong><%=black.getBirthDay()%><br>
                                        <strong>身份证:</strong><%=black.getIdCard()%><br>
                                        <strong>原单位:</strong><%=black.getOrgName()%><br>
                                        <hr>
                                        <strong>证明人:</strong><%=black.getOperName()%><br>
                                        <strong>联系电话:</strong><%=black.getOperTel()%><br>
                                  </td>
                                  </tr>
                                  <tr>
                                      <td colspan=2>
                                          <strong>原因:</strong><%=reason%>
                                      </td>
                                  </tr>

                                  </table></td>
                  <%
                         }
                         out.println("</tr>");
                     }
                  }
               %>
              </table>
          </div>
       </td></tr>
       </table>

    </f:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
