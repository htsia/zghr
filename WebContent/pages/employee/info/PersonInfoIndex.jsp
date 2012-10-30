<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
    String rootid = user.getOrgId();
%>
<c:verbatim>
    <script type="text/javascript">
        function refreshList(orgId) {
               document.all('orgId').value=orgId;
               if (document.all("form1:displayMode").value=="2"){
                   document.main.location.href = "/employee/info/PersonInfoPhotoQuery.jsf?flag="+document.all('flag').value+"&superId=" + orgId;
               }
               else{
                    document.main.location.href = "/employee/info/PersonInfoQuery.jsf?flag="+document.all('flag').value+"&superId=" + orgId;
               }
        }
        function forChange() {
            if (document.getElementById("form1:mType").value == "1") {
                document.all('flag').value="1";
                document.tree.location.href = "/pages/common/ShowOrgTree.jsp";
            }
            else if (document.getElementById("form1:mType").value == "2"){
                document.all('flag').value="2";
                document.tree.location.href = "/pages/common/ShowOrgTeamTree.jsp";
            }
            else{
                document.all('flag').value=document.getElementById("form1:mType").value;
                document.tree.location.href = "/pages/common/ShowOrgList.jsp?ListType="+document.getElementById("form1:mType").value;
            }
        }
        function forChangeMode(){
             refreshList(document.all('orgId').value);
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }

    </script>
</c:verbatim>

<h:form id="form1">
    <f:verbatim>
    <input type="hidden" id="flag" value="1">
    <input type="hidden" id="orgId" value="1">
    <table  width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
              人员信息管理 ->
              <%=LanguageSupport.getResource("RYGL-0311","信息维护")%>   
              &nbsp;&nbsp;&nbsp;&nbsp;  
              <%=LanguageSupport.getResource("RYGL-1000","浏览方式：")%>   
    </f:verbatim>
                <h:selectOneMenu id="mType" onchange="forChange()">
                    <c:selectItems value="#{emp_personListBB.orgBrowModeList}"></c:selectItems>
                </h:selectOneMenu>
    <f:verbatim>
                &nbsp;&nbsp;&nbsp;&nbsp;
                显示方式:
    </f:verbatim>
                <h:selectOneMenu id="displayMode" onchange="forChangeMode()">
                    <c:selectItem itemLabel="列表" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="照片" itemValue="2"></c:selectItem>
                </h:selectOneMenu>
    <f:verbatim>
             </td>
        </tr>
    </table>

    <table width="100%" border="0"  height="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210" height="100%" valign="top">
                  <iframe name="tree" height="100%"  frameborder="0"  height="100%" scrolling="auto" width="100%"
                                    src="/pages/common/ShowOrgTree.jsp?rootId=<%=rootid%>"></iframe>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
            </td>

            <td align="center" valign="top" height="100%">
                 <iframe name="main" height="100%"  frameborder="0"  height="100%" scrolling="no" width="100%"
                     src="/employee/info/PersonInfoQuery.jsf?superId=<%=user.getOrgId()%>"></iframe>
            </td>
        </tr>
    </table>
    </f:verbatim>    
</h:form>
