<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
    function forCheck(){
        if(document.all("form1:setCode").value == "0"){
                alert("表样编号不能为空!");
                document.all("form1:setCode").focus();
                return false;
               }
        else{
            return true ;
            }
        }
</script>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{RptSetBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{RptSetBB.editRptSetItemInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="编号"></h:outputText>
            <h:panelGroup>
            
                <h:inputText  id="setCode"  value="#{RptSetBB.rptSetItemBO.rptCode}" />
                <h:outputLabel styleClass="sec3" value="(请输入0~9之间的数字)"></h:outputLabel>
            </h:panelGroup>
            
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" onclick="return forCheck();"  action="#{RptSetBB.saveOrUpdateRptSetItem}" />
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
