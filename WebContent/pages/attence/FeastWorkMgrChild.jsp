<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="/pages/include/taglib.jsp"%>

<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>






<x:saveState value="#{feast_work_mgrBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{feast_work_mgrBB.pageInit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{feast_work_mgrBB.superId}"></h:inputHidden>
	<f:verbatim>
		<table height=90% width=60% align="center">
			<tr>
				<td>
				<fieldset style="width: 300; height: 300;" align="center">
				<legend>������</legend>
				<center></f:verbatim> <f:verbatim>
					<br>
					<br>
					<br>
					<h5>
				</f:verbatim> <h:selectBooleanCheckbox value="#{feast_work_mgrBB.isMon}" /><f:verbatim>����һ </f:verbatim>
				<h:selectBooleanCheckbox value="#{feast_work_mgrBB.isFri}" /><f:verbatim>������<br>
					<br>
				</f:verbatim> <h:selectBooleanCheckbox value="#{feast_work_mgrBB.isTues}" /><f:verbatim>���ڶ�   </f:verbatim>
				<h:selectBooleanCheckbox value="#{feast_work_mgrBB.isSat}" /><f:verbatim>������<br>
					<br>
				</f:verbatim> <h:selectBooleanCheckbox value="#{feast_work_mgrBB.isWed}" /><f:verbatim>������ </f:verbatim>
				<h:selectBooleanCheckbox value="#{feast_work_mgrBB.isSun}" /><f:verbatim>������<br>
					<br>
				</f:verbatim> <h:selectBooleanCheckbox value="#{feast_work_mgrBB.isThur}" /><f:verbatim>������ </f:verbatim>
				<f:verbatim>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h5>
				</f:verbatim> <f:verbatim></center>
				</fieldset>


				<fieldset style="width: 20; height: 30;" align="center"
					style=" border:0px outset #00f901;"><br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				<br>
				</fieldset>

				</td>
			</tr>
			<tr>
			  <td align="center">
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    </f:verbatim> <h:commandButton styleClass="button01" value="ȷ��"
					action="#{feast_work_mgrBB.save}"
					rendered="#{feast_work_mgrBB.isExist}" /> <f:verbatim>
				</f:verbatim> <h:commandButton styleClass="button01" value="ȡ��"
					action="#{feast_work_mgrBB.resave}"
					rendered="#{feast_work_mgrBB.isExist}" /> <f:verbatim>
			  </td>
			</tr>
		</table>
	</f:verbatim>
</h:form>



