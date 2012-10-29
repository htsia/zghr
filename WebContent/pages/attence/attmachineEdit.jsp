<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
          function checkDateNull(){
              if(document.all("form1: attname").value=="")
              {
                  alert("请填写考勤机名称！");
                   return false;
              }

              if(document.all("form1:place").value=="")
              {
            	  alert("请填写考勤机位置！");
                  return false;
              }
			  if(document.all("form1:ip").value=="")
              {
            	  alert("请填写考勤机位置！");
                  return false;
              }
              return true;
           }         
      </script>
<x:saveState value="#{att_machine_mgrchildBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{att_machine_mgrchildBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{att_machine_mgrchildBB.superId}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理-> 考勤机管理" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" styleClass="table03" align="center" >
			<h:outputText value="所属机构"></h:outputText>
			<h:panelGrid columns="1" width="100%" align="left">
				<h:inputText readonly="true" styleClass="input" size="30"
					value="#{att_machine_mgrchildBB.superName}" />
			</h:panelGrid>
			<h:outputText value="考勤机名称"></h:outputText>
			<h:inputText id="attname" size="27"
				value="#{att_machine_mgrchildBB.bo.machineName}"></h:inputText>

			<h:outputText value="考勤机类型"></h:outputText>
			<h:selectOneMenu value="#{att_machine_mgrchildBB.atttype}"
				valueChangeListener="#{att_machine_mgrchildBB.changeStatus}" onchange="submit();" >
				<c:selectItem itemLabel="A" itemValue="0"></c:selectItem>
				<c:selectItem itemLabel="B" itemValue="1"></c:selectItem>
				<c:selectItem itemLabel="C" itemValue="2"></c:selectItem>
			</h:selectOneMenu>

			<h:outputText value="安装位置"></h:outputText>
			<h:inputText id="place" size="27"
				value="#{att_machine_mgrchildBB.bo.machinePlace}"></h:inputText>
			
			
			<h:outputText value="考勤机IP"></h:outputText>
			<h:inputText id="ip" size="27"
				value="#{att_machine_mgrchildBB.bo.machineIP}"></h:inputText>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存"  action="#{att_machine_mgrchildBB.save}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


