<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
    function forCheck(){
        if(document.all("form1:setName").value == ""){
                alert("分组名字不能为空!");
                document.all("form1:setName").focus();
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
<x:saveState value="#{GroupDefineBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{GroupDefineBB.editRptGroupInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="分组名称"></h:outputText>
            <h:panelGroup>
                <h:inputText  id="setName"  value="#{GroupDefineBB.rptGroupBO.groupName}" />
            </h:panelGroup>
            
             <h:outputText value="使用情况"/>
	      <h:panelGroup>
            	<h:selectOneRadio id="isUse" value="#{GroupDefineBB.rptGroupBO.isUser}">
					<f:selectItem itemLabel="是" itemValue="1" />
					<f:selectItem itemLabel="否" itemValue="0" />
				</h:selectOneRadio>
			</h:panelGroup>
			

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{GroupDefineBB.saveOrUpdateRptGroupBO}"
                             onclick="return forCheck();"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
