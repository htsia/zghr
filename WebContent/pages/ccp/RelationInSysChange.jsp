<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

%>
<html>
<head>
    <title>����������</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <f:verbatim>
        <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
        <script type="text/javascript">
        function forPrint() {
            var intro = document.all("form1:introduceId").value;
            var flow = document.all("form1:flowId").value;
            var rel = document.all("form1:relationId").value;
            //wangbing modify 20070124
            var sel = document.all("seldoc").checked;
//            windowOpen("/pages/ccp/PartyPrint.jsf?intro=" + intro + "&flow=" + flow + "&rel=" + rel, "", "status=no,toolbar=no,menubar=yes,location=no", "900", "600", "no");
            windowOpen("/pages/ccp/PartyPrint.jsf?intro=" + intro + "&flow=" + flow + "&rel=" + rel + "&seldoc="+sel, "", "status=no,toolbar=no,menubar=yes,location=no", "800", "850", "yes");
            //wangbing modify end
        }
        </script>
    </f:verbatim>
    <script type="text/javascript">
        function forSave() {
            //            document.getElementById("form1:personInfo").value = "2";
            return forsubmit(document.forms(0));
        }
    </script>
</head>

<body>
<x:saveState value="#{ccp_transEditBB.partyRelation.flowId}"/>
<x:saveState value="#{ccp_transListBB}"/>
<h:form id="form1">
<%--<h:inputHidden id="personInfo" value="#{ccp_transEditBB.personInfo}"/>--%>
<h:inputHidden id="relationId" value="#{ccp_transEditBB.partyRelation.relationId}"/>
<h:inputHidden id="stepId" value="#{ccp_transEditBB.partyRelation.stepId}"/>
<h:inputHidden id="flowId" value="#{ccp_transEditBB.partyRelation.flowId}"/>
<h:inputHidden id="introduceId" value="#{ccp_transEditBB.partyRelation.introduceId}"/>
<h:inputHidden id="introduceDocId" value="#{ccp_transEditBB.partyRelation.introduceDocId}"/>
<h:inputHidden id="transcateDate" value="#{ccp_transEditBB.partyRelation.transcateDate}"/>
<h:inputHidden id="transcatePerson" value="#{ccp_transEditBB.partyRelation.transcatePerson}"/>
<h:inputHidden id="transcateStatus" value="#{ccp_transEditBB.partyRelation.transcateStatus}"/>
<h:inputHidden id="personId" value="#{ccp_transEditBB.partyRelation.personId}"/>
<h:inputHidden id="transcateType" value="2"/>
<!-- wangbing add 20070122 -->
<h:inputHidden id="personAge" value="#{ccp_transEditBB.partyRelation.personAge}"/>
<h:inputHidden id="personNation" value="#{ccp_transEditBB.partyRelation.personNation}"/>
<!-- wangbing add end -->
<h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#FFFFFF" styleClass="td_title">
    <h:outputText value=" "/>
    <h:outputText value=" ���������� ->ֱ�ӻ���"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
 
<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4"
                 columnClasses="td_form01,td_form02,td_form01,td_form02">
    <h:outputText value="����" styleClass="td_form_required"/>
    <h:inputText id="personName" value="#{ccp_transEditBB.partyRelation.personName}" alt="����|0|s" size="20" readonly="#{ccp_transEditBB.flag}"/>
    <h:outputText value="�Ա�" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="personGender" value="#{ccp_transEditBB.partyRelation.personGender}" code="" dict="yes" dict_num="0100" readonly="true"/>
        <h:commandButton styleClass="button_select" value=" " onclick="PopUpCodeDlgOneControl('form1:personGender');return false;"/>
    </h:panelGroup>

    <h:outputText value="��������"/>
    <h:panelGroup>
        <h:inputText id="personBirthday" value="#{ccp_transEditBB.partyRelation.personBirthday}" size="20"/>
        <h:commandButton styleClass="button_date" value=" " onclick="PopUpCalendarDialog('form1:personBirthday');return false;"/>
    </h:panelGroup>
    <h:outputText value="������ò" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="partyFigure" value="#{ccp_transEditBB.partyRelation.partyFigure}" alt="������ò|0|s" code="" dict="yes" dict_num="0120" readonly="true"/>
        <h:commandButton styleClass="button_select" value=" " onclick="PopUpCodeDlgOneControl('form1:partyFigure');return false;"/>
    </h:panelGroup>

    <!-- wangbing add 20070122 -->
    <h:outputText value="���֤��" styleClass="td_form_required"/>
    <h:inputText id="personalCode" value="#{ccp_transEditBB.partyRelation.personalCode}" alt="���֤��|0|s" size="20"/>
    <h:outputText value="��ϵ�绰" styleClass="td_form_required"/>
    <h:inputText id="personTel" value="#{ccp_transEditBB.partyRelation.personTel}" alt="��ϵ�绰|0|s" size="20"/>
    <!-- wangbing add end -->

    <h:outputText value="��������֯" styleClass="td_form_required"/>
    <h:inputText id="partyUnit" value="#{ccp_transEditBB.partyRelation.partyUnit}" alt="��������֯|0|s" size="20"/>
    <%--<h:outputText value="ת�뵳��֯" styleClass="td_form_required"/>--%>
    <%--<h:panelGroup>--%>
        <%--<h:inputText id="partyNewUnit" value="#{ccp_transEditBB.partyRelation.partyNewUnit}" code=""--%>
                     <%--alt="ת�뵳��֯|0|s" dict="yes" dict_num="PA" readonly="true"/>--%>
        <%--<h:commandButton styleClass="button_select" value=" " onclick="fPopUpPartyDlg('form1:partyNewUnit','0','','1');return false;"/>--%>
    <%--</h:panelGroup>--%>

    <%--<h:outputText value="��������"/>--%>
    <%--<h:panelGroup>--%>
        <%--<h:inputText id="comeDate" value="#{ccp_transEditBB.partyRelation.comeDate}" size="20"/>--%>
        <%--<h:commandButton styleClass="button_date" value=" " onclick="PopUpCalendarDialog('form1:comeDate');return false;"/>--%>
    <%--</h:panelGroup>--%>
    <%--<h:outputText value="��������"/>--%>
    <%--<h:panelGroup>--%>
        <%--<h:inputText id="comeType" code="" dict="yes" dict_num="0305" value="#{ccp_transEditBB.partyRelation.comeType}"--%>
                     <%--size="20" readonly="true"/>--%>
        <%--<h:commandButton styleClass="button_select" value=" " onclick="PopUpCodeDlgOneControl('form1:comeType');return false;"/>--%>
    <%--</h:panelGroup>--%>
