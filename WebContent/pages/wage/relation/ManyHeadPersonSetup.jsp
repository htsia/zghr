<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<html>
<head>
    <title>��ͷ������Ա��Ȩ</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language=javascript src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script language="javascript">
        function checkIds(persId) {
            if (checkMutilSelect(persId)) {
                if (confirm('ȷ��Ҫ������ѡ��Ա����Ȩ��'))
                {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("��ѡ����Ա��")
                return false;
            }
        }
    </script>
</head>

<body>
<x:saveState value="#{wage_manyHeadPutoutBB}"/>
<h:inputHidden value="#{wage_manyHeadPutoutBB.pageInit}"/>
<h:panelGrid width="98%" align="center" columnClasses="td_title" bgcolor="#FFFFFF" cellpadding="0"
                cellspacing="0">
    <h:outputText value="   ��ͷ���Ź�ϵ����"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid columns="1" width="95%" align="center">
    <h:outputText value="��н��λ��#{wage_manyHeadPutoutBB.unitName}"/>
    <%
   // <h:multlink value="1" paneLable="��ͷ���Ź�ϵ��Ȩ,�鿴��ͷ������Ա"
                //   paneLink="ManyHeadPersonSetup.jsf,ViewManyHeadPerson.jsf"
                 //  align="left" width="50%"/>
                   %>
</h:panelGrid>

<h:form id="form1">
    <h:panelGrid width="95%" align="center" >
        <%--<h:panelGrid align="left" columns="9" cellspacing="2">--%>
            <%--<h:outputText value="����"/>--%>
            <%--<h:inputText id="name" size="10" value="#{wage_manyHeadPutoutBB.personName}"/>--%>
            <%--<h:outputText value="��ʼʱ��"/>--%>
            <%--<h:inputText id="sDate" size="10" value="#{wage_manyHeadPutoutBB.startDate}"/>--%>
            <%--<h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:sDate')"/>--%>
            <%--<h:outputText value="����ʱ��"/>--%>
            <%--<h:inputText id="eDate" size="10" value="#{wage_manyHeadPutoutBB.endDate}"/>--%>
            <%--<h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:eDate')"/>--%>
            <%--<h:commandButton id="find" styleClass="button01" value="��ѯ"--%>
                             <%--action="#{wage_manyHeadPutoutBB.findOutPerson}"/>--%>
        <%--</h:panelGrid>--%>
        <h:panelGrid align="right" cellpadding="2" cellspacing="0" columns="3">
            <h:commandButton type="button" styleClass="button01" value="������Ա"
                             onclick="location='AddManyHeadPerson.jsf'"/>
            <h:commandButton styleClass="button01" value="������Ȩ"
                             onclick="if(checkIds(document.form1.awardId)){return true;}else return false;"
                             action="#{wage_manyHeadPutoutBB.deletePerson}"/>
            <h:commandButton styleClass="button01" value="������Excel"
                             action="#{wage_manyHeadPutoutBB.exportOutToExcel}"/>
        </h:panelGrid>
        <h:dataTable width="100%"  align="center"
                     styleClass="table03"  headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     value="#{wage_manyHeadPutoutBB.manyHeadPutoutVos}" var="list" >
            <h:column>
                <f:facet name="header">
                    <f:verbatim escape="false">
                        <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.awardId)"/>
                    </f:verbatim>
                </f:facet>
                <f:verbatim escape="false"><input type="checkbox" </f:verbatim>
                <h:outputText value="#{list.flag}"/><f:verbatim> name="awardId" value="</f:verbatim>
                <h:outputText value="#{list.awardId}"/><f:verbatim>"></f:verbatim>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="Ա�����" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="����" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="������λ" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.workPlace}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="���ڲ���" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>
            <h:column>
                <f:facet name="header"><h:outputText value="����Ȩ��λ" styleClass="td03"/></f:facet>
                <h:outputText value="#{list.destDeptName}"/>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
</body>
</html>