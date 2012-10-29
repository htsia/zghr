<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp"%>
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
<c:verbatim>
	<link href="/css/editor.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/js/commonFuns.js"></script>
	<script language="javascript" src="/js/editor.js"></script>
	<script language="javascript" src="/js/editor_toolbar.js"></script>
    
</c:verbatim>
<script type="text/javascript">
function check_test() {
	forCheck();
	var desc = document.all('form1:desc').value;
	if(desc != null && desc != ""){
        if(confirm('�ڱ����������彡���������£����ſ������ӹ���ʱ�䣬��ȷ��Ҫ���ӹ���ʱ����')){
            return true;
        }else{
        	return false; 
        }
	}else{
		alert("������Ӱ�����");
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
	//WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'});
	//WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})
	var beginTime = document.all('form1:beginTimes').value;
	var endTime = document.all('form1:endTimes').value;
	if(beginTime != null && beginTime != "" && endTime != null && endTime != ""){
		 if(beginTime>endTime){
		        alert("��ʼ�������ڽ�������");
		        return false;
		 }
		 document.all('form1:refreshs').click();
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

	function refreshload() {
		document.all('form1:refresh').click();
	}
</script>
<x:saveState value="#{personaddworkBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		action="#{personaddworkBB.makesure}"></h:commandButton>
	<h:commandButton id="refreshs" value="ˢ��" style="display:none;"
		action="#{personaddworkBB.makesures}"></h:commandButton>
	<h:inputHidden value="#{personaddworkBB.pageInit1}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="�Ӱ����뵥"
			style="font-size:22px;text-align:center;width:100%" />
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<f:verbatim>
		<table align="center" border="0" width="610" id="table1"
			cellspacing="0" cellpadding="0" class="style1">
			<tr>
				<td height="40" align="center" width="80" style="border:1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="����" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="6" height="40" align="center" width="80" style="border:1px solid #555555;">
								</f:verbatim> 
			<h:outputText escape="false" style="text-align:center;width:100%"
				value="#{personaddworkBB.personName}" />
					<f:verbatim>
				</td>
			</tr>

			<tr>
				<td height="40" align="center" width="80" style="border:1px solid #555555;" class="table_rlbt"></f:verbatim> <h:outputText
					escape="false" value="�Ӱ�����" /> <f:verbatim></td>
				<td height="40" colspan=6 class="table_rlbt">
								</f:verbatim> 
			<h:selectOneRadio value="#{personaddworkBB.typeStatus}"
				onclick="refreshload();">
				<f:selectItem itemValue="1" itemLabel="��������ʱ" />
				<f:selectItem itemValue="2" itemLabel="˫����" />
				<f:selectItem itemValue="3" itemLabel="�ڼ���" />
			</h:selectOneRadio>
					<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">ʱ��</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="��ʼ����|0|d" value="#{personaddworkBB.begindatevalueWdate}" onclick="timeCheck();"
				    readonly="true"/>
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			</h:panelGroup>
			<h:outputText escape="false" value=" ��  " />
						<h:panelGroup>
				<h:inputText styleClass="input" id="endTime" alt="��������|0|d" onclick="timeCheck();"
					size="30" value="#{personaddworkBB.enddatevalueWdate}" readonly="true"/>
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">�ϼ�(��)</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:inputText styleClass="input" style="border:0px;" id="totalday" 
				value="#{personaddworkBB.kqglLeaverDayValue}" readonly="true"/>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666">
				</f:verbatim> <h:outputText escape="false"
					value="����" /> <f:verbatim></td>
				<td class="table_rlbt" align="left" valign="top" colspan="6"
					style="padding-left: 6px;"></f:verbatim> 
<h:inputTextarea id="desc" value="#{personaddworkBB.bo.reason}"
				cols="75" rows="3" style="display:none;" />
					<f:verbatim>
									<script language="javascript">
                    gFrame = 1;//1-�ڿ����ʹ�ñ༭��
                    gContentId = "form1:desc";//Ҫ�������ݵ�content ID
                    OutputEditorLoading();
                </script>
				<iframe id="HtmlEditor" class="editor_frame" frameborder="0"
					marginheight="0" marginwidth="0"
					style="width: 100%; height: 100px; overflow: visible;"></iframe>
					</td>
			</tr>
			
			<tr>
				<td align="center" height="40" style="border: 1px solid #666666"
					rowspan="2"></f:verbatim> <h:outputText escape="false"
					value="��������" /> <f:verbatim></td>
									<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="����" /> <f:verbatim></td>
				<td height="40" align="center" colspan="5"
					style="border: 1px solid #555555;">
				</f:verbatim>
			<h:panelGroup rendered="#{personaddworkBB.typeStatus=='2'}">
				<h:inputText styleClass="input" id="beginTimes" size="30"
					alt="��ʼ����|0|d" value="#{personaddworkBB.timeoffbegindatevalueWdate}" onclick="timeCheck1();"
				    readonly="true"/>
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTimes'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			</h:panelGroup>
			<h:outputText escape="false" value=" ��  " rendered="#{personaddworkBB.typeStatus=='2'}"/>
						<h:panelGroup rendered="#{personaddworkBB.typeStatus=='2'}">
				<h:inputText styleClass="input" id="endTimes" alt="��������|0|d" onclick="timeCheck1();"
					size="30" value="#{personaddworkBB.timeoffenddatevalueWdate}" readonly="true"/>
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTimes'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
			</h:panelGroup>
				<f:verbatim>
 </td>
			</tr>
			
									<tr>
				<td align="center" height="40" style="border: 1px solid #666666"></f:verbatim> <h:outputText escape="false"
					value="�ϼ�(��)" /> <f:verbatim></td>
				<td height="40" align="center" width="80" colspan="6"
					style="border: 1px solid #555555;"></f:verbatim>
			<h:inputText styleClass="input" rendered="#{personaddworkBB.typeStatus=='2'}"
				value="#{personaddworkBB.timeoffkqglLeaverDayValue}" />
 <f:verbatim></td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">����</td> 
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:commandButton styleClass="button01" value="����"
				action="#{personaddworkBB.personEvectionMessage}"
				onclick="return check_test();"
				disabled="#{personaddworkBB.isExist2==false}"/>
			<h:outputText value="  " />
			<h:outputText value="  " />
			<h:outputText value="  " /> 
			<h:commandButton styleClass="button01" value="ȷ�ϲ�����"
				action="#{personaddworkBB.personEvectionMessageAndPersonAddWorkMessageAudit}"
				onclick="return check_test();"
				disabled="#{personaddworkBB.isExist2==false}"/>
				<f:verbatim>
				</td>
			</tr>
			
		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>


