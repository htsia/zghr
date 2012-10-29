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
            <td align="center" width="15%" class=tab>&nbsp;<a href="/employee/probation/selfProbation.jsf?Init=true">转正</a></td>
            <td align="center" width="15%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/employee/postChange/selfPostChange.jsf?Init=true">转岗</a></td>
            <td align="center" width="15%" class=tab>&nbsp;<a href="/employee/retire/selfRetire.jsf?Init=true">离职</a></td>
            <td class=notab>&nbsp;</td>
         </tr>

         <tr>
				<td colspan="4" valign="top" align="left">
					<div class="tabbody" height="100%" width="100%"  id=datatable>
						<table width="100%" cellpadding="0" cellspacing="0" align="center">
                         <tr><td align="right">
                        </f:verbatim>
                            <h:commandButton value="提出申请" styleClass="button01" onclick="selPerson();" action="#{empPersonServiceBB.queryEmpPostChangeList}"/>
                            <h:commandButton value="流程说明" styleClass="button01" type="button" rendered="#{!sys_commonInfoBB.directPostChange}" onclick="showWorkDefine('RYGL_002');"/>
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
                                        申请日期
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.applyDate}" />
                                </h:column>

                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2423", "原部门")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.oldDept}" />
                                </h:column>
                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2422", "原岗位")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.oldPost}" />
                                </h:column>

                                <h:column rendered="#{sys_commonInfoBB.useTitle}">
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2025", "原职务")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.oldJob}" />
                                </h:column>

                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2421", "新部门")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.newDept}" />
                                </h:column>

                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2020", "新岗位")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.newPost}" />
                                </h:column>

                                <h:column rendered="#{sys_commonInfoBB.useTitle}">
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2026", "新职务")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.newJob}" />
                                </h:column>

                                <h:column >
                                    <c:facet name="header">
                                    <f:verbatim>
                                        调动原因
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.changeReasonDes}" />
                                </h:column>

                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2425", "人事生效日期")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.hrValidDate}" />
                                </h:column>
                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("RYGL-2424", "薪资调整日期")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.wageValidDate}" />
                                </h:column>
                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("XTGL-1051", "状态")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:outputText value="#{list.statusDes}" />
                                </h:column>
                                <h:column>
                                    <c:facet name="header">
                                    <f:verbatim>
                                        <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
                                    </f:verbatim>
                                    </c:facet>
                                    <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
                                        action="#{empPersonServiceBB.deletePostChangeApply}" styleClass="button01"
                                        rendered="#{list.status=='0'}">
                                        <x:updateActionListener  property="#{empPersonServiceBB.postChangeId}" value="#{list.postChangeId}"/>
                                    </h:commandButton>
                                    
                                    <h:commandButton value="查看流程" type="button"
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