<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
%>

<script type="text/javascript">
    function apply(){
        var act="/employee/info/PersonSelfRetire.jsf?mode=<%=Constants.SELF_RETIRE_TYPE%>&title=离职申请&perids=<%=user.getUserId()%>&afterType=<%=Constants.SELF_RETIRE_AFTER_TYPE%>";
        window.showModalDialog(act, null, "dialogWidth:680px; dialogHeight:230px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
</script>

<h:form id="form1">
    <h:inputHidden value="#{empPersonServiceBB.initRetire}"></h:inputHidden>
    <f:verbatim>
		<table height=96% width=98% cellpadding="0" cellspacing="0" align="center">
        <tr height=5><td colspan="4"></td></tr>
        <tr height=8>
            <td align="center" width="15%" class=tab>&nbsp;<a href="/employee/probation/selfProbation.jsf?Init=true">转正</a></td>
            <td align="center" width="15%" class=tab>&nbsp;<a href="/employee/postChange/selfPostChange.jsf?Init=true">转岗</a></td>
            <td align="center" width="15%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/employee/retire/selfRetire.jsf?Init=true">离职</a></td>
            <td class=notab>&nbsp;</td>
         </tr>

         <tr>
				<td colspan="4" valign="top" align="left">
					<div class="tabbody" height="100%" width="100%"  id=datatable>
						<table width="100%" cellpadding="0" cellspacing="0" align="center">
                         <tr><td align="right">
                        </f:verbatim>
                            <h:commandButton value="提出申请" styleClass="button01" onclick="return apply();"/>
                        <f:verbatim>
                         </td></tr>

                         <tr><td align="right" height=10></td></tr>

                         <tr><td>
                        </f:verbatim>
                            <h:dataTable value="#{empPersonServiceBB.retireList}"
                                var="list" align="center" id="dateList"
                                headerClass="td_top tr_fixrow"
                                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                                styleClass="table03" width="95%">
                                <h:column>
                                    <c:facet name="header"><h:outputText value="申请时间"/></c:facet>
                                    <h:outputText value="#{list.applyDate}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="人员姓名"/></c:facet>
                                    <h:outputText value="#{list.persName}"/>
                                </h:column>
                                <h:column>
                                    <c:facet name="header"><h:outputText value="入职部门"/></c:facet>
                                    <h:outputText value="#{list.orgName}"/>
                                </h:column>
                                <h:column>
                                    <c:facet name="header"><h:outputText value="操作"/></c:facet>
                                    <h:commandButton styleClass="button01" value="查看流程" type="button" onclick="return showWorkFlowLogByLinkID('#{list.itemID}')"></h:commandButton>
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