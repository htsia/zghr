<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{Rpt_GroupIndexBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{Rpt_GroupIndexBB.initShowrptStatus}"/>
    <h:inputHidden id="date" value="#{Rpt_GroupIndexBB.processDate}"/>
    <c:verbatim>
    <table height=98% width=98% align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
        <tr>
            <td class=td_title height=8>
</c:verbatim>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 报表管理 ->  查看状态"/>
<c:verbatim>
            </td>
            <td class=td_title height=8 align="right">
 </c:verbatim>
                <h:commandButton type="button" onclick="window.close();" styleClass="button01" value="关闭"></h:commandButton>
<c:verbatim>
            </td>
        </tr>

        <tr><td colspan=2 height=8>
        </td></tr>

        <tr>
            <td colspan=2>
                <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
                    <h:dataTable value="#{Rpt_GroupIndexBB.statusList}" var="list" align="center"   id="dateList"
                                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                                         styleClass="table03" width="90%" >

                        <h:column>
                            <c:facet name="header"><h:outputText value="编号"/></c:facet>
                            <h:outputText value="#{list.rptcode}"/>
                        </h:column>

                        <h:column>
                            <c:facet name="header"><h:outputText value="名称"/></c:facet>
                            <h:outputText value="#{list.rptDesc}"/>
                        </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="统计时间"/></c:facet>
                                    <h:outputText value="#{list.staticdate}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="表内校验"/></c:facet>
                                    <h:outputText value="#{list.innerCheckDes}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="表间校验"/></c:facet>
                                    <h:outputText value="#{list.outterCheckDes}"/>
                                </h:column>
                            </h:dataTable>
<c:verbatim>
                </div>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
