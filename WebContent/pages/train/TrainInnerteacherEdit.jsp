<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
function chkDate(){
  	if(document.all('form1:recName').value=="")
     {
     alert("��ѡ����Ա��");
     return false;
     }
     return true;
  }
      </script>
<x:saveState value="#{train_innerteachereditbb}" />
<h:form id="form1">
	<h:inputHidden value="#{train_innerteachereditbb.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{train_innerteacherlistbb.superId}"></h:inputHidden>
	<h:panelGrid align="center" width="95%">
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
			<h:outputText value="�ڲ���ʦ��Ա" />
			<h:panelGroup>
				<h:inputHidden id="recID"
					value="#{train_innerteachereditbb.innerteacherbo.personId}" />
				<h:inputText id="recName" readonly="true"
					value="#{train_innerteachereditbb.innerteacherbo.personName}" />
				<c:verbatim>
					<input type="button" class="button_select"
						onclick="fPopUpPerDlg('form1:recName', 'form1:recID',document.all('form1:superId').value,'2')">
				</c:verbatim>
			</h:panelGroup>
			
			<h:outputText value="Ӧ�÷�Χ"></h:outputText>
            <h:selectOneMenu value="#{train_innerteachereditbb.innerteacherbo.teacherOrg}">
            <c:selectItems value="#{train_innerteachereditbb.innerteacherOrgList}"></c:selectItems>
            </h:selectOneMenu>
			
			

		</h:panelGrid>
		<h:panelGrid columns="2" align="right" cellspacing="2">
			<h:commandButton styleClass="button01" value="ȷ��"
				onclick="return chkDate();"
				action="#{train_innerteachereditbb.save}" />
			<h:commandButton styleClass="button01" type="button" value="ȡ������"
				onclick="window.close();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
