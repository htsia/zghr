<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doShowStatus(orguid){
             window.showModalDialog("/report/showRptStatus.jsf?Orguid="+orguid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
             return false;
        }

    </script>

<x:saveState value="#{Rpt_GroupIndexBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{Rpt_GroupIndexBB.initShowChildStatus}"/>
    <h:inputHidden id="date" value="#{Rpt_GroupIndexBB.processDate}"/>
    <c:verbatim>
    <table height=98% width=98% align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
        <tr>
            <td class=td_title height=8>
</c:verbatim>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" 报表管理 ->  查看基层进展"/>
<c:verbatim>
            </td>
            <td class=td_title height=8 align="right">
</c:verbatim>
                <h:outputText value="统计时间:#{Rpt_GroupIndexBB.processDate}"></h:outputText>
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
                    <h:dataTable value="#{Rpt_GroupIndexBB.statusList}" var="list" align="center"      id="dateList"
                                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                                         styleClass="table03" width="90%" >
                                <h:column>
                                    <c:facet name="header"><h:outputText value="单位名称"/></c:facet>
                                    <h:outputText value="#{list.orgName}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="统计人员"/></c:facet>
                                    <h:outputText value="#{list.createID}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="联系电话"/></c:facet>
                                    <h:outputText value="#{list.officeTel}"/>
                                </h:column>

                                <h:column>
                                    <c:facet name="header"><h:outputText value="状态"/></c:facet>
                                    <h:outputText value="#{list.stautsDes}"/>
                                </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                                <h:commandButton onclick="return doShowStatus('#{list.orguid}');" type="button" styleClass="button01" value="详细情况" />
                                <h:commandButton value="退回" action="#{Rpt_GroupIndexBB.returnBack}" styleClass="button01" rendered="#{list.stauts=='1'}">
                                     <x:updateActionListener property="#{Rpt_GroupIndexBB.dateId}" value="#{list.itemID}"></x:updateActionListener>
                                </h:commandButton>
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