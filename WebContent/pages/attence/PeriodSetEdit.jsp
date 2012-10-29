<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
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
	    return true;
	 }
  </script>
<x:saveState value="#{period_setBB}" />
<h:form id="form1">
	<h:inputHidden id="attname" value="#{period_setBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{period_setBB.superId}"></h:inputHidden>
	<h:panelGrid columns="1" width="98%" styleClass="td_title"
		align="center">

		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="考勤管理->新增考勤计算月份" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="工  资  年"></h:outputText>
			<h:selectOneMenu value="#{period_setBB.nowyearvalue}"
				valueChangeListener="#{period_setBB.changeNowYearValue}">
				<c:selectItems value="#{period_setBB.nowyearlist}"></c:selectItems>
			</h:selectOneMenu>

			<h:outputText value="工资月"></h:outputText>
			<h:selectOneMenu value="#{period_setBB.atttype}"
				valueChangeListener="#{period_setBB.changeStatus}">
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



			<h:outputText value="起始日期"></h:outputText>
			<h:panelGroup>
				<h:inputText id="beginTime" value="#{period_setBB.bo.duraBegin}"
					readonly="true">

				</h:inputText>

				<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCalendarDialog('form1:beginTime');">
				</f:verbatim>
			</h:panelGroup>


			<h:outputText value="终止日期"></h:outputText>
			<h:panelGroup>
				<h:inputText id="endTime" value="#{period_setBB.bo.duraEnd}"
					readonly="true">

				</h:inputText>

				<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCalendarDialog('form1:endTime');">
				</f:verbatim>
			</h:panelGroup>
			<h:outputText value="关联查询方案"/>
			<h:selectOneMenu id="qry" style="width:150px" value="#{period_setBB.bo.qryID}">
                <c:selectItems value="#{period_setBB.qryList}"/>
            </h:selectOneMenu>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" 
				action="#{period_setBB.save}" styleClass="button01" /> 
		</h:panelGrid>

	</h:panelGrid>
</h:form>


