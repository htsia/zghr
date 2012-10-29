<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function selPerson(){
        window.showModalDialog("/employee/postChange/selPostChangePerson.jsf?isMe=true", null, "dialogWidth:600px; dialogHeight:330px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
</script>

<h:form id="form1">
    <h:inputHidden value="#{empPersonServiceBB.initProbation}"></h:inputHidden>
    <f:verbatim>
		<table height=96% width=98% cellpadding="0" cellspacing="0" align="center">
        <tr height=5><td colspan="4"></td></tr>
        <tr height=8>
            <td align="center" width="15%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/employee/probation/selfProbation.jsf?Init=true">ת��</a></td>
            <td align="center" width="15%" class=tab>&nbsp;<a href="/employee/postChange/selfPostChange.jsf?Init=true">ת��</a></td>
            <td align="center" width="15%" class=tab>&nbsp;<a href="/employee/retire/selfRetire.jsf?Init=true">��ְ</a></td>
            <td class=notab>&nbsp;</td>
         </tr>

         <tr>
				<td colspan="4" valign="top" align="left">
					<div class="tabbody" height="100%" width="100%"  id=datatable>
						<table width="100%" cellpadding="0" cellspacing="0" align="center">
                         <tr><td align="right">
                        </f:verbatim>
                            <h:commandButton value="�������" styleClass="button01" action="#{empPersonServiceBB.saveProbationApply}" rendered="#{sys_commonInfoBB.enableSelfProbation}"/>
                        <f:verbatim>
                         </td></tr>

                         <tr><td align="right" height=10></td></tr>

                         <tr><td>
                        </f:verbatim>
                            <h:dataTable value="#{empPersonServiceBB.probationList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.personId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�Ա�"/></c:facet>
                <h:outputText value="#{list.sex}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="���ڻ���"/></c:facet>
                <h:outputText value="#{list.orgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="���ڸ�λ"/></c:facet>
                <h:outputText value="#{list.postName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
                <h:outputText value="#{list.postLevel}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��Ա���"/></c:facet>
                <h:outputText value="#{list.personType}"/>
            </h:column>
             <h:column>
                <c:facet name="header"><h:outputText value="���뱾��˾ʱ��"/></c:facet>
                <h:outputText value="#{list.unitTime}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="Ԥ��ת������"/></c:facet>
                <h:outputText value="#{list.planPassDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="ת������ʱ����"/></c:facet>
                <h:outputText value="#{list.haveDays}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="�鿴����" onclick="return showWorkFlowLogByLinkID('#{list.personId}')" styleClass="button01" rendered="#{empprobastionmgrBB.mustApprov=='0'}"></h:commandButton>
            </h:column>
        </h:dataTable>
						<f:verbatim>
                         </td></tr>
                         </table>
                    </div>
                 </td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>