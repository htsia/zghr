<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
    function doCheck(){
        return true;
    }
</script>

<x:saveState value="#{sys_portalBB}"></x:saveState>
<h:form id="formAddRole">
        <h:inputHidden value="#{sys_portalBB.editUser}"></h:inputHidden>
        <c:verbatim><br></c:verbatim>
        <h:panelGrid columns="2"
                         width="97%"
                        cellpadding="0" border="1" align="center"
                         styleClass="table03" columnClasses="td_form01,td_form02">
            <h:outputText value="门户应用"/>
            <h:selectOneMenu value="#{sys_portalBB.userpoartal.funID}">
                 <c:selectItems value="#{sys_portalBB.selectList}"></c:selectItems>
            </h:selectOneMenu>


            <h:outputText value="对应用户"/>
            <h:inputText value="#{sys_portalBB.userpoartal.linkUserID}"/>


        <h:outputText value="操作"></h:outputText>
        <h:panelGrid columns="2" width="20%" cellpadding="0"
                        align="center" border="0">
            <h:commandButton value="保 存" onclick="return doCheck();" action="#{sys_portalBB.SaveUser}"
                             styleClass="button01"/>
            <h:commandButton value="返 回" onclick="window.close()" type="button" styleClass="button01">
            </h:commandButton>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
