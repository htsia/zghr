<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/tree2.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">

    function winClose() {
        window.returnValue = "";
        window.close();
        return false;
    }
</script>
<x:saveState value="#{user_UserRoleListBB}"/>
<f:view>
    <h:form id="formUserRoleList">
 <f:verbatim><div class='table03' style="width:100%;height:80%;overflow:auto" ></f:verbatim>
        <h:inputHidden id="pageInit" value="#{user_UserRoleListBB.pageInit}"/>
        <h:inputHidden id="userId" value="#{user_UserRoleListBB.userId}"/>

        <h:panelGrid columns="1" width="97%" cellpadding="0" align="center"
                        cellspacing="0" border="0"  styleClass="table03">
            <h:dataTable value="#{user_UserRoleListBB.roleList}" var="list" width="97%"
                         headerClass="td_top" rowClasses="td_middle"
                         styleClass="table03"
                         border="1">

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="½ÇÉ«Ãû³Æ"/>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.roleName}"/>
                </h:column>
            </h:dataTable>
        </h:panelGrid>
 <f:verbatim></div></f:verbatim>
        <h:panelGrid columns="1" width="100%" cellpadding="0"
                        align="center" border="0" >
            <h:commandButton value="·µ  »Ø" onclick="return winClose()" styleClass="button01"/>
        </h:panelGrid>

    </h:form>

</f:view>
