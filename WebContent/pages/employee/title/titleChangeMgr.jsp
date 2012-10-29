<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">

function selPerson(){
	window.showModalDialog("/employee/title/selTitleChangePerson.jsf", null, "dialogWidth:600px; dialogHeight:380px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function setWage(id){
    window.showModalDialog("/employee/title/wageChangeEdit.jsf?titleChangeId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function showWage(id){
    window.showModalDialog("/employee/title/showWageChangeEdit.jsf?titleChangeId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function showTable(changId){
	url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
	window.open(url);
}
function SetOrgChange() {
    window.showModalDialog("/employee/title/orgTitleChangeEdit.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function SetRule(){
	 window.showModalDialog("/employee/title/orgChangeWageList.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
	 return true;
}
</script>

<x:saveState value="#{empTitleChangeBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{empTitleChangeBB.pageInit}"/>
    <h:inputHidden id="personStr" value=""/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" ��Ա���� -> ְ�Ʊ䶯"/>
      				<f:verbatim>
               </td>
               <td class=td_title align="right">
                  </f:verbatim>
               	<h:outputText value="��ʼ" />
                        <h:selectBooleanCheckbox value="#{empTitleChangeBB.apply}" onclick="submit();" valueChangeListener="#{empTitleChangeBB.queryApply}"/>
                        <h:outputText value=" "/>
                        <h:outputText value="��Ч" />
                        <h:selectBooleanCheckbox value="#{empTitleChangeBB.efficent}" onclick="submit();" valueChangeListener="#{empTitleChangeBB.queryEfficent}" />
                        <h:outputText value=" "/>
                        <h:commandButton value="ְ���϶�����"  styleClass="button01" onclick="return SetOrgChange()"/>
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
               		<c:selectItems value="#{empTitleChangeBB.regTableList}"/>
           	    </h:selectOneMenu>
                <h:outputText value=" "></h:outputText>
                <h:outputText value="��¼��:#{empTitleChangeBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{empTitleChangeBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{empTitleChangeBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{empTitleChangeBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{empTitleChangeBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{empTitleChangeBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{empTitleChangeBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{empTitleChangeBB.last}" styleClass="button01"></h:commandButton>
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
        <x:dataTable value="#{empTitleChangeBB.personList}" var="list" align="center" rowIndexVar="index" id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
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
                <c:facet name="header"><h:outputText value="ְ������"/></c:facet>
                <h:outputText value="#{list.zhicheng}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="Ƹ��ʱ��"/></c:facet>
                <h:outputText value="#{list.pinrenDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="Ƹ���ļ���"/></c:facet>
                <h:outputText value="#{list.pinrenNum}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�Ƿ����"/></c:facet>
                <h:outputText value="#{list.isMost}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�Ƿ�Ƹ��"/></c:facet>
                <h:outputText value="#{list.isPinren}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="��ע"/></c:facet>
                <h:outputText value="#{list.remark}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{empTitleChangeBB.delete}" styleClass="button01" rendered="#{list.status=='0'}">
                	<x:updateActionListener value="#{list.titleChangeId}" property="#{empTitleChangeBB.titleChangeId}"></x:updateActionListener>
                </h:commandButton>
                <h:commandButton value="��Ч" onclick="return confirm('ȷ��Ҫ��Ч��?');" action="#{empTitleChangeBB.perfict}" styleClass="button01" rendered="#{list.status=='0'}">
                	<x:updateActionListener value="#{list.titleChangeId}" property="#{empTitleChangeBB.titleChangeId}"></x:updateActionListener>
                </h:commandButton>
                                 <h:commandButton value="��Ա��Ϣ" styleClass="button01" onclick="forModifyPersonDetail('#{list.personId}')"/>
                <h:commandButton value="�ⶨн��" styleClass="button01" onclick="return setWage('#{list.titleChangeId}');" rendered="#{list.status=='0'}"/>
                <h:commandButton value="�鿴н��" styleClass="button01" onclick="return showWage('#{list.titleChangeId}');" rendered="#{list.status=='1'}"/>
                <h:commandButton value="��ʾ���" styleClass="button01" onclick="return showTable('#{list.titleChangeId}');"/>
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