<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" language="javascript">
        function doGroupPayoff(dateid ){
            window.showModalDialog("/wage/payoff/GroupPayoffEdit.jsf?dateID="+dateid, "", "dialogWidth:580px; dialogHeight:380px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
            return false;
        }
        function doViewGroupPayoff(dateid ){
            window.showModalDialog("/wage/payoff/GroupPayoffView.jsf?dateID="+dateid, "", "dialogWidth:580px; dialogHeight:380px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
            return false;
        }
   </script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.pageInit}"/>
    <c:verbatim>
    <table height=98% width=98% align="center">
    <tr><td height=8>
    </c:verbatim>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="薪酬管理 -> 薪资统一发放"/>
       </h:panelGroup>

        <h:panelGroup>
            <h:inputText readonly="true" id="yearmonth" value="#{wage_flowBB.yearmonth}"></h:inputText>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:yearmonth')"/>
            <h:commandButton value="查询" styleClass="button01" action="#{wage_flowBB.groupPayoffList}"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
<c:verbatim>
    </td></tr>
    
    <tr><td height=8>
    </td></tr>

    <tr><td>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
        <h:dataTable value="#{wage_flowBB.list}" var="list" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_left,td_middle_center,td_middle,td_middle_center"
                     styleClass="table03" width="100%">

            <h:column>
                <c:facet name="header"><h:outputText value="账套名称"/></c:facet>
                <h:outputText value="#{list.setName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="业务日期"/></c:facet>
                <h:outputText value="#{list.date}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list.desc}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.statusName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="复核意见"/></c:facet>
                <h:outputText value="#{list.checkContent}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="审批意见"/></c:facet>
                <h:outputText value="#{list.approveContent}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="集团统一发放状态"/></c:facet>
                <h:outputText value="#{list.groupPayoffStatusDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton  value="发放" rendered="#{ list.status=='3' && list.groupPayoffStatus!='1'}" styleClass="button01" onclick="doGroupPayoff('#{list.dateId}');"></h:commandButton>
                <h:commandButton  value="查看历史"  type="button" styleClass="button01" onclick="doViewGroupPayoff('#{list.dateId}');"></h:commandButton>
            </h:column>
        </h:dataTable>
<c:verbatim>
        </div>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
