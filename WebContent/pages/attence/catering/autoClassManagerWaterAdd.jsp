<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	 var btime=document.all("form1:beginTime").value;
	 var etime=document.all("form1:endTime").value;
	    if(btime==null||btime==""){
	        alert("月总客流量。");
	        return false;
	    }
	    if(etime==null||etime==""){
	        alert("月总出品量。");
	        return false;
	    }
	    return true;
	 }
  </script>
<x:saveState value="#{autoclassmanagerruleBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{autoclassmanagerruleBB.initEdit2}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->录入参数修改" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="所属部门"></h:outputText>
            <h:outputText value="#{autoclassmanagerruleBB.bo1.orguidName}"></h:outputText>
  
            <h:outputText value="年月" />
            <h:outputText value="#{autoclassmanagerruleBB.bo1.attenceDate}"></h:outputText>

			<h:outputText value="月总客流量"></h:outputText>
			<h:panelGroup>
				<h:inputText id="beginTime" value="#{autoclassmanagerruleBB.bo1.monthVolume}">
				</h:inputText>
			</h:panelGroup>
			
			<h:outputText value="月总出品量"></h:outputText>
			<h:panelGroup>
				<h:inputText id="endTime" value="#{autoclassmanagerruleBB.bo1.monthProduce}">
				</h:inputText>
			</h:panelGroup>
			
		</h:panelGrid>


		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return test()" action="#{autoclassmanagerruleBB.save1}" styleClass="button01"/>
		</h:panelGrid>


	</h:panelGrid>
</h:form>


