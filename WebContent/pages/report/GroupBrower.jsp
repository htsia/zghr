<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function refreshList(str){
            <%out.println("var benbu='"+Constants.ORG_BENBU+"';");%>
            if (benbu==str){
                document.main.location.href = "/report/GroupBrowerChild.jsf?setID="+document.all("form1:setID").value+"&dateId="+document.all("form1:dateId").value+"&staticdate=" + document.all("form1:processDate").value;
            }
            else{
                document.main.location.href = "/report/GroupBrowerChild2.jsf?setID="+document.all("form1:setID").value+"&unitId="+str+"&processDate=" + document.all("form1:processDate").value;
            }
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 35;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<x:saveState value="#{Rpt_GroupIndexBB}"/>
<h:form id="form1">
    <h:inputHidden id="dateId" value="#{Rpt_GroupIndexBB.dateId}"></h:inputHidden>
    <h:inputHidden id="setID" value="#{Rpt_GroupIndexBB.setID}"></h:inputHidden>
    <h:inputHidden id="processDate" value="#{Rpt_GroupIndexBB.processDate}"></h:inputHidden>
<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=20 class="td_title"><img src="/images/tips.gif">集团报表处理</td>
            <td height=20 class="td_title" align="right">
</c:verbatim>
              <h:outputText value="统计时间："></h:outputText>
              <h:inputText  readonly="true" value="#{Rpt_GroupIndexBB.processDate}" />
<c:verbatim>
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                               src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
             </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"></iframe>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
