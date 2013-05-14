<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.sys.pojo.bo.WFTypeBO"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function selPerson(){
	window.showModalDialog("/employee/postChange/selPostChangePerson.jsf?act=init", null, "dialogWidth:600px; dialogHeight:330px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson(){
	  var str=" |";
    chk=document.forms(0).selectItem;
    if (checkMutilSelect(chk)){
        var size = chk.length;
        if (size == null) {
            if (chk.checked) {
                str+=chk.value;
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (chk[i].checked) {
                    if (i==0){
                        str+=chk[i].value;
                    }
                    else{
                        str+=","+chk[i].value;
                    }
                }
            }
        }
       if(str != null && str!=""){
      	 var vars=str.split("|");
      	 document.getElementById("form1:personStr").value = vars[1];
      }
    }
}
function selectPerson4(){
	  var str="";
	  chk=document.forms(0).selectItem;
	  if (checkMutilSelect(chk)){
	      var size = chk.length;
	      if (size == null) {
	          if (chk.checked) {
	              str+=chk.value;
	          }
	      } else {
	          for (var i = 0; i < size; i++) {
	              if (chk[i].checked) {
	                  if (i==0){
	                      str+=chk[i].value;
	                  }
	                  else{
	                      str+=","+chk[i].value;
	                  }
	              }
	          }
	      }
	    	 window.showModalDialog("/employee/postChange/efictPostChange.jsf?changeIds="+str, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
	    	 document.getElementById('form1:refresh').click();
	    	 return true;
      }
      else{
           alert("��ѡ��Ҫ��Ч����Ա��");
           return false;
       }
}

function selectPerson2(id){
    window.showModalDialog("/employee/postChange/postChangeWageEdit.jsf?postChangeId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson3(id){
    window.showModalDialog("/employee/postChange/postChangeWageEdit2.jsf?postChangeId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function showTable(changId){
	var rptID= document.getElementById("form1:ReportID").value;
	if(rptID=='-1'){
		alert("����ѡ�����");
		return false;
	}
	url="/pages/report/ServerReportShow.jsp?RptCode="+rptID+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
	window.open(url);
}
function showFlowDefine(){
     showWorkDefine('<%=WFTypeBO.RYGL_POST_CHANGE%>');
}
</script>

<x:saveState value="#{emppostChangeMgrBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{emppostChangeMgrBB.pageInit}" />
	<h:inputHidden id="personStr" value="" />
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"
		action="#{emppostChangeMgrBB.queryEmpPostChangeList}"></h:commandButton>
	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8>
					<table width="95%" borer=1>
						<tr>
							<td align="left"></f:verbatim> <h:outputText escape="false"
									value="<strong>��ǰ������#{emppostChangeMgrBB.orgName}</strong>" />
								<h:outputText value="  �������ţ�" /> <h:inputText
									value="#{emppostChangeMgrBB.name}" size="15" /> <h:outputText
									value="  ʱ���" /> <h:inputText
									value="#{emppostChangeMgrBB.time}" id="time"
									styleClass="input Wdate" size="15" readonly="true"
									alt="����|1|d|50||"
									onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:time'})"
									onkeypress="enterKeyDown('form1:time')" /> <h:outputText
									value="��" /> <h:inputText value="#{emppostChangeMgrBB.time2}"
									id="time2" styleClass="input Wdate" size="15" readonly="true"
									alt="����|1|d|50||"
									onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:time2'})"
									onkeypress="enterKeyDown('form1:time2')" /> <h:commandButton
									value="��ѯ" styleClass="button01"
									onclick="return disPlayProcessBar();"
									action="#{emppostChangeMgrBB.queryEmpPostChangeList}"></h:commandButton>
								<f:verbatim>
							</td>
							<td align="right"></f:verbatim> <h:commandButton value="ѡ����Ա"
									styleClass="button01" onclick="return selPerson()" /> <h:outputText
									value="  " /> <h:commandButton value="����˵��" type="button"
									styleClass="button01"
									rendered="#{emppostChangeMgrBB.mustApprov}"
									onclick="showFlowDefine();" /> <h:outputText value="  " /> <h:commandButton
									value="����" styleClass="button01" onclick="selectPerson();"
									action="#{emppostChangeMgrBB.approvid}"
									rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:commandButton
									value="������Ϣ��Ч" styleClass="button01"
									onclick="return selectPerson4();" type="button" /> <f:verbatim>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="2"></f:verbatim> <h:outputText value=" "
									rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:outputText
									value="����" rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:selectBooleanCheckbox
									value="#{emppostChangeMgrBB.apprving}" onclick="submit();"
									valueChangeListener="#{emppostChangeMgrBB.queryApprving}"
									rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:outputText
									value=" " rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:outputText
									value="��׼" rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:selectBooleanCheckbox
									value="#{emppostChangeMgrBB.apprived}" onclick="submit();"
									valueChangeListener="#{emppostChangeMgrBB.queryApprived}"
									rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:outputText
									value=" " /> <f:verbatim>
									<%=LanguageSupport
							.getResource("RYGL-2035", "������Ϣ��Ч")%>
								</f:verbatim> <h:selectBooleanCheckbox value="#{emppostChangeMgrBB.efficent}"
									onclick="submit();"
									valueChangeListener="#{emppostChangeMgrBB.queryEfficent}" /> <h:outputText
									value=" " rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:outputText
									value="�˻�" rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:selectBooleanCheckbox
									value="#{emppostChangeMgrBB.refuse}" onclick="submit();"
									valueChangeListener="#{emppostChangeMgrBB.queryRsfuse}"
									rendered="#{emppostChangeMgrBB.mustApprov}" /> <h:panelGroup>
									<h:selectOneMenu id="ReportID" style="width:190px">
										<c:selectItems value="#{emppostChangeMgrBB.regTableList}" />
									</h:selectOneMenu>
									<h:outputText value=" "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1043",
								"��¼��")%>:
              	</f:verbatim>
									<h:outputText value="#{emppostChangeMgrBB.mypage.totalRecord}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport
								.getResource("COMM-1044", "ҳ��")%>:
              	</f:verbatim>
									<h:outputText value="#{emppostChangeMgrBB.mypage.totalPage}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1045",
								"ÿҳ��")%>
									</f:verbatim>
									<h:outputText value="#{emppostChangeMgrBB.mypage.pageSize}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1046",
								"��ǰΪ��")%>
									</f:verbatim>
									<h:outputText value="#{emppostChangeMgrBB.mypage.currentPage}"></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1047", "ҳ")%>
									</f:verbatim>
									<h:commandButton value="��ҳ"
										action="#{emppostChangeMgrBB.first}" styleClass="button01"></h:commandButton>
									<h:commandButton value="��ҳ" action="#{emppostChangeMgrBB.pre}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="��ҳ" action="#{emppostChangeMgrBB.next}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="βҳ" action="#{emppostChangeMgrBB.last}"
										styleClass="button01"></h:commandButton>
									<h:outputText value="  "></h:outputText>
								</h:panelGroup> <f:verbatim>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable value="#{emppostChangeMgrBB.empPostChangeList}"
							var="list" align="center" id="dateList"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle,td_middle,td_middle_center,td_middle,td_middle,td_middle,td_middle_center,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<f:facet name="header">
									<f:verbatim escape="false">
										<input type="checkbox" name="all"
											onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)" />
									</f:verbatim>
								</f:facet>
								<f:verbatim escape="false">
									<div align="center">
										<input type="checkbox" name="selectItem"
											value="</f:verbatim>
                    <h:outputText value="#{list.postChangeId}"/>
                    <f:verbatim escape="false">" />
									</div>
								</f:verbatim>
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"MSG-0010", "����")%>
									</f:verbatim>
								</c:facet>
								<f:verbatim>
									<a
										href="javascript:forModifyPersonDetail('</f:verbatim><h:outputText value="#{list.personId}" /><f:verbatim>')">
								</f:verbatim>
								<h:outputText value="#{list.personName}" />
								<f:verbatim>
									</a>
								</f:verbatim>

							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"RYGL-2423", "ԭ����")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldDept}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"RYGL-2422", "ԭ��λ")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldPost}" />
							</h:column>

							<h:column rendered="#{sys_commonInfoBB.useTitle}">
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"RYGL-2025", "ԭְ��")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.oldJob}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"RYGL-2421", "�²���")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newDept}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"RYGL-2020", "�¸�λ")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newPost}" />
							</h:column>

							<h:column rendered="#{sys_commonInfoBB.useTitle}">
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"RYGL-2026", "��ְ��")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.newJob}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
                                    ����ԭ��
                                </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.changeReasonDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"RYGL-2425", "������Ч����")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.hrValidDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1051", "״̬")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.statusDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<h:outputText value="������" />
								</c:facet>
								<h:outputText value="#{list.applyPersonName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"YXGL-1026", "����")%>
									</f:verbatim>
								</c:facet>
								<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
									action="#{emppostChangeMgrBB.delete}" styleClass="button01">
									<x:updateActionListener value="#{list.postChangeId}"
										property="#{emppostChangeMgrBB.postChangeId}"></x:updateActionListener>
								</h:commandButton>
								<h:commandButton value="�鿴����"
									onclick="return showWorkFlowLogByLinkID('#{list.postChangeId}')"
									styleClass="button01"
									rendered="#{emppostChangeMgrBB.mustApprov}"></h:commandButton>
								<h:commandButton value="�ⶨн��" styleClass="button01"
									onclick="return selectPerson2('#{list.postChangeId}');"
									rendered="#{list.status=='0'}" />
								
								<h:commandButton value="��ʾ���" styleClass="button01"
									onclick="return showTable('#{list.postChangeId}');" />
							</h:column>
						</h:dataTable>
						<f:verbatim>
					</div>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
<marquee id="processbar"
	style="position: absolute; display: none; border: 1px solid #000000"
	direction="right" width="300" scrollamount="5" scrolldelay="10"
	bgcolor="#ECF2FF">
	<table cellspacing="1" cellpadding="0">
		<tr height=8>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
			<td bgcolor=#3388FF width=9></td>
			<td></td>
		</tr>
	</table>
</marquee>
