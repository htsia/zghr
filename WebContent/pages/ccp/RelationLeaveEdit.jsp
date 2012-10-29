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
    <f:verbatim>
        <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
        <script type="text/javascript">


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
                }
                if (document.all("form1:personId").value != "") {
                    pageCodeExchange(document.forms(0));
                    return true;
                } else {
                    pageCodeExchange(document.forms(0));
                    return false;
                }
            }

            function forSave() {
                document.all("form1:personInfo").value = "2";
                return forsubmit(document.forms(0));
            }

            function forPrint() {
                var intro = document.all("form1:introduceId").value;
                var flow = document.all("form1:flowId").value;
                var rel = document.all("form1:relationId").value;
                //wangbing modify 20070124
                var sel = document.all("seldoc").checked;
//                windowOpen("/pages/ccp/PartyPrint.jsf?intro=" + intro + "&flow=" + flow + "&rel=" + rel, "", "status=no,toolbar=no,menubar=yes,location=no", "900", "600", "no");
                windowOpen("/pages/ccp/PartyPrint.jsf?intro=" + intro + "&flow=" + flow + "&rel=" + rel + "&seldoc="+sel, "", "status=no,toolbar=no,menubar=yes,location=no", "800", "850", "yes");
                //wangbing modify end
            }

            function forchk() {
                return true;
            }
        </script>
    </f:verbatim>
</head>

<body>
<h:form id="form1">
<h:inputHidden id="personInfo" value="#{ccp_transEditBB.personInfo}"/>
<h:inputHidden id="relationId" value="#{ccp_transEditBB.partyRelation.relationId}"/>
<h:inputHidden id="stepId" value="#{ccp_transEditBB.partyRelation.stepId}"/>
<h:inputHidden id="flowId" value="#{ccp_transEditBB.partyRelation.flowId}"/>
<h:inputHidden id="qryId" value="#{ccp_transEditBB.partyRelation.qryId}"/>
<h:inputHidden id="introduceId" value="#{ccp_transEditBB.partyRelation.introduceId}"/>
<h:inputHidden id="introduceDocId" value="#{ccp_transEditBB.partyRelation.introduceDocId}"/>
<h:inputHidden id="transcateDate" value="#{ccp_transEditBB.partyRelation.transcateDate}"/>
<h:inputHidden id="transcatePerson" value="#{ccp_transEditBB.partyRelation.transcatePerson}"/>
<h:inputHidden id="transcateStatus" value="#{ccp_transEditBB.partyRelation.transcateStatus}"/>
<h:inputHidden id="personId" value="#{ccp_transEditBB.partyRelation.personId}"/>
<h:inputHidden id="transcateType" value="0"/>
<!-- wangbing add 20070114 -->
<h:inputHidden id="personAge" value="#{ccp_transEditBB.partyRelation.personAge}"/>
<h:inputHidden id="personNation" value="#{ccp_transEditBB.partyRelation.personNation}"/>
<!-- wangbing add end -->
<h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#FFFFFF" styleClass="td_title">
    <h:outputText value=" "/>
    <h:outputText value="停止党籍-> 新增停止党籍人员"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center"
                columns="4"  columnClasses="td_form01,td_form02,td_form01,td_form02">
    <h:outputText value="姓名"  styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="personName" value="#{ccp_transEditBB.partyRelation.personName}" alt="姓名|0|s" size="20"
                     readonly="true"/>
        <h:commandButton styleClass="button_select" value=" " onclick="forPerson()" disabled="#{ccp_transEditBB.flag}"/>
    </h:panelGroup>
    <h:outputText value="性别"  />
    <h:inputText id="personGender" value="#{ccp_transEditBB.partyRelation.personGender}" code="" dict="yes"
                 dict_num="0100" readonly="true"/>

    <h:outputText value="出生日期"/>
    <h:inputText id="personBirthday" value="#{ccp_transEditBB.partyRelation.personBirthday}" readonly="true"/>
    <h:outputText value="政治面貌"/>
    <h:inputText id="partyFigure" value="#{ccp_transEditBB.partyRelation.partyFigure}" code="" dict="yes"
                 dict_num="0120" readonly="true"/>

    <!-- wangbing add 20070114 -->
    <h:outputText value="身份证号" styleClass="td_form_required"/>
    <h:inputText id="personalCode" value="#{ccp_transEditBB.partyRelation.personalCode}" alt="身份证号|0|s" size="20"
                 />
    <h:outputText value="联系电话"  styleClass="td_form_required"/>
    <h:inputText id="personTel" value="#{ccp_transEditBB.partyRelation.personTel}" alt="联系电话|0|s" size="20"/>
    <!-- wangbing add end -->

    <h:outputText value="所属党组织"/>
    <h:inputText id="partyUnit" value="#{ccp_transEditBB.partyRelation.partyUnit}" code="" dict="yes" dict_num="PA"
                 readonly="true"/>
    <h:outputText value="停止日期"  styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="leaveDate" value="#{ccp_transEditBB.partyRelation.leaveDate}" alt="停止日期|0|s" size="20"/>
        <h:commandButton styleClass="button_date" value=" " onclick="PopUpCalendarDialog('form1:leaveDate');return false;"/>
    </h:panelGroup>
    
    <h:outputText value="转离类型" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="leaveType" code="" dict="yes" dict_num="0310"
                     value="#{ccp_transEditBB.partyRelation.leaveType}" alt="转离类型|0|s" size="20"  readonly="true"/>
        <h:commandButton styleClass="button_select" value=" " onclick="PopUpCodeDlgOneControl('form1:leaveType');return false;"/>
    </h:panelGroup>
   
</h:panelGrid>
 <f:verbatim><br></f:verbatim>
<h:panelGrid cellpadding="2" cellspacing="2" align="center" columns="3">
    <h:commandButton styleClass="button01" value="保存" onclick="return forSave()"
                     action="#{ccp_transEditBB.savePartyRelation}"/>
    <h:commandButton id="back" styleClass="button01" value="返回" action="list"/>
</h:panelGrid>
</h:form>
<f:verbatim>
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</f:verbatim>
</body>
</html>