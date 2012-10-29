<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<c:verbatim>
	<link href="/css/editor.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/js/commonFuns.js"></script>
	<script language="javascript" src="/js/editor.js"></script>
	<script language="javascript" src="/js/editor_toolbar.js"></script>
    
</c:verbatim>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<style type="text/css">
.style1 {
	font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border: 2px solid #555555;
}

.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "����";
	background-color: #F3F3F3;
	font-weight: normal;
}

.style1 TR {
	FONT-SIZE: 9pt;
	COLOR: #555555;
}

.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "����";
}

.style2 {
	font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
}

.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "����";
	background-color: #F3F3F3;
	font-weight: normal;
}

.style1 TR {
	FONT-SIZE: 9pt;
	COLOR: #555555;
}

.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "����";
}

.table_rlbt {
	border: 1px solid #555555;
}
</style>
<script type="text/javascript">
function check_test() {
	forCheck();
	var desc = document.all('form1:desc').value;
	if(desc != null && desc != ""){
        return true;
	}else{
		alert("�������������");
		return false;
	}
}

function timeCheck(){
	//WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'});
	//WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != ""){
		 if(beginTime>endTime){
		        alert("��ʼ�������ڽ�������");
		        return false;
		 }
		 document.all('form1:refresh').click();
	}
	return true;
}

function timeCheck1(){
	var beginTime = document.all('form1:beginTime2').value;
	var endTime = document.all('form1:endTime2').value;
	if(beginTime != null && beginTime != ""){
		if(endTime != null && endTime != ""){
			 if(beginTime>endTime){
			        alert("��ʼ�������ڽ�������");
			        return false;
			 }
			 document.all('form1:refresh1').click();
		}
	}else{
        alert("������������ʱ�䡣");
        return false;
	}
	return true;
}

function forCheck() {
    PutTextareaValue(document.all('form1:desc'),fGetContent());
    //if(forsubmit(document.forms(0))){
         return true;
    //}
    //else{
        //return false;
    //}
}
</script>
<x:saveState value="#{personleaveBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		action="#{personleaveBB.makesure}"></h:commandButton>
	<h:commandButton id="refresh1" value="ˢ��" style="display:none;"
		action="#{personleaveBB.makesure2}"></h:commandButton>
	<h:inputHidden value="#{personleaveBB.pageInit2}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="��/���ٵ�"
			style="font-size:22px;text-align:center;width:100%" />
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<f:verbatim>
		<table align="center" border="0" width="610" id="table1"
			cellspacing="0" cellpadding="0" class="style1">
			<tr>
				<td  height="40" align="center" width="80" style="border:1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="����" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="3"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personleaveBB.personName}" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;"></f:verbatim> <h:outputText
					escape="false" value="��������" /> <f:verbatim></td>
				<td class="table_rlbt"  height="40" align="center" width="80" style="border:1px solid #555555;" colspan="2"></f:verbatim> <h:outputText
					escape="false" style="text-align:center;width:100%"
					value="#{personleaveBB.flleavevalue}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="40" width="80" class="table_rlbt">
				ԭʼʱ��</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:outputText value="#{personleaveBB.begindatevalueWdate3}"/>
			</h:panelGroup>
			<h:outputText escape="false" value=" ��  " />
						<h:panelGroup>
				<h:outputText value="#{personleaveBB.enddatevalueWdate3}"/>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>
			
			<tr>
				<td align="center" height="40" width="80" class="table_rlbt">��/����<br>
				</f:verbatim>
				<h:outputText value="����ʱ��" rendered="#{personleaveBB.flag!='3'}"/>
				<h:outputText value="����ʱ��" rendered="#{personleaveBB.flag=='3'}"/>
				<f:verbatim>
				</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="��ʼ����|0|d" value="#{personleaveBB.begindatevalueWdate}" onclick="timeCheck();"
				    readonly="true"/>
				    <h:panelGroup rendered="#{personleaveBB.flag=='3'}">
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			        </h:panelGroup>
			</h:panelGroup>
			<h:outputText escape="false" value=" ��  " />
						<h:panelGroup>
				<h:inputText styleClass="input" id="endTime" alt="��������|0|d" onclick="timeCheck();"
					size="30" value="#{personleaveBB.enddatevalueWdate}" readonly="true"/>
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">�ϼ�(��)</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> <h:inputText
					styleClass="input" style="border:0px;"
					value="#{personleaveBB.kqglLeaverDayValue}" /> <f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666">
				</f:verbatim> <h:outputText escape="false" value="����" /> <f:verbatim></td>
				<td class="table_rlbt" align="left" valign="top" colspan="6"
					style="padding-left: 6px;"></f:verbatim> <h:inputTextarea id="desc"
					value="#{personleaveBB.reason}" cols="75" rows="3"
					style="display:none;" /> <f:verbatim>
					<script language="javascript">
                    gFrame = 1;//1-�ڿ����ʹ�ñ༭��
                    gContentId = "form1:desc";//Ҫ�������ݵ�content ID
                    OutputEditorLoading();
                </script>
					<iframe id="HtmlEditor" class="editor_frame" frameborder="0"
						marginheight="0" marginwidth="0"
						style="width: 100%; height: 100px; overflow: visible;"></iframe></td>
			</tr>