</h:panelGrid>
    <br>
<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" align="center" columns="1">
    <h:panelGroup>
        <f:verbatim><hr color="#999999" size=1 style="border-width: 1px;border-style: dotted"><br></f:verbatim>
        <h:outputText value="����д����������" />
    </h:panelGroup>
</h:panelGrid>
<f:verbatim><br></f:verbatim>

<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center"
                columns="4"  columnClasses="td_form01,td_form02,td_form01,td_form02">
    <h:outputText value="�����ŷ�����λ" styleClass="td_form_required"/>
    <h:inputText id="sendUnit" value="#{ccp_transEditBB.partyRelation.sendUnit}" alt="�����ŷ�����λ|0|s" size="20" maxlength="100"/>
    <h:outputText value="ת����λ" styleClass="td_form_required"/>
    <h:inputText id="sendByUnit" value="#{ccp_transEditBB.partyRelation.sendByUnit}" alt="ת����λ|0|s" size="20"/>

    <h:outputText value="���ѽ�ֹ�·�" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="feeStopDate" value="#{ccp_transEditBB.partyRelation.feeStopDate}" alt="���ѽ�ֹ�·�|0|s" size="20" readonly="true"/>
        <h:commandButton styleClass="button_date" value="" onclick="PopUpCalendarDlg_OnlyMonth('form1:feeStopDate');return false;"/>
    </h:panelGroup>
    <h:outputText value="��������" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="transTime" value="#{ccp_transEditBB.partyRelation.transTime}" alt="��������|0|i" size="20"/>
        <h:outputText value="��"/>
    </h:panelGroup>
</h:panelGrid>
<f:verbatim><br></f:verbatim>

<!-- wangbing add 20070122 -->
<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" align="center" columns="1">
    <h:panelGroup>
        <f:verbatim><hr color="#999999" size=1 style="border-width: 1px;border-style: dotted"><br></f:verbatim>
        <h:outputText value="����д����֯��Ϣ"/>
    </h:panelGroup>
</h:panelGrid>
<f:verbatim><br></f:verbatim>

<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center"
                columns="4"  columnClasses="td_form01,td_form02,td_form01,td_form02">
    <h:outputText value="ͨѶ��ַ" styleClass="td_form_required"/>
    <h:inputText id="partyAddr" value="#{ccp_transEditBB.partyRelation.partyAddr}" alt="ͨѶ��ַ|0|s" size="20"
                 maxlength="100"/>
    <h:outputText value="��ϵ�绰" styleClass="td_form_required"/>
    <h:inputText id="partyTel" value="#{ccp_transEditBB.partyRelation.partyTel}" alt="��ϵ�绰|0|s" size="20"/>

    <h:outputText value="����" styleClass="td_form_required"/>
    <h:inputText id="partyFax" value="#{ccp_transEditBB.partyRelation.partyFax}" alt="����|0|s" size="20"/>
    <h:outputText value="�ʱ�" styleClass="td_form_required"/>
    <h:inputText id="partyPostalcode" value="#{ccp_transEditBB.partyRelation.partyPostalcode}" alt="�ʱ�|0|i" size="20"/>

    <h:outputText value="��ִ����֯"/>
    <h:inputText id="rebackParty" value="#{ccp_transEditBB.partyRelation.rebackParty}" alt="��ִ����֯|0|s" size="20"/>
    <h:outputText value="��ӡ����ִ"/>
    <f:verbatim><input type="checkbox" name="seldoc" onclick="return true"></f:verbatim>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<!-- wangbing add end -->
<h:panelGrid cellpadding="2" cellspacing="2" align="center" columns="3">
    <h:commandButton id="save" value="����" styleClass="button01" onclick="return forSave();"
                     action="#{ccp_transEditBB.savePartyRelation}"/>
    <h:commandButton type="button" styleClass="button01" value="��ӡ������" onclick="return forPrint()"/>
    <h:commandButton id="back" styleClass="button01" value="����" action="back"/>
</h:panelGrid>

</h:form>
<f:verbatim>
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</f:verbatim>
</body>
</html>