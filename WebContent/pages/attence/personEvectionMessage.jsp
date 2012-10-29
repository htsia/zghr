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
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
    
</c:verbatim>
<script type="text/javascript">
function check_test() {
	forCheck();
	var desc = document.all('form1:desc').value;
	var destination = document.all('form1:destination').value;
	var totalday = document.all('form1:totalday').value;
	if(desc != null && desc != ""){
		if(destination != null && destination != ""){
			if(totalday != null && totalday != ""){
				return true;
			}else{
				alert("��ٵ�����ֵ����Ϊ��");
				return false;
			}
		}else{
			alert("������Ŀ�ĵ�");
			return false;
		}
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

function forCheck() {
    PutTextareaValue(document.all('form1:desc'),fGetContent());
    //if(forsubmit(document.forms(0))){
         return true;
    //}
    //else{
        //return false;
    //}
}

function selectNewPerson(){
	window.showModalDialog("/attence/personEvectionMessagePersonList.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
return true;
}

function deleteNewPerson(){
	  var field = form1.all('selected_ids');
	  if (checkMutilSelect(field)) {
	      pageCodeExchange(document.forms(0));
	  } else{
	      alert("��ѡ����Ա��");
	      return false;
	  }
}

function selectNewPersonTimeOff(){
	var perIds = "";
	var field = form1.all('selected_ids');
	if (checkMutilSelect(field)) {
		var obj = field;
		var size = obj.length;
		if (size == null) {
			if (obj.checked) {
				perIds += obj.value + ",";
			}
		} else {
			for ( var i = 0; i < size; i++) {
				if (obj[i].checked) {
					perIds += obj[i].value + ",";
				}
			}

		}
		if (perIds != "") {
			perIds = perIds.substr(0, perIds.length - 1);
		}
	}

	if (perIds.length <= 0) {
		alert("��ѡ����Ա��");
		return false;
	} else {
		var personIdTimeOffDay = document.all('form1:totalday1').value;
		window.showModalDialog("/attence/personEvectionMessageTimeOff.jsf?personIdTimeOff="+perIds+"&personIdTimeOffDay="+personIdTimeOffDay, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
	}
	return true;
}
</script>
<x:saveState value="#{personevectionBB}" />
<h:form id="form1">
	<h:commandButton id="refresh" value="ˢ��" style="display:none;" action="#{personevectionBB.makesure}"></h:commandButton>
    <h:inputHidden value="#{personevectionBB.pageInit1}" />
	<c:verbatim>
		<input type="hidden" name="content" value="">
	</c:verbatim>
	<h:panelGrid width="98%" align="center">
		<h:outputText escape="false" value="�������뵥"
			style="font-size:22px;text-align:center;width:100%" />
		<f:verbatim>
			<br>
		</f:verbatim>
	</h:panelGrid>

	<f:verbatim>
		<table align="center" border="0" width="610" id="table1"
			cellspacing="0" cellpadding="0" class="style1">
			<tr>
				<td height="40" align="center" width="80" style="border:1px solid #555555;" class="table_rlbt"></f:verbatim>
				<h:outputText escape="false" value="������" rendered="#{personevectionBB.setStatus=='2'}"/> 
				<h:outputText escape="false" value="����" /> <f:verbatim></td>
				<td class="table_rlbt" colspan="3" height="40" align="center" width="80" style="border:1px solid #555555;">
								</f:verbatim> 
			<h:outputText escape="false" style="text-align:center;width:100%"
				value="#{personevectionBB.personName}" />
					<f:verbatim>
				</td>
				<td class="table_rlbt" align="center">
				</f:verbatim> 
				<h:outputText
					escape="false" value="Ŀ�ĵ�" /> 
					<f:verbatim>
					</td>
				<td class="table_rlbt" align="center" colspan="2" width=200>
								</f:verbatim> 
										<h:inputText id="destination" styleClass="input" style="width:100%"
					value="#{personevectionBB.bo.dest}" />
					<f:verbatim>
				</td>
			</tr>
			
			<tr>
				<td align="center" height="40" class="table_rlbt">��������</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:selectOneRadio value="#{personevectionBB.setStatus}" valueChangeListener="#{personevectionBB.changeSetStatus}" disabled="#{personevectionBB.bo.superFlId=='2' || personevectionBB.bo.superFlId=='3'}"
				onclick="submit();">
				<f:selectItem itemValue="1" itemLabel="����" />
				<f:selectItem itemValue="2" itemLabel="����" />
			</h:selectOneRadio>
				<f:verbatim>
				</td>
			</tr>

</f:verbatim>
<h:panelGroup>
<f:verbatim>
			<tr>
				<td align="center" height="40" class="table_rlbt">������Ա</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
				<x:dataTable value="#{personevectionBB.listscommon}" var="list"
					id="dateList" rowIndexVar="index" headerClass="td_top"
					rowClasses="td_middle" styleClass="table03" border="1" width="500">
					<h:column>
						<c:facet name="header">
							<c:verbatim escape="false">
								<input type="checkbox" name="chkAll"
									onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)" />
							</c:verbatim>
						</c:facet>
						<c:verbatim escape="false">
							<input type="checkbox" name="selected_ids"
								value="</c:verbatim>
                   <h:outputText value="#{list.id}"/>
                   <c:verbatim>">
						</c:verbatim>
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="��Ա���" />
						</c:facet>
						<h:outputText value="#{list.personSeq}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.name}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:outputText value="���ڿ���" styleClass="td03" />
						</f:facet>
						<h:outputText value="#{list.card}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="���ڻ���" />
						</c:facet>
						<h:outputText value="#{list.orgName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="���ڲ���" />
						</c:facet>
						<h:outputText value="#{list.deptName}" />
					</h:column>

				</x:dataTable>
			<h:commandButton styleClass="button01" value="ѡ����Ա" rendered="#{personevectionBB.setStatus=='2'}"
				onclick="return selectNewPerson();" />
			<h:commandButton styleClass="button01" value="ȥ��" rendered="#{personevectionBB.setStatus=='2'}"
				action="#{personevectionBB.remove}"
				onclick="javascript:return deleteNewPerson();" />
			<h:commandButton styleClass="button01" value="��������"  onclick="selectNewPersonTimeOff();" rendered="#{personevectionBB.personTimeOffState=='1'}"/>
				<f:verbatim>
				</td>
			</tr>
</f:verbatim>
</h:panelGroup>
<f:verbatim>

			<tr>
				<td align="center" height="40" class="table_rlbt">����ʱ��</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="��ʼ����|0|d" value="#{personevectionBB.begindatevalueWdate}" onclick="timeCheck();"
				    readonly="true"/>
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			</h:panelGroup>
			<h:outputText escape="false" value=" ��  " />
						<h:panelGroup>
				<h:inputText styleClass="input" id="endTime" alt="��������|0|d" onclick="timeCheck();"
					size="30" value="#{personevectionBB.enddatevalueWdate}" readonly="true"/>
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
				value="#{personevectionBB.kqglLeaverDayValue}" readonly="true"/>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666">
				</f:verbatim> <h:outputText escape="false"
					value="����" /> <f:verbatim></td>
				<td class="table_rlbt" align="left" valign="top" colspan="6"
					style="padding-left: 6px;"></f:verbatim> 
<h:inputTextarea id="desc" value="#{personevectionBB.bo.reason}"
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
		
</f:verbatim>
<h:panelGroup rendered="#{personevectionBB.personTimeOffState=='1'}">
<f:verbatim>			
		    <tr>
				<td align="center" height="40" class="table_rlbt">��������</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:inputText styleClass="input" style="border:0px;" id="totalday1" 
				value="#{personevectionBB.personTimeOffDay}" readonly="true"/>
				<f:verbatim>
				</td>
			</tr>
			
	        <tr>
				<td align="center" height="40" class="table_rlbt">��Ա������Ϣ</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
                  <x:dataTable value="#{personevectionBB.personIdTimeOffList}" var="list"
					id="dateList1" rowIndexVar="index" headerClass="td_top"
					rowClasses="td_middle" styleClass="table03" border="1" width="500">>
					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
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
					
				</x:dataTable>
				<f:verbatim>
				</td>
			</tr>
</f:verbatim>
</h:panelGroup>
<f:verbatim>			
			
			<tr>
				<td align="center" height="40" class="table_rlbt">����</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
            <h:commandButton styleClass="button01" value="����" action="#{personevectionBB.personEvectionMessage}"
                             onclick="return check_test();"  />
            <h:outputText value="  " />
            <h:outputText value="  " />
            <h:outputText value="  " />
            <h:commandButton styleClass="button01" value="ȷ�ϲ�����" action="#{personevectionBB.personEvectionMessageAndPersonEvectionMessageAudit}"
                             onclick="return check_test();"  />
				<f:verbatim>
				</td>
			</tr>
			
		</table>
		<br>
		<br>
	</f:verbatim>
</h:form>


