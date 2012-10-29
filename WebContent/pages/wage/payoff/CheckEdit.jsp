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
                form1.all("form1:idOK").value = "计算有误，发回重做";
            }
            else{
                form1.all("form1:idOK").value = "确认无误，提交审批";
            }
        }
        function doDetailPopup() {
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/AuditViewDetail.jsf?dateId=" + dateId, "员工工资发放明细", "height="+screen.height*0.75+",width="+screen.width*0.9+",left="+screen.width*0.05+",top="+screen.height*0.1+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }

        function doNotePopup() {
            var dateId = form1.all("form1:dateId").value;
            popup = window.open("/wage/payoff/WageNoteView.jsf?dateId=" + dateId, "", "height=600,width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=yes");
            popup.focus();
        }
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
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
            <h:outputText value="薪酬管理 -> 薪资复核"/>
           </h:panelGroup>
        </h:panelGrid>
<c:verbatim>
     </td></tr>

    <tr><td height=2>
</c:verbatim>
        <h:outputText value="发薪单位：#{wage_flowBB.unitName}"/>
        <h:outputText value="账套：#{wage_flowBB.setName}"/>
<c:verbatim>
    </td></tr>

    <tr><td height=2>
 </c:verbatim>
        <h:panelGrid columns="2"  align="center" width="60%" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="查看"/>
            <h:panelGroup>
                <h:commandButton value="查看发放明细" type="button" onclick="doDetailPopup()" styleClass="button01"/>
                <h:outputText value=" "/>
                <h:commandButton value="查看变动表" type="button" onclick="doNotePopup()" styleClass="button01"/>
                <h:selectOneMenu id="ReportID" style="width:150">
                <c:selectItems value="#{wage_flowBB.reportList}"/>
                </h:selectOneMenu>
                 <h:commandButton value="显示流程表" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
            </h:panelGroup>

            <h:outputText value="复核意见"/>
            <h:selectOneMenu id="status" value="#{wage_flowBB.date.checkStatus}" onchange="changeStatus();">
                <c:selectItem itemValue="1" itemLabel="通过"/>
                <c:selectItem itemValue="0" itemLabel="不通过"/>
            </h:selectOneMenu>

            <h:outputText value="原因"/>
            <h:inputTextarea value="#{wage_flowBB.date.checkContent}" rows="3" cols="50"/>
        </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td height=2>
 </c:verbatim>
        <h:panelGrid columns="3" cellspacing="2" align="center">
            <h:commandButton value="暂存结果" action="#{wage_flowBB.submitCheck}" styleClass="button01">
                <x:updateActionListener property="#{wage_flowBB.act}" value="save"/>
            </h:commandButton>
            <h:commandButton id="idOK" value="确认无误，提交审批" action="#{wage_flowBB.submitCheck}" styleClass="button01" onclick="return confirm('您确认提交?')">
                <x:updateActionListener property="#{wage_flowBB.act}" value="submit"/>
            </h:commandButton>
            <h:commandButton value="取消返回" action="#{wage_flowBB.list}" styleClass="button01">
                <x:updateActionListener property="#{wage_flowBB.act}" value="1"/>
            </h:commandButton>
        </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td height=2>
</c:verbatim>
        <h:outputText value="薪酬发放历史信息："></h:outputText>
        <h:outputText escape="false" value="&nbsp;&nbsp;汇总信息："></h:outputText>
        <h:selectOneMenu value="#{wage_flowBB.itemType}" >
            <c:selectItems value="#{wage_flowBB.itemTypeList}"></c:selectItems>
        </h:selectOneMenu>
        <h:commandButton value="过滤" styleClass="button01"  action="#{wage_flowBB.findDate}"></h:commandButton>
        <h:commandButton value="机构对比" type="button" onclick="return doShowOrgDiff();" styleClass="button01"/>
        <h:commandButton value="部门对比" type="button" onclick="return showDeptdiff();" styleClass="button01"/>
        <h:commandButton value="人员对比" type="button" onclick="return doShowDiff();" styleClass="button01"/>
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
