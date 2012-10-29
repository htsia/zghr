<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <f:verbatim>
        <script type="text/javascript">


        function forPerson() {

            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;
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
            function forPrint() {
                var intro = document.all("form1:introduceId").value;
                var flow = document.all("form1:flowId").value;
                var rel = document.all("form1:relationId").value;
                var personId = document.all("form1:personId").value;
                var sel = document.all("seldoc").checked;
               // if(intro != "" &&  flow != "" ){
                     windowOpen("/pages/ccp/PartyPrint.jsf?intro=" + intro + "&flow=" + flow + "&rel=" + rel + "&seldoc="+sel, "", "status=no,toolbar=no,menubar=yes,location=no", "800", "850", "yes");
                // }else{
                 //	alert("请先保存后打印");
                 	return false ;
                // }
            }
        </script>
    </f:verbatim>

<h:form id="form1">
<h:inputHidden id="personInfo" value="#{ccp_transEditBB.personInfo}"/>
<h:inputHidden id="oldIntroId" value="#{ccp_transEditBB.oldIntroId}"/>
<h:inputHidden id="flowId" value="#{ccp_transEditBB.partyRelation.flowId}"/>
<h:inputHidden id="stepId" value="#{ccp_transEditBB.partyRelation.stepId}"/>
<h:inputHidden id="introduceId" value="#{ccp_transEditBB.partyRelation.introduceId}"/>
<h:inputHidden id="introduceDocId" value="#{ccp_transEditBB.partyRelation.introduceDocId}"/>
<h:inputHidden id="relationId" value="#{ccp_transEditBB.partyRelation.relationId}"/>
<h:inputHidden id="personId" value="#{ccp_transEditBB.partyRelation.personId}"/>
<h:inputHidden id="transcateStatus" value="#{ccp_transEditBB.partyRelation.transcateStatus}"/>
<h:inputHidden id="partyUnit" value="#{ccp_transEditBB.partyRelation.partyUnit}"/>
<h:inputHidden id="leaveDate" value="#{ccp_transEditBB.partyRelation.leaveDate}"/>
<h:inputHidden id="leaveType" value="#{ccp_transEditBB.partyRelation.leaveType}"/>
<h:inputHidden id="personAge" value="#{ccp_transEditBB.partyRelation.personAge}"/>
<h:inputHidden id="personNation" value="#{ccp_transEditBB.partyRelation.personNation}"/>
<h:inputHidden id="transcateType" value="3"/>

<h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#FFFFFF" styleClass="td_title">
    <h:outputText value=" "/>
    <h:outputText value="党委内部人员调动 -> 新转入"/>
</h:panelGrid>

<f:verbatim><br></f:verbatim>
<h:panelGrid  width="95%" border="0" align="center" columns = "2" cellpadding="0" cellspacing="0">
    <h:panelGroup>
        <h:outputText value="查询编号："/>
        <h:inputText id="qryId" value="#{ccp_transEditBB.partyRelation.qryId}" size="20"/>
        <h:outputText value=" "/>
        <h:commandButton id="qry" styleClass="button01" value="查询" action="#{ccp_transEditBB.findRelationInfoByqryId}"/>
    </h:panelGroup>
    <h:commandButton styleClass="button01" value="查询历史" action="list"/>
</h:panelGrid>
<f:verbatim><br></f:verbatim>
<h:panelGrid width="95%" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center"
                columns="4"  columnClasses="td_form01,td_form02,td_form01,td_form02">
    <h:outputText value="姓名" styleClass="td_form_required"/>
    <h:panelGroup>
    <h:inputText id="personName" value="#{ccp_transEditBB.partyRelation.personName}" alt="姓名|0|s" size="20" readonly="true"/>
     <h:commandButton styleClass="button_select" value=" " onclick="forPerson()"  />
    </h:panelGroup>
    
    
    
    <h:outputText value="性别"/>
    <h:inputText id="personGender" value="#{ccp_transEditBB.partyRelation.personGender}" code="" dict="yes"
                 dict_num="0100" readonly="true"/>

    <h:outputText value="出生日期"  />
    <h:inputText id="personBirthday" value="#{ccp_transEditBB.partyRelation.personBirthday}" readonly="true"/>
    <h:outputText value="政治面貌"  />
    <h:inputText id="partyFigure" value="#{ccp_transEditBB.partyRelation.partyFigure}" code="" dict="yes"
                 dict_num="0120" readonly="true"/>

    <h:outputText value="身份证号" styleClass="td_form_required"/>
    <h:inputText id="personalCode" value="#{ccp_transEditBB.partyRelation.personalCode}" alt="身份证号|0|s" size="20"
                 readonly="true"/>
    <h:outputText value="联系电话" styleClass="td_form_required"/>
    <h:inputText id="personTel" value="#{ccp_transEditBB.partyRelation.personTel}" alt="联系电话|0|s" size="20"/>

    <h:outputText value="原所在党组织"/> 
       <h:inputText id="partyUnit1" value="#{ccp_transEditBB.partyRelation.partyUnit}" code="" dict="yes" dict_num="PA" 
                  readonly="true"/> 
                 
                 
    <h:outputText value="转入党组织" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="partyNewUnit" value="#{ccp_transEditBB.partyRelation.partyNewUnit}" code="" dict="yes"
                     dict_num="PA" readonly="true"/>
        <h:commandButton styleClass="button_select" value=" " onclick="fPopUpPartyDlg('form1:partyNewUnit','1','','1');return false;"/>
    </h:panelGroup>

    <h:outputText value="转入日期" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="comeDate" value="#{ccp_transEditBB.partyRelation.comeDate}" alt="转入日期|0|s" readonly="true"/>
        <h:commandButton type="button " styleClass="button_date" value=" "
                         onclick="PopUpCalendarDialog('form1:comeDate');return false;"/>
    </h:panelGroup>
    <h:outputText value="转入类型" styleClass="td_form_required"/>
    <h:panelGroup>
        <h:inputText id="comeType" value="#{ccp_transEditBB.partyRelation.comeType}" code="" dict="yes"
                     dict_num="0305" alt="转入类型|0|s" readonly="true"/>
        <h:commandButton type="button" styleClass="button_select" value=" "
                         onclick="PopUpCodeDlgOneControl('form1:comeType');return false;"/>
    </h:panelGroup>
</h:panelGrid>
 
 
<f:verbatim><br></f:verbatim>

  
<h:panelGrid cellpadding="2" cellspacing="2" columns="2" align="center">
    <h:commandButton id="save" styleClass="button01" value="转入"
                     onclick="if (forsubmit(document.forms(0))){}else{return false;}"
                     action="#{ccp_transEditBB.saveReceiveInfo}"/>
</h:panelGrid>
</h:form>
<f:verbatim>
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</f:verbatim>
