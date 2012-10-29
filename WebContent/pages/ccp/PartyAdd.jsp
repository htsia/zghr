<%@ page import="com.hr319wg.util.SequenceGenerator" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <f:verbatim>
        <script type="text/javascript" language="javascript">
            function forClear() {
                form1.all('form1:D001025').value = "";
                form1.all('form1:D001002').value = "";
                form1.all('form1:D001001').value = "";
                form1.all('form1:D001020').value = "";
                form1.all('form1:D001030').value = "";
                form1.all('form1:D001005').value = "";
                form1.all('form1:D001010').value = "";
            }

            function forOrgType(){
                document.all("form1:saveFlag").value = "1";
                PopUpMutilOrgOneControl('form1:D001020','1');
                return pageCodeExchange(document.forms(0));
            }

            function forSave() {
                document.all("form1:saveFlag").value = "2";
                return forsubmit(document.forms(0));
            }
        </script>
    </f:verbatim>

<h:form id="form1">
    <h:inputHidden id="saveFlag" value="#{ccp_PartyAddBB.saveFlag}"/>
    <h:inputHidden value="#{ccp_PartyAddBB.orgType}"/>
    <h:inputHidden id="partyId" value="#{ccp_PartyAddBB.partybo.partyId}"/>
    <h:inputHidden id="D001025" value="#{ccp_PartyAddBB.partybo.partyCode}"/>
    <c:verbatim>
    <input type="hidden" name="chkflag" value="1">
    </c:verbatim>
    <h:panelGrid width="100%" columns="1" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" styleClass="td_title">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="党组织新增"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="100%" columns="1">
        <h:panelGrid cellpadding="2" cellspacing="2" align="right" columns="2">
            <h:commandButton value="保存" onclick="return forSave()" styleClass="button01" action="#{ccp_PartyAddBB.createParty}"/>
            <h:commandButton value="取消" onclick="javascript:forClear()" styleClass="button01"/>
        </h:panelGrid>

        <h:panelGrid width="95%" align="center" border="0" cellpadding="0" cellspacing="0" styleClass="table03"
                         columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
            <h:outputText value="党组织名称" styleClass="td_form_required"/>
            <h:inputText styleClass="input" id="D001001" value="#{ccp_PartyAddBB.partybo.partyName}" alt="党组织名称|0|s|140||"/>
            <h:outputText value="上级党组织" styleClass="td_form_required"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="D001002" code="" dict="yes" dict_num="PA"
                             value="#{ccp_PartyAddBB.partybo.superId}" alt="上级党组织|0|s|50||" readonly="true"/>
                <h:commandButton type="button" styleClass="button_select"
                                 onclick="fPopUpPartyDlg('form1:D001002','','','1')"/>
            </h:panelGroup>

            <h:outputText value="组成机构" styleClass="td_form_required"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="D001020" code="" dict="yes" dict_num="OU"
                             value="#{ccp_PartyAddBB.partybo.partyMember}" alt="组成机构|0|s|500||" readonly="true"/>
                <h:commandButton value=" " styleClass="button_select" onclick="return forOrgType()"/>
            </h:panelGroup>
            <h:outputText value="组成机构类别" styleClass="td_form_required"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="D001030" code="" dict="yes" dict_num="0891"
                             value="#{ccp_PartyAddBB.partybo.memberType}" alt="组成机构类别|0|s|50||" readonly="true"/>
                <%--<h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:D001030')"/>--%>
            </h:panelGroup>

            <h:outputText value="党组织类别" styleClass="td_form_required"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="D001005" code="" dict="yes" dict_num="0870"
                             value="#{ccp_PartyAddBB.partybo.partyType}" alt="党组织类别|0|s|50||" readonly="true"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:D001005')"/>
            </h:panelGroup>
            <h:outputText value="组织设立时间" styleClass="td_form_required"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="D001010" value="#{ccp_PartyAddBB.partybo.partyEstablishDate}"
                             alt="组织设立时间|0|s|50||" readonly="true"/>
                <h:commandButton type="button" styleClass="button_date"
                                 onclick="PopUpCalendarDlg_OnlyMonth('form1:D001010')"/>
            </h:panelGroup>
        </h:panelGrid>
    
    </h:panelGrid>
</h:form>
<f:verbatim>
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</f:verbatim>
