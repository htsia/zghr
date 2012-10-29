<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">

function selPerson(){
	window.showModalDialog("/employee/educhg/selEduChangePerson.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function setWage(id){
	
    window.showModalDialog("/employee/educhg/wageChangeEdit.jsf?eduChageId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function showWage(id){
    window.showModalDialog("/employee/educhg/showWageChangeEdit.jsf?eduChageId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function showTable(changId){
	url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
	window.open(url);
}
function SetOrgChange() {
    window.showModalDialog("/employee/educhg/orgEduChangeEdit.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function SetRule(){
	 window.showModalDialog("/employee/educhg/orgChangeWageList.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
	 return true;
}
</script>

<x:saveState value="#{empEduChangeMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{empEduChangeMgrBB.pageInit}"/>
    <h:inputHidden id="personStr" value=""/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <f:verbatim>
                       <%=LanguageSupport.getResource("RYGL-0300", "��Ա���� ")%>->
                       <%=LanguageSupport.getResource("RYGL-2230", "ѧ���䶯")%>
                    </f:verbatim>
      				<f:verbatim>
               </td>
                <td class=td_title align="right">
                 <%=LanguageSupport.getResource("RYGL-2231", "��ʼ")%>
                  </f:verbatim>
                        <h:selectBooleanCheckbox value="#{empEduChangeMgrBB.apply}" onclick="submit();" valueChangeListener="#{empEduChangeMgrBB.queryApply}"/>
                        <h:outputText value=" "/>
                        <f:verbatim>
                             <%=LanguageSupport.getResource("RYGL-2232", "��Ч")%>
                        </f:verbatim>
                        <h:selectBooleanCheckbox value="#{empEduChangeMgrBB.efficent}" onclick="submit();" valueChangeListener="#{empEduChangeMgrBB.queryEfficent}" />
                        <h:outputText value=" "/>
                        <h:commandButton value="ѧ���϶�����"  styleClass="button01" onclick="return SetOrgChange()"/>
                 <f:verbatim>
               </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <td align="right">
</f:verbatim>
				<h:panelGroup>
				<h:selectOneMenu id="ReportID" style="width:190px">
               		<c:selectItems value="#{empEduChangeMgrBB.regTableList}"/>
           	    </h:selectOneMenu>
                <h:outputText value=" "></h:outputText>
                <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "��¼��")%>��
			    </f:verbatim>
                <h:outputText value="#{empEduChangeMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            	<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "ҳ��")%>��
			    </f:verbatim>
	            <h:outputText value="#{empEduChangeMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "ÿҳ��")%>��
			    </f:verbatim>
	            <h:outputText value="#{empEduChangeMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "��ǰΪ��")%>
								</f:verbatim>
	            
	            <h:outputText value="#{empEduChangeMgrBB.mypage.currentPage}"></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "ҳ")%>
								</f:verbatim>
	            <h:commandButton value="��ҳ" action="#{empEduChangeMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{empEduChangeMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{empEduChangeMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{empEduChangeMgrBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="ѡ����Ա"  styleClass="button01" onclick="return selPerson()"/>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{empEduChangeMgrBB.personList}" var="list" align="center" rowIndexVar="index" id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
           <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��������"/></c:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="ѧ��"/></c:facet>
                <h:outputText value="#{list.newEdu}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="ѧλ"/></c:facet>
                <h:outputText value="#{list.xuewei}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="רҵ����"/></c:facet>
                <h:outputText value="#{list.zhuanyeName}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="��ѧʱ��"/></c:facet>
                <h:outputText value="#{list.ruxueDate}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="ѧϰ��ʽ"/></c:facet>
                <h:outputText value="#{list.learnType}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="ѧ��"/></c:facet>
                <h:outputText value="#{list.xuezhi}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��ҵʱ��"/></c:facet>
                <h:outputText value="#{list.eduDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��ҵѧУ"/></c:facet>
                <h:outputText value="#{list.eduUni}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{empEduChangeMgrBB.delete}" styleClass="button01" rendered="#{list.status=='0'}">
                	<x:updateActionListener value="#{list.eduChageId}" property="#{empEduChangeMgrBB.eduChageId}"></x:updateActionListener>
                </h:commandButton>
                <h:commandButton value="��Ч" action="#{empEduChangeMgrBB.perfict}" styleClass="button01" rendered="#{list.status=='0'}">
                	<x:updateActionListener value="#{list.eduChageId}" property="#{empEduChangeMgrBB.eduChageId}"></x:updateActionListener>
                </h:commandButton>
                 <h:commandButton value="��Ա��Ϣ" styleClass="button01" onclick="forModifyPersonDetail('#{list.personId}')"/>
                <h:commandButton value="�ⶨн��" styleClass="button01" onclick="return setWage('#{list.eduChageId}');" rendered="#{list.status=='0'}"/>
                <h:commandButton value="�鿴н��" styleClass="button01" onclick="return showWage('#{list.eduChageId}');" rendered="#{list.status=='1'}"/>
                <h:commandButton value="��ʾ���" styleClass="button01" onclick="return showTable('#{list.eduChageId}');"/>
            </h:column>
        </x:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>