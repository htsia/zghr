<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<style type="text/css">
.style1 {
	font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border: 0px solid #555555;
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
function forCheck() {
    PutTextareaValue(document.all('form1:desc'),fGetContent());
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

function timeCheck(){
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

function check_test() {
	forCheck();
	var beginTime = document.all('form1:beginTime').value;
	var endTime = document.all('form1:endTime').value;
	if(beginTime == null && beginTime == ""){
		alert("��ʼ���ڲ���Ϊ��");
		return false;
	}
	if(endTime == null && endTime == ""){
		alert("�������ڲ���Ϊ��");
		return false;
	}
	var desc = document.all('form1:desc').value;
	var destination = document.all('form1:destination').value;
	var totalday = document.all('form1:totalday').value;
	if(desc != null && desc != ""){
		if(destination != null && destination != ""){
			if(totalday != null && totalday != ""){
				return true;
			}else{
				alert("����ֵ����Ϊ��");
				return false;
			}
		}else{
			alert("������Ŀ�ĵ�");
			return false;
		}
	}else{
		alert("����������");
		return false;
	}
}
</script>
<x:saveState value="#{attwriternetworkBB}"></x:saveState>
<h:form id="form1">
    <h:commandButton id="refresh" value="ˢ��" style="display:none;" action="#{attwriternetworkBB.makesure}"></h:commandButton>
	<h:inputHidden value="#{attwriternetworkBB.pageInit}"></h:inputHidden>
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			bgcolor="#FFFFFF">
			<tr>
				<td class="td_title"><img src="/images/tips.gif">������Ϣ¼��</td>
			</tr>
		</table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8>
				<table width="98%" align="center">
					<tr>
						<td align="center" width="12%" class=tab><a href="attenceWriter.jsf">���¼��</a></td>
						<td align="center" width="12%" class=tab><a href="attenceWriterOutWork.jsf">����¼��</a></td>
						<td align="center" width="12%" class=tab><a href="attenceWriterEvcction.jsf">����¼��</a></td>
						<td align="center" width="12%" class=tab><a href="attenceWriterAddWork.jsf">�Ӱ�¼��</a></td>
						<td align="center" width="12%" class=activeTab><a href="attenceWriterNewWork.jsf">���¼��</a></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
						<td align="center" width="12%" class=tab></td>
					</tr>
				</table>

				</td>
			</tr>
			<tr>
				<td height=8>
			    </td>
			</tr>	
			<tr>
				<td height=8>
					 <table align="center" border="0" width="60%" id="table1"
			cellspacing="0" cellpadding="0" class="style1">

</f:verbatim>
<h:panelGroup>
<f:verbatim>
			<tr>
				<td align="center" height="40" class="table_rlbt">��Ա�б�</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
				<x:dataTable value="#{attwriternetworkBB.listscommon}" var="list"
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
			<h:commandButton styleClass="button01" value="ѡ����Ա" 
				onclick="return selectNewPerson();" />
			<h:commandButton styleClass="button01" value="ȥ��" 
				action="#{attwriternetworkBB.remove}"
				onclick="javascript:return deleteNewPerson();" />
				<f:verbatim>
				</td>
			</tr>
</f:verbatim>
</h:panelGroup>
<f:verbatim>

			<tr>
				<td align="center" height="40" class="table_rlbt">���ʱ��</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:panelGroup>
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="��ʼ����|0|d" value="#{attwriternetworkBB.begindatevalueWdate}" onclick="timeCheck();"
				    readonly="true"/>
				    <f:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
			        </f:verbatim>
			</h:panelGroup>
			<h:outputText escape="false" value=" ��  " />
						<h:panelGroup>
				<h:inputText styleClass="input" id="endTime" alt="��������|0|d" onclick="timeCheck();"
					size="30" value="#{attwriternetworkBB.enddatevalueWdate}" readonly="true"/>
					<f:verbatim>
					<img onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})" src="../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
					</f:verbatim>
			</h:panelGroup>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">��������</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:outputLabel id="attname1"   styleClass="f06"
				value="#{attwriternetworkBB.avgDate}"></h:outputLabel>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="40" class="table_rlbt">ʵ������</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
			<h:inputText styleClass="input" style="border:0px;" id="totalday" 
				value="#{attwriternetworkBB.kqglLeaverDayValue}" readonly="true"/>
				<f:verbatim>
				</td>
			</tr>

			<tr>
				<td align="center" height="100" style="border: 1px solid #666666">
				</f:verbatim> <h:outputText escape="false"
					value="����" /> <f:verbatim></td>
				<td class="table_rlbt" align="left" valign="top" colspan="6"
					style="padding-left: 6px;"></f:verbatim> 
<h:inputTextarea id="desc" value="#{attwriternetworkBB.reasonValue}"
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
				<td align="center" height="40" class="table_rlbt">����</td>
				<td height="40" colspan=6 class="table_rlbt">
				</f:verbatim>
            <h:commandButton styleClass="button01" value="�ύ" action="#{attwriternetworkBB.save}"/>
				<f:verbatim>
				</td>
			</tr>
			
		</table>
				</td>
			</tr>
			<tr>
				<td>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