</f:verbatim>
<h:panelGroup rendered="#{personleaveBB.isExist5}">
<f:verbatim>
			<tr>
				<td align="center" height="40" class="table_rlbt">��ٵֿ���Ϣ����</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim> 
			<h:selectOneRadio value="#{personleaveBB.typeStatus}"
				onclick="submit();">
				<f:selectItem itemValue="1" itemLabel="ɾ��" />
				<f:selectItem itemValue="2" itemLabel="�޸�" />
			</h:selectOneRadio>
					<f:verbatim></td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">��ٲ���ʱ��</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime2" size="30"
					alt="��ʼ����|0|d" value="#{personleaveBB.begindatevalueWdate2}" onclick="timeCheck1();"
				    readonly="true"/>
				    <h:panelGroup rendered="#{personleaveBB.typeStatus=='2'}">
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime2'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			        </h:panelGroup>
			</h:panelGroup>
			<h:outputText escape="false" value=" ��  " />
			<h:panelGroup>
				<h:inputText styleClass="input" id="endTime2" alt="��������|0|d" onclick="timeCheck1();"
					size="30" value="#{personleaveBB.enddatevalueWdate2}" readonly="true"/>
					<h:panelGroup rendered="#{personleaveBB.typeStatus=='2'}">
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime2'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
					</h:panelGroup>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">���ۺϼ�(��)</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:inputText id="totaldayvalue2" styleClass="input" style="border:0px;"
				value="#{personleaveBB.daySpan1}" readonly="true"/>
				<f:verbatim>
				</td>
			</tr>
</f:verbatim>
</h:panelGroup>
<f:verbatim>

			<tr>
				<td align="center" height="40" class="table_rlbt">����</td>
				<td height="40" colspan=6 class="table_rlbt"></f:verbatim> 
				<h:commandButton
					styleClass="button01" value="����"
					action="#{personleaveBB.PersonLeaveMessages}"
					onclick="return check_test();" /> 
				<h:outputText value="  " />
			    <h:outputText value="  " />
			    <h:outputText value="  " />
			    <h:commandButton
					styleClass="button01" value="ȷ�ϲ�����"
					action="#{personleaveBB.PersonLeaveMessagesAndPersonLeaveMessageAudit}"
					onclick="return check_test();" /> 
					<f:verbatim></td>
			</tr>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666"
					rowspan="3"></f:verbatim> <h:outputText escape="false"
					value="��<br>ʷ<br>��<br>¼" />
					 <f:verbatim></td>
				<td class="table_rlbt" colspan="6" valign="top" cellpadding="0">
				</f:verbatim> 
<x:dataTable value="#{personleaveBB.persBos3}" var="list"
			align="center" id="dateList" rowIndexVar="index" headerClass="td_top"
			columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
			styleClass="table03" width="100%">
			<h:column>
				<c:facet name="header">
					<h:outputText value="���" />
				</c:facet>
				<h:outputText value="#{index+1}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.superFlIdName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flIdProcessName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="�Ƿ��ύ���֤������" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.flIdStatusName}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.applyDate}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="��ʼʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.beginTime}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����ʱ��" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.endTime}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:outputText escape="false" value="#{list.reason}" />
			</h:column>
			<h:column>
				<f:facet name="header">
					<h:outputText value="����(�ϼ�)" styleClass="td03" />
				</f:facet>
				<h:outputText value="#{list.lastDate}" />
			</h:column>
						<h:column>
				<f:facet name="header">
					<h:outputText value="����" styleClass="td03" />
				</f:facet>
				<h:commandButton value="�鿴����" styleClass="button01"
					onclick="showWorkFlowLogByLinkID('#{list.furloughNO}');"></h:commandButton>
			</h:column>
				</x:dataTable>
					<f:verbatim></td>
			</tr>

		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>


