<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doShowOrgDiff(){
            var url="/wage/payoff/ShowOrgDiff.jsf?dateId="+form1.all("form1:dateId").value+"&unitId="+form1.all("form1:unitId").value;
            window.open(url,'','scrollbar=yes,toolbar=0,height=500,width='+screen.width*0.9+',top=40,left='+screen.width*0.05);
            return false;
        }

        function showDeptdiff(){
            var url="/wage/payoff/ShowDeptDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40,scrollbars=yes');
            return false;
        }
        function doShowDiff(){
            var url="/wage/payoff/ShowDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40,scrollbars=yes');
            return false;
        }

        function changeStatus(){
            if (form1.all("form1:status").value=="0"){
                form1.all("form1:idOK").value = "�������󣬷�������";
            }
            else{
                form1.all("form1:idOK").value = "ȷ�������ύ����";
            }
        }
        function doDetailPopup() {
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/AuditViewDetail.jsf?dateId=" + dateId, "Ա�����ʷ�����ϸ", "height="+screen.height*0.75+",width="+screen.width*0.9+",left="+screen.width*0.05+",top="+screen.height*0.1+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }

        function doNotePopup() {
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/WageNoteView.jsf?dateId=" + dateId, "", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("����ѡ������ʽ��");
                return false;
            }
            var url="/pages/report/FlowReportShow.jsp?Title="+document.all("form1:ReportID").value;
            window.open(url);
            return false;
        }
    </script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
    <h:inputHidden id="unitId" value="#{wage_flowBB.unitId}"/>
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <c:verbatim>
    <table height=98% width=100% >
    <tr><td height=2>
</c:verbatim>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
           <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="н����� -> н�ʸ���"/>
           </h:panelGroup>
        </h:panelGrid>
<c:verbatim>
     </td></tr>

    <tr><td height=2>
</c:verbatim>
        <h:outputText value="��н��λ��#{wage_flowBB.unitName}"/>
        <h:outputText value="���ף�#{wage_flowBB.setName}"/>
<c:verbatim>
    </td></tr>

    <tr><td height=2>
 </c:verbatim>
        <h:panelGrid columns="2"  align="center" width="60%" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="�鿴"/>
            <h:panelGroup>
                <h:commandButton value="�鿴������ϸ" type="button" onclick="doDetailPopup()" styleClass="button01"/>
                <h:outputText value=" "/>
                <h:commandButton value="�鿴�䶯��" type="button" onclick="doNotePopup()" styleClass="button01"/>
                <h:selectOneMenu id="ReportID" style="width:150">
                <c:selectItems value="#{wage_flowBB.reportList}"/>
                </h:selectOneMenu>
                 <h:commandButton value="��ʾ���̱�" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
            </h:panelGroup>

            <h:outputText value="�������"/>
            <h:selectOneMenu id="status" value="#{wage_flowBB.date.checkStatus}" onchange="changeStatus();">
                <c:selectItem itemValue="1" itemLabel="ͨ��"/>
                <c:selectItem itemValue="0" itemLabel="��ͨ��"/>
            </h:selectOneMenu>

            <h:outputText value="ԭ��"/>
            <h:inputTextarea value="#{wage_flowBB.date.checkContent}" rows="3" cols="50"/>
        </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td height=2>
 </c:verbatim>
        <h:panelGrid columns="3" cellspacing="2" align="center">
            <h:commandButton value="�ݴ���" action="#{wage_flowBB.submitCheck}" styleClass="button01">
                <x:updateActionListener property="#{wage_flowBB.act}" value="save"/>
            </h:commandButton>
            <h:commandButton id="idOK" value="ȷ�������ύ����" action="#{wage_flowBB.submitCheck}" styleClass="button01" onclick="return confirm('��ȷ���ύ?')">
                <x:updateActionListener property="#{wage_flowBB.act}" value="submit"/>
            </h:commandButton>
            <h:commandButton value="ȡ������" action="#{wage_flowBB.list}" styleClass="button01">
                <x:updateActionListener property="#{wage_flowBB.act}" value="1"/>
            </h:commandButton>
        </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td height=2>
</c:verbatim>
        <h:outputText value="н�귢����ʷ��Ϣ��"></h:outputText>
        <h:outputText escape="false" value="&nbsp;&nbsp;������Ϣ��"></h:outputText>
        <h:selectOneMenu value="#{wage_flowBB.itemType}" >
            <c:selectItems value="#{wage_flowBB.itemTypeList}"></c:selectItems>
        </h:selectOneMenu>
        <h:commandButton value="����" styleClass="button01"  action="#{wage_flowBB.findDate}"></h:commandButton>
        <h:commandButton value="�����Ա�" type="button" onclick="return doShowOrgDiff();" styleClass="button01"/>
        <h:commandButton value="���ŶԱ�" type="button" onclick="return showDeptdiff();" styleClass="button01"/>
        <h:commandButton value="��Ա�Ա�" type="button" onclick="return doShowDiff();" styleClass="button01"/>
<c:verbatim>
    </td></tr>
    
   <tr><td>
    <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
    </jsp:include>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
