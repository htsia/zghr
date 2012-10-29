<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doDetailPopup(id) {
            var dateId = id;
            popup = window.open("/wage/payoff/WageDetailView.jsf?dateId=" + dateId, "员工工资发放明细", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }
        function doNotePopup(id) {
            var dateId = id;
            popup = window.open("/wage/payoff/WageNoteView.jsf?dateId=" + dateId, "", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }
    </script>

<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageHistoryInit" value="#{wage_dateBB.pageHistoryInit}"/>
    <h:inputHidden id="str" value=""/>
    <h:inputHidden id="date" value="#{wage_dateBB.date.date}"/>
    <h:inputHidden id="desc" value="#{wage_dateBB.date.desc}"/>
    <h:inputHidden id="yearMonth" value="#{wage_dateBB.date.yearMonth}"/>
    <h:inputHidden id="yearMonth" value="#{wage_dateBB.setName}"/>

    <h:panelGrid width="98%" align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
        <h:outputText value="   薪资历史"/>
    </h:panelGrid>
    <h:panelGrid columns="2" cellspacing="2" width="89%"  align="center" >
        <h:outputText value="发薪单位：#{wage_dateBB.unitName}"/>
        <h:panelGroup>
        <h:outputText value="薪资账套："></h:outputText>
        <h:selectOneMenu id = "setId" value="#{wage_dateBB.setId}" onchange="submit()"  valueChangeListener="#{wage_dateBB.queryDateList}">
             <c:selectItems value="#{wage_dateBB.setList}"/>
        </h:selectOneMenu>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="90%" >
        <h:panelGrid columns="6" cellspacing="2">
            <h:outputText value="开始时间"/>
            <h:panelGroup>
                <h:inputText value="#{wage_dateBB.startDate}" id="startDate" alt="开始时间|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date"  onclick="PopUpCalendarDialog('form1:startdate')"/>
            </h:panelGroup>
            <h:outputText value="结束时间"/>
            <h:panelGroup>
                <h:inputText value="#{wage_dateBB.endDate}" id="endDate" alt="结束时间|0|d"/>
                <h:outputText value=" "/>
                <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:endDate')"/>
            </h:panelGroup>
            <h:commandButton value="查询" action="#{wage_dateBB.dateList}" styleClass="button01" onclick="return forsubmit(document.forms(0))">
                <%-- <x:updateActionListener property="#{wage_dateBB.qryStatus}" value="5"/>--%>
            </h:commandButton>
            <%-- <h:commandButton value="返回" styleClass="button01"  type="button" onclick="history.go(-1)"/>--%>
             <h:commandButton value="返回" styleClass="button01" action="payoffList"/>          
        </h:panelGrid>
    </h:panelGrid>

    <h:dataTable value="#{wage_dateBB.dateList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
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
            <h:outputText value="#{list.status}"/>
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
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="2" align="center" cellspacing="2">
                <h:commandButton value="查看明细" styleClass="button01" rendered="#{list.operView}"
                                 type="button" onclick="doDetailPopup('#{list.dateId}')"/>
                <h:commandButton value="查看变动信息" styleClass="button01" rendered="#{list.operView}"
                                 type="button" onclick="doNotePopup('#{list.dateId}')"/>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
</h:form>
