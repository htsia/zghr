<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
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
<x:saveState value="#{empPersonServiceBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{empPersonServiceBB.pageInit}"></h:inputHidden>
    <f:verbatim>
		<table height=96% width=98% cellpadding="0" cellspacing="0" align="center">
        <tr height=5><td colspan="4"></td></tr>
        <tr height=8>
            <td align="center" width="15%" class=tab>&nbsp;<a href="/employee/probation/selfProbation.jsf?Init=true">ת��</a></td>
            <td align="center" width="15%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/employee/postChange/selfPostChange.jsf?Init=true">ת��</a></td>
            <td align="center" width="15%" class=tab>&nbsp;<a href="/employee/retire/selfRetire.jsf?Init=true">��ְ</a></td>
            <td class=notab>&nbsp;</td>
         </tr>

         <tr>
				<td colspan="4" valign="top" align="left">
					<div class="tabbody" height="100%" width="100%"  id=datatable>
						<table width="100%" cellpadding="0" cellspacing="0" align="center">
                         <tr><td align="right">
                        </f:verbatim>
                            <h:commandButton value="�������" styleClass="button01" onclick="selPerson();" action="#{empPersonServiceBB.queryEmpPostChangeList}"/>
                            <h:commandButton value="����˵��" styleClass="button01" type="button" rendered="#{!sys_commonInfoBB.directPostChange}" onclick="showWorkDefine('RYGL_002');"/>
                        <f:verbatim>
                         </td></tr>

                         <tr><td align="right" height=10></td></tr>

                         <tr><td>
                        </f:verbatim>
                            <h:dataTable value="#{empPersonServiceBB.empPostChangeList}"
                                var="list" align="center" id="dateList"
                                headerClass="td_top tr_fixrow"
                                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
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
                                        ��������
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.applyDate}" />
                                </h:column>

                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2423", "ԭ����")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.oldDept}" />
                                </h:column>
                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2422", "ԭ��λ")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.oldPost}" />
                                </h:column>

                                <h:column rendered="#{sys_commonInfoBB.useTitle}">
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2025", "ԭְ��")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.oldJob}" />
                                </h:column>

                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2421", "�²���")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.newDept}" />
                                </h:column>

                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2020", "�¸�λ")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.newPost}" />
                                </h:column>

                                <h:column rendered="#{sys_commonInfoBB.useTitle}">
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2026", "��ְ��")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.newJob}" />
                                </h:column>

                                <h:column >
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
                                        <%=LanguageSupport.getResource("RYGL-2425", "������Ч����")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.hrValidDate}" />
                                </h:column>
                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2424", "н�ʵ�������")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.wageValidDate}" />
                                </h:column>
                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("XTGL-1051", "״̬")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.statusDes}" />
                                </h:column>
                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("YXGL-1026", "����")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
                                        action="#{empPersonServiceBB.deletePostChangeApply}" styleClass="button01"
                                        rendered="#{list.status=='0'}">
                                        <x:updateActionListener  property="#{empPersonServiceBB.postChangeId}" value="#{list.postChangeId}"/>
                                    </h:commandButton>
                                    
                                    <h:commandButton value="�鿴����" type="button"
                                        onclick="return showWorkFlowLogByLinkID('#{list.postChangeId}')"
                                        styleClass="button01" >
                                    </h:commandButton>
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