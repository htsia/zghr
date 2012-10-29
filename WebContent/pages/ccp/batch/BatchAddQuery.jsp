<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <f:verbatim>
        <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
        <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
        <script type="text/javascript">
            function forView(form, id, type) {
                windowOpen("/ccp/member/InfoEditIndex.jsf?pk=" + id, "aa", "", "800", "700", "no");
            }
            function forSel() {
                PopUpMutilCodeDlgNoSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
            }

            function forSelPerson() {
                if (checkMutilSelect(document.forms(0).chk)) {
                    showx = event.screenX - event.offsetX - 150;
                    showy = event.screenY - event.offsetY + 18;
                    windowOpen("", "plist", "", "1000", "600", "no");
                    //window.open("", "plist", "dialogWidth:800px; dialogHeight:700px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
                    var obj = document.forms(0).chk ;
                    var ids = "";
                    if (obj.length == null) {
                        ids = obj.value + ",";
                    } else {
                        for (i = 0; i < obj.length; i++) {
                            if (obj[i].checked) {
                                ids += obj[i].value + ",";
                            }
                        }
                    }
                    ids = ids.substr(0, ids.length - 1);
                    document.forms(1).perids.value = ids;
                    document.forms(1).target = "plist";
                    document.forms(1).action = "/ccp/batch/BatchAddEditIndex.jsf";
                    document.forms(1).submit();
                    document.forms(1).target = "_self";
                } else {
                    alert("请选择人员");
                    return false;
                }
            }

            function forAdQry(){
                doAdvanceQuery("A","PARTY","111","Y","","(((A001.A001009='012001')or(A001.A001009='012002'))and(A001.A001753<>'00901')and(A001.A001730<>'00901'))","Y","<%=Constants.DEFAULT_QUERY_PARTYMEMBER%>","Y","1");
            }
        </script>
    </f:verbatim>
</head>

<body>
<h:form id="form1">
    <h:inputHidden id="memberList" value="#{ccp_PartyMemberListBB.memberList}"/>
    <h:inputHidden id="personType" value="#{ccp_PartyMemberListBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{ccp_PartyMemberListBB.personTypeValue}"/>
    <h:inputHidden id="superId" value="#{ccp_PartyMemberListBB.superId}"/>
    <input type="hidden" name="sessionFlag" value="2">
    <h:panelGrid width="100%" align="center" columns="2" border="0" cellspacing="0" cellpadding="0" styleClass="td_page" >
        <h:panelGroup>
            <h:commandButton type="button" styleClass="button01" value="选择人员类别" onclick="forSel()"/>
            <h:outputText value=" "/>
            <h:outputText value=" 姓名："/>
            <h:inputText id="partyName" value="#{ccp_PartyMemberListBB.personName}" size="10"/>
            <h:commandButton value=" 查询 " styleClass="button01" action="#{ccp_PartyMemberListBB.queryPartyMember}"/>
            <h:outputText value=" "/>
            <h:commandButton value="高级查询" styleClass="button01" onclick="return forAdQry()"/>
        </h:panelGroup>
        <h:commandButton type="button" styleClass="button01" value="批量增加" onclick="forSelPerson()"/>
    </h:panelGrid>
    <jsp:include page="../../common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="true"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="isForward" value="true"/>
        <jsp:param name="isRow" value="false"/>
        <jsp:param name="rowFuncName" value="forView"/>
        <jsp:param name="isPage" value="true"/>
    </jsp:include>
</h:form>
<form id="form2">
    <input type="hidden" name="perids"/>
</form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
</body>
</html>