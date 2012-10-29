<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>


<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function ok() {
        var roleName = document.all("formNewRoleName:newRoleName").value;
        if (roleName == null || roleName.replace(" ") == "") {
            alert('请输入角色名');
            return false;
        }
        return true;
    }
    function cancel() {
        window.close();
        return false;
    }
</script>
<x:saveState value="#{user_roleManageBB}"/>
<h:form id="formNewRoleName">
        <h:panelGrid columns="1" width="97%" cellpadding="0"
                        align="center" border="0"  columnClasses="td_title,td_form02">
            <h:outputText value="复制角色" />
        </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>
        <h:panelGrid columns="2"
                         width="97%"
                        cellpadding="0" border="0" align="center"
                        styleClass="table03"
                        columnClasses="td_form01,td_form02">
             <h:outputText value="新角色名"></h:outputText> 
             <h:inputText id="newRoleName"  alt="新角色名|1|s|50" styleClass="input" value="#{user_roleManageBB.newRoleName}"/>

             <h:outputText value="模板"></h:outputText>
             <h:selectOneMenu value="#{user_roleManageBB.roleTempID}">
                    <c:selectItems value="#{user_roleManageBB.roleTempList}"></c:selectItems>
             </h:selectOneMenu>
        </h:panelGrid>
        <f:verbatim>
            <br>
        </f:verbatim>

        <h:panelGrid columns="2" width="20%" cellpadding="0"
                        align="center" border="0">
            <h:commandButton value="保 存" onclick="return ok()"
                             action="#{user_roleManageBB.copyRole}" styleClass="button01">
            </h:commandButton>
            <h:commandButton value="取 消" type="button" styleClass="button01" onclick="return cancel()">
            </h:commandButton>
        </h:panelGrid>

</h:form>