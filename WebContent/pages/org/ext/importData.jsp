<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(orgId) {
            document.all('form1:orgId').value=orgId;
            document.main.location.href = "/org/ext/importDataChild.jsf?superId="+orgId+"&selectDate="+document.all('form1:selectDate').value+"&cfgID="+document.all('form1:cfgID').value;
        }
        function doQuery(){
            refreshList(document.all('form1:orgId').value);
        }
        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("tree").style.height = "" + (mainHeight-60) + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>


<x:saveState value="#{org_reportBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{org_reportBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="orgId"></h:inputHidden>
    <f:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
		    <td class="td_title">　
                <img src="/images/tips.gif" > 机构管理->数据上报
            </td>
        </tr>
    </table>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="300">
                 </f:verbatim>
                  <h:panelGrid>
                      <h:panelGroup>
                           <h:outputText escape="false" value="<strong>选择时间:</strong>"></h:outputText>
                           <h:inputText readonly="true" id="selectDate"></h:inputText>
                           <h:commandButton styleClass="button_date" type="button" onclick="PopUpCalendarDlg_OnlyMonth('form1:selectDate');"></h:commandButton>
                      </h:panelGroup>

                    <h:panelGroup>
                        <h:outputText escape="false" value="<strong>选择上报种类:</strong>"></h:outputText>
                        <h:selectOneMenu id="cfgID">
                            <c:selectItems value="#{org_reportBB.cfgList}"></c:selectItems>
                        </h:selectOneMenu>
                        <h:commandButton value="查询" type="button" styleClass="button01" onclick="return doQuery();"></h:commandButton>
                    </h:panelGroup>

                  </h:panelGrid>
                 <f:verbatim>
                 <iframe name="tree" frameborder="0"  scrolling="auto" width="100%"    src="/pages/common/ShowOnlyOrgTree.jsp"></iframe>
            </td>
            
            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                 <iframe name="main" frameborder="0"  scrolling="auto" width="100%"     src="/org/ext/importDataChild.jsf"></iframe>
            </td>
        </tr>
    </table>
    </f:verbatim>    
</h:form>
