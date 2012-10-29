<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function doCheckInsurace(){
        var dateId = form1.all("form1:dateId").value;
        popup = window.open("/wage/payoff/checkInsuraceRate.jsf?dateId=" + dateId, "员工保险基数", "height="+screen.height*0.75+",width="+screen.width*0.9+",left="+screen.width*0.05+",top="+screen.height*0.1+",toolbar=no,menubar=no,scrollbars=auto,resizable=yes");
        popup.focus();
    }

    function queryConstChange(){
       window.showModalDialog("/wage/payoff/showConstChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:460px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    }

    function showCalcTime(){
        window.showModalDialog("/wage/payoff/showCalcTime.jsf?setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&dateId="+document.all("form1:dateId").value, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function exportDept(){
       window.showModalDialog("/wage/set/exportDeptInfo.jsf?setId="+document.all("form1:setId").value+"&unitId="+document.all("form1:unitId").value+"&dateId="+document.all("form1:dateId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
       return false;
    }
    function OpenNowRpt(){
        if (document.all("form1:nowStaticID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:nowStaticID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                 +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:nowStaticID").value;
        if (document.all("form1:paystatus").value=="5"){  //帐套已结束
            url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:nowStaticID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter=DATE_"+document.all("form1:dateId").value
                 +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:nowStaticID").value;
        }
        window.open(url);
        return false;
    }

    function doShowOrgDiff(){
        var url="/wage/payoff/ShowOrgDiff.jsf?dateId="+form1.all("form1:dateId").value+"&unitId="+form1.all("form1:unitId").value;
        window.open(url,'','scrollbar=yes,toolbar=0,height=500,width='+screen.width*0.9+',top=40,left='+screen.width*0.05);
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

    function doCheckData(){
        var setid=form1.all("form1:setId").value;
        var dateId=form1.all("form1:dateId").value;
        window.showModalDialog("/wage/payoff/doCheckData.jsf?dateId="+dateId+"&setID="+setid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }

    function changeStatus(){
        if (form1.all("form1:status").value=="0"){
            form1.all("form1:idOK").value = "审批未通过";
            form1.all("form1:message").value="审批未通过";
        }
        else{
            form1.all("form1:idOK").value = "审批通过";
            form1.all("form1:message").value="审批通过";
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
    function ViewItemSet(setid){
        var url="/wage/set/SetItemListView.jsf?setId="+setid;
        window.open(url);
        return false;
    }
</script>

<x:saveState value="#{wage_flowBB}"/>
<h:form id="form1">
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
    <h:inputHidden id="unitId" value="#{wage_flowBB.unitId}"/>
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <h:inputHidden id="paystatus" value="#{wage_flowBB.date.status}"/>
    <c:verbatim>
    <table height=96% width=98% align="center">
        <tr><td height=8 class="td_title">
    </c:verbatim>
             <h:graphicImage value="/images/tips.gif" />
             <h:outputText value="薪酬管理 -> 薪资信息查看"/>
<c:verbatim>
       </td></tr>

        <tr><td height=8 >
 </c:verbatim>
        <h:panelGrid columns="2"  align="center" width="60%" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="账套："/>
            <h:outputText value="#{wage_flowBB.setName}"/>

            <h:outputText value="审批表"/>
            <h:panelGroup>
                 <h:selectOneMenu id="ReportID" style="width:250px">
                    <c:selectItems value="#{wage_flowBB.reportList}"/>
                </h:selectOneMenu>
                 <h:commandButton value="显示审批表" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                 <h:commandButton value="显示生成时间" type="button" styleClass="button01" onclick="return showCalcTime();"></h:commandButton>
            </h:panelGroup>

            <h:outputText value="复核意见"/>
            <h:outputText escape="false"  value="已审核！#{wage_flowBB.date.checkContent} <br><div align=right> #{wage_flowBB.checkerName}</div>"/>

            <h:outputText value="审批意见"/>
            <h:selectOneMenu id="status" value="#{wage_flowBB.date.approveStatus}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="0" itemLabel="不同意"/>
            </h:selectOneMenu>

            <h:outputText value="原因"/>
            <h:inputTextarea readonly="true" value="#{wage_flowBB.date.approveContent}" rows="3" cols="50"/>
        </h:panelGrid>
<c:verbatim>
        </td></tr>

        <tr><td height=8 align="right">
</c:verbatim>
            <h:commandButton type="button" styleClass="button01" value="查询常量" onclick="queryConstChange();"></h:commandButton>
            <h:commandButton value="查看项目设置及算法" type="button" onclick="return ViewItemSet('#{wage_flowBB.date.setId}');" styleClass="button01"/>
            <h:commandButton value="查看发放明细" type="button" onclick="doDetailPopup()" styleClass="button01"/>
            <h:commandButton value="查看部门总额信息" type="button" onclick="return exportDept();" styleClass="button01"/>
            <h:commandButton value="查看变动表" type="button" onclick="doNotePopup()" styleClass="button01" rendered="false"/>
            <h:commandButton value="核对保险基数" type="button" onclick="doCheckInsurace()" styleClass="button01"/>
<c:verbatim>
        </td></tr>

        <tr><td height=8 >
</c:verbatim>
            <h:panelGroup>
                <h:outputText value="参考信息(薪酬发放历史)："></h:outputText>
                <h:selectOneMenu value="#{wage_flowBB.itemType}" >
                    <c:selectItems value="#{wage_flowBB.itemTypeList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton value="确定" styleClass="button01"  action="#{wage_flowBB.findDate}"></h:commandButton>
                <h:commandButton value="机构对比" type="button" onclick="return doShowOrgDiff();"  styleClass="button01"/>
                <h:commandButton value="部门对比" type="button" onclick="return showDeptdiff();"  styleClass="button01"/>
                <h:commandButton value="人员对比" type="button" onclick="return doShowDiff();"  styleClass="button01"/>
                <h:commandButton value="数据检查  " type="button" onclick="doCheckData('#{wage_flowBB.date.setId}')" rendered="#{wage_flowBB.date.status != '5'}" styleClass="button01"/>
                <h:selectOneMenu id="nowStaticID" style="width:250px">
                   <c:selectItems value="#{wage_flowBB.nowReportList}"/>
               </h:selectOneMenu>
                <h:commandButton value="显示" styleClass="button01" onclick="return OpenNowRpt();"></h:commandButton>
            
            </h:panelGroup>
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
