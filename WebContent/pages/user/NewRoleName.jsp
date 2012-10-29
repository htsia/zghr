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
        window.returnValue = roleName.trim();
        window.close();
        return false;
    }
    function cancel() {
        window.close();
        window.returnValue = "";
        return false;
    }
</script>

<h:form id="formNewRoleName">
    <h:panelGrid columns="0" width="97%" cellpadding="0" align="center"
                    cellspacing="0" border="0" >
        <h:panelGrid columns="2" width="97%" cellpadding="0"
                        align="center" border="0"  columnClasses="td_title,td_form02">
            <h:outputText value="新角色名" />
            <h:outputText value="" />
        </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>
        <h:panelGrid columns="1"
                         width="97%"
                        cellpadding="0" border="0" align="center"
                        styleClass="table03"
                        columnClasses="td_form02">
            <h:inputText id="newRoleName" value="" alt="新角色名|1|s|50" styleClass="input"/>

        </h:panelGrid>
        <f:verbatim>
            <br>
            <br>
        </f:verbatim>
        <h:panelGrid columns="2" width="20%" cellpadding="0"
                        align="center" border="0">
            <h:commandButton value="保 存" onclick="return ok()"
                             action="" styleClass="button01">
            </h:commandButton>
            <h:commandButton value="取 消" action="" styleClass="button01" onclick="return cancel()">
            </h:commandButton>
        </h:panelGrid>
    </h:panelGrid>

</h:form>