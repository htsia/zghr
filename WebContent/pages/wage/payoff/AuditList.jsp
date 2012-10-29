<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript" language="javascript">
    function dosetItem( ){
        window.showModalDialog("/wage/payoff/WageAuditItemList.jsf", "", "dialogWidth:580px; dialogHeight:330px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
        return true;
    }
    function dosetType( ){
        window.showModalDialog("/wage/payoff/WageAuditTypeList.jsf", "", "dialogWidth:430px; dialogHeight:330px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
        return true;
    }
</script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.pageInit}"/>
<f:verbatim>
    <table height=98% width=96% align="center">
    <tr><td height=8>
</f:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="薪酬管理 -> #{wage_dateBB.name0654}"/>
           </h:panelGroup>

            <h:panelGroup>
                <h:inputText readonly="true" id="yearmonth" value="#{wage_flowBB.yearmonth}"></h:inputText>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:yearmonth')"/>
                <h:commandButton value="查询" styleClass="button01" action="#{wage_flowBB.list}"></h:commandButton>
                <h:selectBooleanCheckbox value="#{wage_flowBB.showAll}" onclick="submit()" valueChangeListener="#{wage_flowBB.changeShowAll}"></h:selectBooleanCheckbox>
                <h:outputText value="显示所有"></h:outputText>
                <h:outputText escape="false" value="&nbsp;&nbsp;"></h:outputText>
                <h:commandButton value="审批类别设置" styleClass="button01" onclick="return dosetType();" action="#{wage_flowBB.list}"></h:commandButton>
                <h:commandButton value="审批项目设置" styleClass="button01" onclick="return dosetItem();" action="#{wage_flowBB.list}"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
<f:verbatim>
     </td></tr>

    <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
            <h:dataTable value="#{wage_flowBB.list}" var="list"      id="setlist"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_left,td_middle_center,td_middle,td_middle_center"
                         styleClass="table03" width="100%">

                <h:column>
                    <c:facet name="header"><h:outputText value="操作"/></c:facet>
                    <h:commandButton value="查看流程" id="showFlow" type="button" onclick="return showWorkFlowLogByLinkID('#{list.dateId}')" styleClass="button01" rendered="#{wage_dateBB.workFlow=='1'}"></h:commandButton>

                    <h:commandButton styleClass="button01" action="#{wage_flowBB.findDate}" value="审批" rendered="#{list.isApproving}">
                        <x:updateActionListener property="#{wage_flowBB.date.dateId}" value="#{list.dateId}"/>
                        <x:updateActionListener property="#{wage_flowBB.setName}" value="#{list.setName}"/>
                    </h:commandButton>

                    <h:commandButton styleClass="button01" action="#{wage_flowBB.findDateToView}" value="查看" rendered="#{!list.isApproving}">
                        <x:updateActionListener property="#{wage_flowBB.date.dateId}" value="#{list.dateId}"/>
                        <x:updateActionListener property="#{wage_flowBB.setName}" value="#{list.setName}"/>
                    </h:commandButton>

                    <h:commandButton styleClass="button01" action="#{wage_computeBB.auditGather}" value="汇总计算" rendered="false">
                        <x:updateActionListener property="#{wage_computeBB.setId}" value="#{list.setId}"/>
                        <x:updateActionListener property="#{wage_computeBB.dateId}" value="#{list.dateId}"/>
                        <x:updateActionListener property="#{wage_computeBB.payoffDate}" value="#{list.yearMonth}"/>
                        <x:updateActionListener property="#{wage_computeBB.unitId}" value="#{list.unitID}"/>
                    </h:commandButton>

                </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="账套名称"/></c:facet>
                    <h:outputText value="#{list.setName}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="描述"/></c:facet>
                    <h:outputText value="#{list.desc}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="最后计算日期"/></c:facet>
                    <h:outputText value="#{list.calcDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="审批时间"/></c:facet>
                    <h:outputText value="#{list.approveDate}"/>
                </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="状态"/></c:facet>
                    <h:outputText value="#{list.statusName}"/>
                </h:column>

            </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
     </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:setlist");
</script>
