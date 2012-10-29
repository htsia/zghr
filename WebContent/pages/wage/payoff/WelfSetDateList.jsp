<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forAddDate() {
            var setId = form1.all("form1:setId").value
            if(setId==null||setId==""){
                alert("请选择帐套");
                return false;
            }
            reval = window.showModalDialog("/wage/payoff/DateEdit.jsf", null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
            //theURL, winName, features, width, hight, scrollbars, top, left
            if (reval != null && reval != "") {
                var arg = reval.split("|");
                form1.all('form1:date').value = arg[0];
                form1.all('form1:yearMonth').value = arg[1];
                form1.all('form1:desc').value = arg[2];
                return true;
            } else {
                return false;
            }
        }
        function doDetailPopup(id) {
            var dateId = id;
            popup = window.open("/wage/payoff/WageDetailView.jsf?dateId=" + dateId, "员工工资发放明细", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }
    </script>
</head>

<body>
<x:saveState value="#{wage_dateBB}"/>
<h:inputHidden id="pageInit" value="#{wage_dateBB.pageInit}"/>
<h:form id="form1">
    <h:inputHidden id="str" value=""/>
    <h:inputHidden id="date" value="#{wage_dateBB.date.date}"/>
    <h:inputHidden id="desc" value="#{wage_dateBB.date.desc}"/>
    <h:inputHidden id="yearMonth" value="#{wage_dateBB.date.yearMonth}"/>
    <h:inputHidden id="setName" value="#{wage_dateBB.setName}"/>

    <%--<h:inputHidden id="setId" value="#{wage_dateBB.setId}"/>--%>
    <h:panelGrid width="98%" align="center"  columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0" cellspacing="0">
        <h:outputText value="   福利项目处理"/>
    </h:panelGrid>
    <h:panelGrid columns="2" cellspacing="2" width="89%"
                 align="center" >
        <h:outputText value="发薪单位：#{wage_dateBB.unitName}"/>
        <%--<h:outputText value="#{wage_dateBB.setName}"/>--%>
        <h:panelGroup>
        <h:outputText value="薪资账套："></h:outputText>
        <h:selectOneMenu id = "setId" value="#{wage_dateBB.setId}"  onchange="submit()"
                  valueChangeListener="#{wage_dateBB.queryDateList}">
             <c:selectItems value="#{wage_dateBB.setList}"/>
        </h:selectOneMenu>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="90%" >
        <h:panelGrid columns="5" cellspacing="2">
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
            <h:commandButton value="查询" action="#{wage_dateBB.dateList}" styleClass="button01" onclick="return forsubmit(document.forms(0))"/>
        </h:panelGrid>
        <h:panelGrid columns="2" cellspacing="2">
            <h:commandButton value="添加业务日期" action="#{wage_dateBB.save}" styleClass="button01" onclick="return forAddDate()"/>
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
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="删除" styleClass="button01" rendered="#{list.operDel}"
                                 action="#{wage_dateBB.delete}" onclick="return confirm('确认删除？')">
                    <x:updateActionListener property="#{wage_dateBB.date.dateId}" value="#{list.dateId}"/>
                </h:commandButton>
                <h:commandButton value="成本归结" action="#{wage_computeBB.queryPersonBySetId}"
                                 styleClass="button01" rendered="#{list.operCompute}">
                    <x:updateActionListener property="#{wage_computeBB.dateId}" value="#{list.dateId}"/>
                    <x:updateActionListener property="#{wage_computeBB.payoffDate}" value="#{list.date}"/>
                    <x:updateActionListener property="#{wage_computeBB.setId}" value="#{wage_dateBB.setId}"/>
                    <x:updateActionListener property="#{wage_computeBB.unitId}" value="#{wage_dateBB.unitId}"/>
                    <x:updateActionListener property="#{wage_computeBB.setName}" value="#{wage_dateBB.setName}"/>
                    <x:updateActionListener property="#{wage_computeBB.unitName}" value="#{wage_dateBB.unitName}"/>
                    <x:updateActionListener property="#{wage_computeBB.operCompute}" value="#{list.operCompute}"/>
                </h:commandButton>
                <h:commandButton value="查看明细" styleClass="button01" rendered="#{list.operView}"
                                 type="button" onclick="doDetailPopup('#{list.dateId}')"/>
                <%--<h:commandButton value="查看变动信息" styleClass="button01" rendered="#{list.operView}"--%>
                                 <%--type="button" onclick="doNotePopup('#{list.dateId}')"/>--%>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
</h:form>
</body>
</html>