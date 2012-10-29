<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    String flag = request.getParameter("flag");
    if (flag != null && !flag.equals("")) {
        session.removeAttribute("activeSql");
        session.removeAttribute("OBJECT");
    }
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language=javascript src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language=javascript src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script type="text/javascript" >
        function forView(form1,id,right){
            var sDate = document.all("form1:sDate").value;
            var eDate = document.all("form1:eDate").value;
//            alert(sDate+","+eDate)
            windowOpen("/pages/wage/clear/ClearAnnuity1.jsp?Id="+id+"&sDate="+sDate+"&eDate="+eDate, '', '', '500', '200', 'yes', '250', '250', 'yes') ;
            windowOpen("/pages/wage/clear/ClearAnnuity2.jsp?Id="+id+"&sDate="+sDate+"&eDate="+eDate, '', '', '500', '200', 'yes', '260', '260', 'yes') ;
            //document.all('form1:clear').click();
        }
    </script>

</head>

<body>
<h:inputHidden value="#{wage_salaryClearBB.pageInit}"/>
<h:panelGrid width="98%" align="center"  columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                cellspacing="0">
    <h:outputText value="   薪资清算"/>
</h:panelGrid>
<h:form id="form1">
    <h:panelGrid columns="1" width="95%" align="center">
        <h:outputText value="发薪单位：#{wage_salaryClearBB.unitName}"/>
        <%
        //<h:multlink value="4" paneLable="代发工资,代缴社会保险,代发住房补贴,代缴企业年金"
       //                paneLink="AgentWageClear.jsf?flag=1,AgentInsuranceClear.jsf?flag=1,AgentHouseAllowanceClear.jsf?flag=1,AgentAnnuityClear.jsf?flag=1"
        //               align="left" width="100%"/>
                       %>
        <h:panelGrid columns="7" cellspacing="2">
            <h:outputText value="开始时间 "/>
            <h:inputText id="sDate" size="10"  alt="开始时间|0|d" value="#{wage_salaryClearBB.startDate}"/>
            <h:commandButton type="button" styleClass="button_date"
                             onclick="PopUpCalendarDialog('form1:sDate')"/>

            <h:outputText value="结束时间 "/>
            <h:inputText id="eDate" size="10" alt="结束时间|0|d"  value="#{wage_salaryClearBB.endDate}"/>
            <h:commandButton type="button" styleClass="button_date"
                             onclick="PopUpCalendarDialog('form1:eDate')"/>
            <h:commandButton value="查询" onclick="return forsubmit(form1);" action="#{wage_salaryClearBB.queryAgentAnnuityPerson}"
                             styleClass="button01"/>
        </h:panelGrid>
    </h:panelGrid>
    <f:verbatim>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="false"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="true"/>
            <jsp:param name="editName" value="薪资清算"/>
            <jsp:param name="editFuncName" value="forView"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isForward" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
        </jsp:include>
    </f:verbatim>
</h:form>
</body>
</html>
