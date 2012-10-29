<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function queryConstChange(){
           window.showModalDialog("/wage/payoff/showConstChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:460px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        }

        function showCalcTime(){
            window.showModalDialog("/wage/payoff/showCalcTime.jsf?setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&dateId="+document.all("form1:dateId").value, null, "dialogWidth:560px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

        function exportDept(){
           window.showModalDialog("/wage/set/exportDeptInfo.jsf?setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&dateId="+document.all("form1:dateId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
           return false;
        }

        function doSetConst(){
            var url="/wage/set/SetConst.jsf?setId=WAGE_DATACHECK&setName=���ݼ�����";
            //alert(url);
            window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

        function doCheckData(){
            var setid=form1.all("form1:setId").value;
            var dateId=form1.all("form1:dateId").value;
            window.showModalDialog("/wage/payoff/doCheckData.jsf?dateId="+dateId+"&setID="+setid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowOrgDiff(){
            var url="/wage/payoff/ShowOrgDiff.jsf?dateId="+form1.all("form1:dateId").value+"&unitId="+form1.all("form1:unitId").value;
            window.open(url,'','scrollbar=yes,toolbar=0,height=500,width='+screen.width*0.9+',top=40,left='+screen.width*0.05);
            return false;
        }

        function changeStatus(){
            if (form1.all("form1:status").value=="0"){
                form1.all("form1:idOK").value = "н������δͨ��";
                form1.all("form1:message").value="н������δͨ��";
            }
            else{
                form1.all("form1:idOK").value = "н������ͨ��";
                form1.all("form1:message").value="н������ͨ��";
            }
        }

        function doDetailPopup() {
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/AuditViewDetail.jsf?dateId=" + dateId, "Ա�����ʷ�����ϸ", "height="+screen.height*0.85+",width="+screen.width*0.95+",left="+screen.width*0.0025+",top="+screen.height*0.05+",toolbar=no,menubar=no,scrollbars=auto,resizable=yes");
            popup.focus();
        }
        function doCheckInsurace(){
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/checkInsuraceRate.jsf?dateId=" + dateId, "Ա�����ջ���", "height="+screen.height*0.75+",width="+screen.width*0.9+",left="+screen.width*0.05+",top="+screen.height*0.1+",toolbar=no,menubar=no,scrollbars=auto,resizable=yes");
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
        function OpenNowRpt(){
            if (document.all("form1:nowStaticID").value=="-1"){
                alert("����ѡ������ʽ��");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:nowStaticID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                     +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:nowStaticID").value;
            window.open(url);
            return false;
        }

        function ViewItemSet(setid){
            var url="/wage/set/SetItemListView.jsf?setId="+setid;
            window.open(url);
            return false;
        }
        function showDeptdiff(){
            var url="/wage/payoff/ShowDeptDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height='+screen.height*0.8+',width='+screen.width*0.8+',top='+screen.height*0.1+',left='+screen.width*0.1+',scrollbars=auto');
            return false;
        }
        function doShowDiff(){
            var url="/wage/payoff/ShowDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height='+screen.height*0.8+',width='+screen.width*0.8+',top='+screen.height*0.1+',left='+screen.width*0.1+',scrollbars=auto');
            return false;
        }
    </script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
<c:verbatim>
<table height=98% width=100%  cellSpacing=0>
    <tr>
        <td height=2 class=td_title colspan=2>
</c:verbatim>
            <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="н����� -> н������:"/>
                <h:outputText value="#{wage_flowBB.setName}"/>
            </h:panelGroup>

            <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
            <h:inputHidden id="unitId" value="#{wage_flowBB.unitId}"/>
            <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
<c:verbatim>
         </td>
    </tr>

    <tr>
        <td height=2 width=80%>
</c:verbatim>
        <h:panelGrid columns="2"  align="center" width="80%" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="�ϴ���������"/>
            <h:panelGroup>
                 <h:selectOneMenu id="ReportID" style="width:250px">
                    <c:selectItems value="#{wage_flowBB.reportList}"/>
                </h:selectOneMenu>
                 <h:commandButton value="��ʾ������" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                 <h:commandButton value="��ʾ����ʱ��" type="button" styleClass="button01" onclick="return showCalcTime();"></h:commandButton>
            </h:panelGroup>

            <h:outputText value="�������"/>
            <h:outputText escape="false"  value="����ˣ�#{wage_flowBB.date.checkContent} <br><div align=right> #{wage_flowBB.checkerName}</div>"/>

            <h:outputText value="�������"/>
            <h:selectOneMenu id="status" value="#{wage_flowBB.date.approveStatus}" onchange="changeStatus();">
                <c:selectItem itemValue="1" itemLabel="ͬ��"/>
                <c:selectItem itemValue="0" itemLabel="��ͬ��"/>
            </h:selectOneMenu>

            <h:outputText value="ԭ��"/>
            <h:inputTextarea value="#{wage_flowBB.date.approveContent}" rows="3" cols="80"/>

            <h:outputText value="֪ͨ"/>
            <h:panelGroup>
                <h:selectBooleanCheckbox value="#{wage_flowBB.sendSM}" ></h:selectBooleanCheckbox>
                <h:outputText value="�Զ���֪ͨ"></h:outputText>
                <h:commandButton value="�ݴ���" action="#{wage_flowBB.submitApprove}" styleClass="button01">
                    <x:updateActionListener property="#{wage_flowBB.act}" value="save"/>
                </h:commandButton>
                <h:commandButton id="idOK" value="ȷ��" action="#{wage_flowBB.submitApprove}" styleClass="button01" onclick="return confirm('��ȷ���ύ?')">
                    <x:updateActionListener property="#{wage_flowBB.act}" value="submit"/>
                </h:commandButton>
                <h:commandButton value="ȡ������" action="#{wage_flowBB.list}" styleClass="button01">
                    <x:updateActionListener property="#{wage_flowBB.act}" value="2"/>
                </h:commandButton>

                <c:verbatim>
                <br>
                </c:verbatim>
                <h:inputTextarea id="message" value="#{wage_flowBB.message}" rows="3" cols="80"/>
            </h:panelGroup>
           </h:panelGrid>
<c:verbatim>
        </td>

        <td>
</c:verbatim>
            <h:commandButton type="button" styleClass="button01" value="��ѯ����" onclick="queryConstChange();"></h:commandButton>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="�鿴�����ܶ���Ϣ" type="button" onclick="return exportDept();" styleClass="button01"/>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="�鿴��Ŀ���ü��㷨" type="button" onclick="return ViewItemSet('#{wage_flowBB.date.setId}');" styleClass="button01"/>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="�鿴��ϸ��Ϣ" type="button" onclick="doDetailPopup()" styleClass="button01"/>
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="�˶Ա��ջ���" type="button" onclick="doCheckInsurace()" styleClass="button01"/>
<c:verbatim>
        </td>
    </tr>

    <tr><td height=2 align=left  colspan=2>
         <table>
            <tr>
            <td>
</c:verbatim>
                <h:outputText escape="false" value="&nbsp;&nbsp;������Ϣ��"></h:outputText>
                <h:selectOneMenu value="#{wage_flowBB.itemType}" >
                    <c:selectItems value="#{wage_flowBB.itemTypeList}"></c:selectItems>
                </h:selectOneMenu>
<c:verbatim>
            </td>
            <td>
</c:verbatim>
                <h:commandButton value="����" styleClass="button01"  action="#{wage_flowBB.findDate}"></h:commandButton>
<c:verbatim>
            </td>

            <td>
</c:verbatim>
                    <h:commandButton value="�����Ա�" type="button" onclick="return doShowOrgDiff();" styleClass="button01"/>
                    <h:commandButton value="���ŶԱ�" type="button" onclick="return showDeptdiff();" styleClass="button01"/>
                    <h:commandButton value="��Ա�Ա�" type="button" onclick="return doShowDiff();" styleClass="button01"/>
<c:verbatim>
            </td>

            <td>
</c:verbatim>
                <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;"></h:outputText>
                <h:commandButton value="������" type="button" onclick="doSetConst()" styleClass="button01"/>
                <h:commandButton value="���ݼ��" type="button" onclick="doCheckData()" styleClass="button01"/>
<c:verbatim>
             </td>

             <td>
</c:verbatim>
                 <h:commandButton value="�鿴�䶯��" type="button" onclick="doNotePopup()" rendered="false" styleClass="button01"/>

                 <h:selectOneMenu id="nowStaticID" style="width:250px">
                    <c:selectItems value="#{wage_flowBB.nowReportList}"/>
                </h:selectOneMenu>
                 <h:commandButton value="��ʾ" styleClass="button01" onclick="return OpenNowRpt();"></h:commandButton>
<c:verbatim>
             </td>

             </tr>
         </table>
     </td></tr>

    <tr><td colspan=2>
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
