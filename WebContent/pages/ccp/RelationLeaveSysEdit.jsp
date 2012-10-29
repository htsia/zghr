<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title>党组织关系转移</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forPrint() {
            var intro = document.all("form1:introduceId").value;
            var flow = document.all("form1:flowId").value;
            var rel = document.all("form1:relationId").value;
            //wangbing modify 20070124
//            windowOpen("/pages/ccp/PartyPrint.jsf?intro=" + intro + "&flow=" + flow + "&rel=" + rel, "", "status=no,toolbar=no,menubar=yes,location=no", "900", "600", "no");
            var sel = document.all("seldoc").checked;
            windowOpen("/pages/ccp/PartyPrint.jsf?intro=" + intro + "&flow=" + flow + "&rel=" + rel + "&seldoc="+sel, "", "status=no,toolbar=no,menubar=yes,location=no", "800", "850", "yes");
            //wangbing modify end
        }
        function forPerson() {
          showx = event.screenX - event.offsetX - 150;
                // + deltaX;
                showy = event.screenY - event.offsetY + 18;
                //windowOpen("/pages/ccp/PartyTreeSelPerson.jsp?obj1=form1:personId&obj2=form1:personName", "aa", "","600","600","no","100","100","yes");
                var retval = window.showModalDialog("/pages/ccp/PartyTreeSelPerson.jsp", "", "dialogWidth:900px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
                if (retval != null) {
                    rs = retval.split(",");
                    document.all("form1:personId").value = rs[0];
                    document.all("form1:personName").value = rs[1];
                    document.all("form1:partyUnit").value = rs[2];
                }
                if (document.all("form1:personId").value != "") {
                    pageCodeExchange(document.forms(0));
                    return true;
                }else {
                    pageCodeExchange(document.forms(0));
                    return false;
                }
        }

        function forSave() {
            document.getElementById("form1:personInfo").value = "2";
            return forsubmit(document.forms(0));
        }
    </script>
</head>

<body>
<x:saveState value="#{ccp_transEditBB.partyRelation.flowId}"/>
<x:saveState value="#{ccp_transListBB}"/>
<h:form id="form1">
<h:inputHidden id="personInfo" value="#{ccp_transEditBB.personInfo}"/>
<h:inputHidden id="relationId" value="#{ccp_transEditBB.partyRelation.relationId}"/>
<h:inputHidden id="stepId" value="#{ccp_transEditBB.partyRelation.stepId}"/>
<h:inputHidden id="flowId" value="#{ccp_transEditBB.partyRelation.flowId}"/>
<h:inputHidden id="introduceId" value="#{ccp_transEditBB.partyRelation.introduceId}"/>
<h:inputHidden id="introduceDocId" value="#{ccp_transEditBB.partyRelation.introduceDocId}"/>
<h:inputHidden id="personBirthday1" value="#{ccp_transEditBB.partyRelation.personBirthday}"/>
<h:inputHidden id="transcateDate" value="#{ccp_transEditBB.partyRelation.transcateDate}"/>
<h:inputHidden id="transcatePerson" value="#{ccp_transEditBB.partyRelation.transcatePerson}"/>
<h:inputHidden id="transcateStatus" value="#{ccp_transEditBB.partyRelation.transcateStatus}"/>
<h:inputHidden id="personId" value="#{ccp_transEditBB.partyRelation.personId}"/>
<h:inputHidden id="partyUnit" value="#{ccp_transEditBB.partyRelation.partyUnit}"/>
<h:inputHidden id="transcateType" value="1"/>
<!-- wangbing add 20070114 -->
<h:inputHidden id="personAge" value="#{ccp_transEditBB.partyRelation.personAge}"/>
<h:inputHidden id="personNation" value="#{ccp_transEditBB.partyRelation.personNation}"/>
<!-- wangbing add end -->
<h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#FFFFFF" styleClass="td_title">
    <h:outputText value=" "/>
    <h:outputText value="转出党组织-> 新增转出"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
 
<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center"
                columns="4"  columnClasses="td_form01,td_form02,td_form01,td_form02">
    <h:outputText value="姓名" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="personName" value="#{ccp_transEditBB.partyRelation.personName}" alt="姓名|0|s" readonly="true"/>
        <h:commandButton styleClass="button_select" value=" " onclick="forPerson()" disabled="#{ccp_transEditBB.flag}"/>
    </h:panelGroup>
    <h:outputText value="性别"/>
    <h:inputText id="personGender" value="#{ccp_transEditBB.partyRelation.personGender}" code="" dict="yes" dict_num="0100" readonly="true"/>

    <h:outputText value="出生日期"/>
    <h:inputText id="personBirthday" value="#{ccp_transEditBB.partyRelation.personBirthday}" readonly="true"/>
    <h:outputText value="政治面貌"/>
    <h:inputText id="partyFigure" value="#{ccp_transEditBB.partyRelation.partyFigure}" code="" dict="yes" dict_num="0120" readonly="true"/>

    <!-- wangbing add 20070114 -->
    <h:outputText value="身份证号" styleClass="td_form_required"/>
    <h:inputText id="personalCode" value="#{ccp_transEditBB.partyRelation.personalCode}" alt="身份证号|0|s" size="20"
                 readonly="true"/>
    <h:outputText value="联系电话" styleClass="td_form_required" />
    <h:inputText id="personTel" value="#{ccp_transEditBB.partyRelation.personTel}" alt="联系电话|0|s" size="20"/>
    <!-- wangbing add end -->

    <h:outputText value="所属党组织"  />
    <h:inputText id="partyUnitName" value="#{ccp_transEditBB.partyRelation.partyUniName}" code="" dict="yes" dict_num="PA" readonly="true"/>
    <h:outputText value="来往党组织" styleClass="td_form_required"/>
    <h:inputText id="partyNewUnit" value="#{ccp_transEditBB.partyRelation.partyNewUnit}" alt="来往党组织|0|s" size="20"/>

    <h:outputText value="转离日期" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="leaveDate" value="#{ccp_transEditBB.partyRelation.leaveDate}" alt="转离日期|0|s" size="20"  readonly="true"/>
        <h:commandButton styleClass="button_date" value=" " onclick="PopUpCalendarDialog('form1:leaveDate');return false;"/>
    </h:panelGroup>
    <h:outputText value="转离类型" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="leaveType" code="" dict="yes" dict_num="0310"
                     value="#{ccp_transEditBB.partyRelation.leaveType}" alt="转离类型|0|s" size="20"  readonly="true"/>
        <h:commandButton styleClass="button_select" value=" " onclick="PopUpCodeDlgOneControl('form1:leaveType');return false;"/>
    </h:panelGroup>
</h:panelGrid>
    <br>
<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" align="center" columns="1">
    <h:panelGroup>
        <f:verbatim><hr color="#999999" size=1 style="border-width: 1px;border-style: dotted"><br></f:verbatim>
        <h:outputText value="请填写介绍信内容" />
    </h:panelGroup>
</h:panelGrid>
<f:verbatim><br></f:verbatim>

<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center"
                columns="4"  columnClasses="td_form01,td_form02,td_form01,td_form02">
    <h:outputText value="介绍信发往单位" styleClass="td_form_required"/>
    <h:inputText id="sendUnit" value="#{ccp_transEditBB.partyRelation.sendUnit}" alt="介绍信发往单位|0|s" size="20" maxlength="100"/>
    <h:outputText value="转出单位" styleClass="td_form_required"/>
    <h:inputText id="sendByUnit" value="#{ccp_transEditBB.partyRelation.sendByUnit}" alt="转出单位|0|s" size="20"/>

    <h:outputText value="党费截止月份" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="feeStopDate" value="#{ccp_transEditBB.partyRelation.feeStopDate}" alt="党费截止月份|0|s" size="20" readonly="true"/>
        <h:commandButton styleClass="button_date" value="" onclick="PopUpCalendarDlg_OnlyMonth('form1:feeStopDate');return false;"/>
    </h:panelGroup>
    <h:outputText value="报到期限" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="transTime" value="#{ccp_transEditBB.partyRelation.transTime}" alt="报到期限|0|i" size="20"/>
        <h:outputText value="天"/>
    </h:panelGroup>
</h:panelGrid>
<f:verbatim><br></f:verbatim>

<!-- wangbing add 20070114 -->
<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" align="center" columns="1">
    <h:panelGroup>
        <f:verbatim><hr color="#999999" size=1 style="border-width: 1px;border-style: dotted"><br></f:verbatim>
        <h:outputText value="请填写党组织信息" />
    </h:panelGroup>
</h:panelGrid>

<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center"
                columns="4"  columnClasses="td_form01,td_form02,td_form01,td_form02">
    <h:outputText value="通讯地址" styleClass="td_form_required"/>
    <h:inputText id="partyAddr" value="#{ccp_transEditBB.partyRelation.partyAddr}" alt="通讯地址|0|s" size="20"
                 maxlength="100"/>
    <h:outputText value="联系电话" styleClass="td_form_required"/>
    <h:inputText id="partyTel" value="#{ccp_transEditBB.partyRelation.partyTel}" alt="联系电话|0|s" size="20"/>

    <h:outputText value="传真" styleClass="td_form_required"/>
    <h:inputText id="partyFax" value="#{ccp_transEditBB.partyRelation.partyFax}" alt="传真|0|s" size="20"/>
    <h:outputText value="邮编" styleClass="td_form_required"/>
    <h:inputText id="partyPostalcode" value="#{ccp_transEditBB.partyRelation.partyPostalcode}" alt="邮编|0|s" size="20"/>

    <h:outputText value="回执党组织" styleClass="td_form_required"/>
    <h:inputText id="rebackParty" value="#{ccp_transEditBB.partyRelation.rebackParty}" alt="回执党组织|0|s" size="20"/>
    <h:outputText value="打印带回执"/>
    <f:verbatim><input type="checkbox" name="seldoc" onclick="return true"></f:verbatim>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<!-- wangbing add end -->
<h:panelGrid cellpadding="2" cellspacing="2" align="center" columns="3">
    <h:commandButton id="save" value="保存" styleClass="button01" onclick="return forSave();"
                     action="#{ccp_transEditBB.savePartyRelationOut}"/>
    <h:commandButton type="button" styleClass="button01" value="打印介绍信" onclick="return forPrint()"/>
    <h:commandButton id="back" styleClass="button01" value="返回" action="#{ccp_transListBB.queryPersonInfo}"/>
</h:panelGrid>
</h:form>
<f:verbatim>
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</f:verbatim>
</body>
</html>