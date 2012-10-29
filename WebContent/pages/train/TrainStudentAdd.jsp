<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim>
	<base target="_self">
</c:verbatim>
<script type="text/javascript">
function chkDate(){
  	if(document.all('form1:recName').value=="")
     {
     alert("请选择人员！");
     return false;
     }
     return true;
  }
      </script>
<x:saveState value="#{TrainClassSign_EditBB}" />
<h:form id="form1">
	<h:inputHidden value="#{TrainClassSign_EditBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="classID" value="#{TrainClassSign_EditBB.classID}"></h:inputHidden>
	<h:panelGrid align="center" width="95%">
		<h:panelGrid columns="2" width="100%"
			columnClasses="td_form01,td_form02" align="center"
			styleClass="table03">
			<h:outputText value="培训学生" />
			<h:panelGroup>
				<h:inputHidden id="recID"
					value="#{TrainClassSign_EditBB.studentbo.personID}" />
				<h:inputText id="recName" readonly="true"
					value="#{TrainClassSign_EditBB.studentbo.personName}" />
				<c:verbatim>
					<input type="button" class="button_select"
						onclick="fPopUpMutiPerDlg('form1:recName', 'form1:recID',document.all('form1:classID').value,'2')">
				</c:verbatim>
			</h:panelGroup>
			</h:panelGrid>
		<h:panelGrid columns="2" align="right" cellspacing="2">
			<h:commandButton styleClass="button01" value="确定"
				onclick="return chkDate();"
				action="#{TrainClassSign_EditBB.save}" />
			<h:commandButton styleClass="button01" type="button" value="取消返回"
				onclick="window.close();" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
