<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<x:saveState value="#{selfTaskEstimateBB}" />
<h:form id="form1">
	<h:inputHidden value="#{selfTaskEstimateBB.initTaskEdit}"></h:inputHidden>
	<h:inputHidden id="itemId" value="#{selfTaskEstimateBB.itemId}"></h:inputHidden>
<f:verbatim>
	<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
	<tr><td class="td_form01">���</td><td class="td_form02">
</f:verbatim>	
		<h:inputText value="#{selfTaskEstimateBB.estimatebo.seq}"></h:inputText>
<f:verbatim>
		</td>
		<td class="td_form01">Ȩ��</td><td class="td_form02">
</f:verbatim>		
		<h:inputText value="#{selfTaskEstimateBB.estimatebo.purview}"></h:inputText>
<f:verbatim>
	</td>
		</tr>
	<tr><td class="td_form01">�ƻ���ʼʱ��</td><td class="td_form02">
</f:verbatim>
		<h:inputText styleClass="input" id="beginDate" value="#{selfTaskEstimateBB.estimatebo.planBeginDate}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
<f:verbatim>
		<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
	</td>
	<td class="td_form01">�ƻ�����ʱ��</td><td class="td_form02">
</f:verbatim>
		  <h:inputText styleClass="input" id="endDate" value="#{selfTaskEstimateBB.estimatebo.planEndDate}"
                             readonly="true" alt="��������|0|d|50||"/>
<f:verbatim>
	 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">	</td>
	</tr>
<tr><td class="td_form01">ʵ�ʿ�ʼʱ��</td><td class="td_form02">
</f:verbatim>
		<h:inputText styleClass="input" id="beginDate1" value="#{selfTaskEstimateBB.estimatebo.actBeginDate}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
<f:verbatim>
		<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate1')">
	</td>
	<td class="td_form01">ʵ�ʽ���ʱ��</td><td class="td_form02">
</f:verbatim>
		  <h:inputText styleClass="input" id="endDate1" value="#{selfTaskEstimateBB.estimatebo.actEndDate}"
                             readonly="true" alt="��������|0|d|50||"/>
<f:verbatim>
	 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate1')">	</td>
	</tr>
	<tr><td class="td_form01">���ȼ�</td><td class="td_form02">
</f:verbatim>	
		<h:selectOneMenu value="#{selfTaskEstimateBB.estimatebo.level}">
                    <c:selectItem itemLabel="���" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="�ܵ�" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="��" itemValue="2"></c:selectItem>
                    <c:selectItem itemLabel="�е�" itemValue="3"></c:selectItem>
                    <c:selectItem itemLabel="��" itemValue="4"></c:selectItem>
                    <c:selectItem itemLabel="�и�" itemValue="5"></c:selectItem>
                     <c:selectItem itemLabel="��" itemValue="6"></c:selectItem>
                    <c:selectItem itemLabel="�ܸ�" itemValue="7"></c:selectItem>
                </h:selectOneMenu>
<f:verbatim>
		</td>
		<td class="td_form01">���ռ�</td><td class="td_form02">
</f:verbatim>		
		<h:selectOneMenu value="#{selfTaskEstimateBB.estimatebo.venture}">
                    <c:selectItem itemLabel="���" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="�ܵ�" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="��" itemValue="2"></c:selectItem>
                    <c:selectItem itemLabel="�е�" itemValue="3"></c:selectItem>
                    <c:selectItem itemLabel="��" itemValue="4"></c:selectItem>
                    <c:selectItem itemLabel="�и�" itemValue="5"></c:selectItem>
                     <c:selectItem itemLabel="��" itemValue="6"></c:selectItem>
                    <c:selectItem itemLabel="�ܸ�" itemValue="7"></c:selectItem>
                </h:selectOneMenu>
<f:verbatim>
	</td>
		</tr>
	<tr><td class="td_form01">��������</td><td colspan="3" class="td_form02">
</f:verbatim>
		<h:inputTextarea value="#{selfTaskEstimateBB.estimatebo.taskContent}" cols="80" rows="3">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr><td class="td_form01">�����ƻ�</td><td colspan="3" class="td_form02">
</f:verbatim>
		<h:inputTextarea value="#{selfTaskEstimateBB.estimatebo.taskPlan}" cols="80" rows="3">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr><td class="td_form01">������׼</td><td colspan="3" class="td_form02">
</f:verbatim>
		<h:inputTextarea value="#{selfTaskEstimateBB.estimatebo.taskStandard}" cols="80" rows="3">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr><td class="td_form01">ʱ��</td><td colspan="3" class="td_form02">	
</f:verbatim>		
		<h:inputTextarea value="#{selfTaskEstimateBB.estimatebo.taskDate}" cols="80" rows="3">
		</h:inputTextarea>
<f:verbatim>
	</td></tr>
	<tr height="10"></tr>
	<tr><td colspan="4" align="right">
	
</f:verbatim>
<h:commandButton styleClass="button01" value="����" action="#{selfTaskEstimateBB.saveContent}">
		</h:commandButton>	
<f:verbatim>
	</td></tr></table>
</f:verbatim>
</h:form>