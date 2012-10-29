<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
    function forCheck(){
        if(document.all("form1:setName").value == ""){
                alert("表套名字不能为空!");
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
<x:saveState value="#{RptSetBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{RptSetBB.editRptSetInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="表套名称"></h:outputText>
            <h:panelGroup>
                <h:inputText  id="setName"  value="#{RptSetBB.repSetBO.setName}" />
            </h:panelGroup>
            
          <h:outputText value="使用情况"/>
	      <h:panelGroup>
            	<h:selectOneRadio id="isUse" value="#{RptSetBB.repSetBO.isUse}">
					<f:selectItem itemLabel="是" itemValue="1" />
					<f:selectItem itemLabel="否" itemValue="0" />
				</h:selectOneRadio>
			</h:panelGroup>

            <h:outputText value="周期属性"/>
             <h:panelGroup>
                <h:selectOneRadio value="#{RptSetBB.repSetBO.achivesType}" >
                    <f:selectItem itemValue="4" itemLabel="周报" />
                    <f:selectItem itemValue="0" itemLabel="月报" />
                    <f:selectItem itemValue="1" itemLabel="季报" />
                    <f:selectItem itemValue="2" itemLabel="半年报" />
                    <f:selectItem itemValue="3" itemLabel="年报" />
                </h:selectOneRadio>
            </h:panelGroup>

	    <h:outputText value="是否走流程"/>
	     <h:panelGroup>
            <h:selectOneRadio value="#{RptSetBB.repSetBO.isFlow}" >
				<f:selectItem itemValue="1" itemLabel="是" />
				<f:selectItem itemValue="0" itemLabel="否" />
			</h:selectOneRadio>
        </h:panelGroup>
        
          <h:outputText value="汇总关系"/>
	      <h:panelGroup>
                <h:inputText id="groupName" readonly="true" value="#{RptSetBB.repSetBO.groupName}" styleClass="input" />
                <h:inputHidden id="groupId" value="#{RptSetBB.repSetBO.groupId}"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpItemRptSetControl(document.all('form1:groupId'),document.all('form1:groupName'))"/>
		  </h:panelGroup>
        
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{RptSetBB.saveOrUpdateRptSetBO}"
                             onclick="return forCheck();"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
