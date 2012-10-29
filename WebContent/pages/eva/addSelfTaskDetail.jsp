<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<x:saveState value="#{selfTaskEstimateBB}" />
<h:form id="form1">
	<h:inputHidden value="#{selfTaskEstimateBB.initTaskEdit}"></h:inputHidden>
	<h:inputHidden id="itemId" value="#{selfTaskEstimateBB.itemId}"></h:inputHidden>
<f:verbatim>
	<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
	<tr><td class="td_form01">序号</td><td class="td_form02">
</f:verbatim>	
		<h:inputText value="#{selfTaskEstimateBB.estimatebo.seq}"></h:inputText>
<f:verbatim>
		</td>
		<td class="td_form01">权重</td><td class="td_form02">
</f:verbatim>		
		<h:inputText value="#{selfTaskEstimateBB.estimatebo.purview}"></h:inputText>
<f:verbatim>
	</td>
		</tr>
	<tr><td class="td_form01">计划开始时间</td><td class="td_form02">
</f:verbatim>
		<h:inputText styleClass="input" id="beginDate" value="#{selfTaskEstimateBB.estimatebo.planBeginDate}"
                             readonly="true" alt="开始日期|0|d|50||"/>
<f:verbatim>
		<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
	</td>
	<td class="td_form01">计划结束时间</td><td class="td_form02">
</f:verbatim>
		  <h:inputText styleClass="input" id="endDate" value="#{selfTaskEstimateBB.estimatebo.planEndDate}"
                             readonly="true" alt="结束日期|0|d|50||"/>
<f:verbatim>
	 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">	</td>
	</tr>
<tr><td class="td_form01">实际开始时间</td><td class="td_form02">
</f:verbatim>
		<h:inputText styleClass="input" id="beginDate1" value="#{selfTaskEstimateBB.estimatebo.actBeginDate}"
                             readonly="true" alt="开始日期|0|d|50||"/>
<f:verbatim>
		<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate1')">
	</td>
	<td class="td_form01">实际结束时间</td><td class="td_form02">
</f:verbatim>
		  <h:inputText styleClass="input" id="endDate1" value="#{selfTaskEstimateBB.estimatebo.actEndDate}"
                             readonly="true" alt="结束日期|0|d|50||"/>
<f:verbatim>
	 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate1')">	</td>
	</tr>
	<tr><td class="td_form01">优先级</td><td class="td_form02">
</f:verbatim>	
		<h:selectOneMenu value="#{selfTaskEstimateBB.estimatebo.level}">
                    <c:selectItem itemLabel="最低" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="很低" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="低" itemValue="2"></c:selectItem>
                    <c:selectItem itemLabel="中低" itemValue="3"></c:selectItem>
                    <c:selectItem itemLabel="中" itemValue="4"></c:selectItem>
                    <c:selectItem itemLabel="中高" itemValue="5"></c:selectItem>
                     <c:selectItem itemLabel="高" itemValue="6"></c:selectItem>
                    <c:selectItem itemLabel="很高" itemValue="7"></c:selectItem>
                </h:selectOneMenu>
<f:verbatim>
		</td>
		<td class="td_form01">风险级</td><td class="td_form02">
</f:verbatim>		
		<h:selectOneMenu value="#{selfTaskEstimateBB.estimatebo.venture}">
                    <c:selectItem itemLabel="最低" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="很低" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="低" itemValue="2"></c:selectItem>
                    <c:selectItem itemLabel="中低" itemValue="3"></c:selectItem>
                    <c:selectItem itemLabel="中" itemValue="4"></c:selectItem>
                    <c:selectItem itemLabel="中高" itemValue="5"></c:selectItem>
                     <c:selectItem itemLabel="高" itemValue="6"></c:selectItem>
                    <c:selectItem itemLabel="很高" itemValue="7"></c:selectItem>
                </h:selectOneMenu>
<f:verbatim>
	</td>
		</tr>
	<tr><td class="td_form01">工作任务</td><td colspan="3" class="td_form02">
</f:verbatim>
		<h:inputTextarea value="#{selfTaskEstimateBB.estimatebo.taskContent}" cols="80" rows="3">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr><td class="td_form01">工作计划</td><td colspan="3" class="td_form02">
</f:verbatim>
		<h:inputTextarea value="#{selfTaskEstimateBB.estimatebo.taskPlan}" cols="80" rows="3">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr><td class="td_form01">衡量标准</td><td colspan="3" class="td_form02">
</f:verbatim>
		<h:inputTextarea value="#{selfTaskEstimateBB.estimatebo.taskStandard}" cols="80" rows="3">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr><td class="td_form01">时间</td><td colspan="3" class="td_form02">	
</f:verbatim>		
		<h:inputTextarea value="#{selfTaskEstimateBB.estimatebo.taskDate}" cols="80" rows="3">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr height="10"></tr>
	<tr><td colspan="4" align="right">
	
</f:verbatim>
<h:commandButton styleClass="button01" value="保存" action="#{selfTaskEstimateBB.saveContent}">
		</h:commandButton>	
<f:verbatim>
	</td></tr></table>
</f:verbatim>
</h:form>