<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function test(){
	 var btime=document.all("form1:beginTime").value;
	 var etime=document.all("form1:endTime").value;
	    if(btime==null||btime==""||etime==null||etime==""){
	        alert("请输入开始时间和结束时间");
	        return false;
	    }else if(btime>etime){
	        alert("开始时间晚于结束时间");
	        return false;
	    }
	  var groupname=document.all("form1:groupname").value;
	    if(groupname==null || groupname==""){
	        alert("请选择待选班次");
	        return false;
	    }
		  var restDay=document.all("form1:restDay").value;
		    if(restDay==null || restDay==""){
		        alert("请输入当月休息天数");
		        return false;
		    }
	    return true;
	 }
  </script>
<x:saveState value="#{autorearrangeBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{autorearrangeBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{autorearrangeBB.superId}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->自动排班" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="年"></h:outputText>
			<h:selectOneMenu value="#{autorearrangeBB.nowyearvalue}"
				valueChangeListener="#{autorearrangeBB.changeNowYearValue}">
				<c:selectItems value="#{autorearrangeBB.nowyearlist}"></c:selectItems>
			</h:selectOneMenu>

			<h:outputText value="月"></h:outputText>
			<h:selectOneMenu value="#{autorearrangeBB.atttype}"
				valueChangeListener="#{autorearrangeBB.changeStatus}">
				<c:selectItem itemLabel="01" itemValue="01"></c:selectItem>
				<c:selectItem itemLabel="02" itemValue="02"></c:selectItem>
				<c:selectItem itemLabel="03" itemValue="03"></c:selectItem>
				<c:selectItem itemLabel="04" itemValue="04"></c:selectItem>
				<c:selectItem itemLabel="05" itemValue="05"></c:selectItem>
				<c:selectItem itemLabel="06" itemValue="06"></c:selectItem>
				<c:selectItem itemLabel="07" itemValue="07"></c:selectItem>
				<c:selectItem itemLabel="08" itemValue="08"></c:selectItem>
				<c:selectItem itemLabel="09" itemValue="09"></c:selectItem>
				<c:selectItem itemLabel="10" itemValue="10"></c:selectItem>
				<c:selectItem itemLabel="11" itemValue="11"></c:selectItem>
				<c:selectItem itemLabel="12" itemValue="12"></c:selectItem>
			</h:selectOneMenu>



			<h:outputText value="开始时间"></h:outputText>
			<h:panelGroup>
				<h:inputText id="beginTime" value="#{autorearrangeBB.bo.duraBegin}"
					readonly="true">

				</h:inputText>

				<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCalendarDialog('form1:beginTime');">
				</f:verbatim>
			</h:panelGroup>



			<h:outputText value="结束时间"></h:outputText>
			<h:panelGroup>
				<h:inputText id="endTime" value="#{autorearrangeBB.bo.duraEnd}"
					readonly="true">

				</h:inputText>

				<f:verbatim>
					<input type="button" class="button_select"
						onclick=PopUpCalendarDialog('form1:endTime');;
>
				</f:verbatim>
			</h:panelGroup>

			<h:outputText value="手工排班"></h:outputText>
			<h:selectOneMenu value="#{autorearrangeBB.groupValue}"
				valueChangeListener="#{autorearrangeBB.changeGroupValue}">
				<c:selectItems value="#{autorearrangeBB.groupValuelist}"></c:selectItems>
			</h:selectOneMenu>

			<h:outputText value="待选班次"></h:outputText>
			<h:panelGroup>
				<h:inputText id="groupname" readonly="true" size="30"
					value="#{autorearrangeBB.className}" />
				<h:inputHidden id="groupid" value="#{autorearrangeBB.bo.linkClass}" />
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpMoni(document.all('form1:groupid'),document.all('form1:groupname'))" />
			</h:panelGroup>

			<h:outputText value="当月休息天数"></h:outputText>
			<h:panelGroup>
				<h:inputText id="restDay" value="#{autorearrangeBB.bo.restDay}">
				</h:inputText>
			</h:panelGroup>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" onclick="return test()"
				action="#{autorearrangeBB.save}" styleClass="button01" />
		</h:panelGrid>


	</h:panelGrid>
</h:form>


