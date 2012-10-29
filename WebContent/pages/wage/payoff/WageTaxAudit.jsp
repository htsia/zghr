<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript">
    function showSum(){
        var url="/wage/payoff/ShowSumInfo.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
        window.open(url,'','toolbar=0,height='+screen.height*0.8+',width='+screen.width*0.9+',top='+screen.height*0.1+',left='+screen.width*0.05);
        return false;
    }

    function openChangeRecord(){
        window.showModalDialog("/wage/payoff/showChangeRecord.jsf?SetID="+form1.all("form1:setId").value+"&PayoffMonth="+document.all('form1:payoffDate').value.substr(0,7), null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
        return false;
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

    function showProcessBar() {
       x = document.body.clientWidth / 2 - 150;
       y = document.body.clientHeight / 2;
       document.all('processbar').style.top = y;
       document.all('processbar').style.left = x;
       document.all('processbar').style.display = "";
    }

    function beginGroup(){
        if (document.all("form1:sortList").value=="-1") {
            alert("没有选择汇总信息项");
        }
        else{
           window.showModalDialog("/wage/payoff/ShowGroup.jsf?SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }

    function beginClass(){
        if (document.all("form1:sortList").value=="-1") {
            alert("没有选择汇总信息项");
        }
        else{
           window.showModalDialog("/wage/payoff/ShowClass.jsf?SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }
    function doExport() {
       window.open('/wage/payoff/SetSelectToExport.jsf','','toolbar=0,scrollbars=1,height='+screen.height*0.8+',width=500,top=40,left='+(screen.width-500)/2);
    }

    function OpenRptByDept(){
        var url="/report/DeptReportShow.jsf?unitId="+document.all("form1:unitId").value+"&setId=DATE_"+document.all("form1:dateId").value
                 +"&setName="+form1.all("form1:setName").value+"&pids=";
        window.showModalDialog( url, null, "dialogWidth:400px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;// 返回true 以便涮新界面 从而得到部门权限session
    }

    function forViewPerson(form, id, type){
        window.showModalDialog("/wage/payoff/wagePersonquery.jsf?pID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
    }
    function forView(setId,payoffId,status,dt,approver,checker,creator){
        windowOpen("/pages/wage/payoff/DeptWageDetailView.jsp?setId="+setId+"&dateId="+payoffId+"&status="+status+"&date="+dt+"&approver="+approver+"&checker="+checker+"&creator="+creator, '', '', '800', '400', 'yes', '100', '100', 'yes') ;
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
    function doViewCard(){
        var ID=getFirstSelectValue(form1.chk);
        //debugger;
        if (ID!=null && ID!=""){
           window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value+"&ID="+ID, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        }else{
           window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }
</script>

<x:saveState value="#{wage_flowBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.auditTax}"/>
    <h:inputHidden value="#{wage_flowBB.inputItem}"/>
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
    <h:inputHidden id="setName" value="#{wage_flowBB.date.setName}"/>
    <h:inputHidden id="unitId" value="#{wage_flowBB.date.unitID}"/>
    <h:inputHidden id="payoffDate" value="#{wage_flowBB.date.yearMonth}"/>

    <c:verbatim>
    <table width=100% height=97% border=0 >
        <tr><td height=8px align="left">
</c:verbatim>
            <h:outputText escape="false" value="<strong>发薪日期:</strong>#{wage_flowBB.date.date}"/>
            <h:outputText value="      "></h:outputText>

            <h:outputText escape="false" value="<strong>审核状态:</strong>"></h:outputText>
            <h:outputText escape="false" value="<font color=red>#{wage_flowBB.date.taxCheckResultDes}</font>"></h:outputText>
            <h:outputText value="    "></h:outputText>

            <h:outputText  escape="false" value="<strong>审批状态:</strong>"></h:outputText>
            <h:outputText escape="false" value="<font color=red>#{wage_flowBB.date.taxAuditResultDes}</font>"></h:outputText>
            <h:outputText value="    "></h:outputText>
<c:verbatim>
        </td></tr>

        <tr>
        <td height=8px align="left">
</c:verbatim>
            <h:selectOneMenu id="ReportID" style="width:250px">
               <c:selectItems value="#{wage_flowBB.reportList}"/>
           </h:selectOneMenu>

            <h:commandButton value="显示审批表" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>


            <h:commandButton value="审批通过"  styleClass="button01" rendered="#{wage_flowBB.date.status=='7'}" onclick="showProcessBar();" action="#{wage_flowBB.taxAuditOK}"></h:commandButton>
            <h:commandButton value="审批不通过" styleClass="button01" rendered="#{wage_flowBB.date.status=='7'}" onclick="showProcessBar();" action="#{wage_flowBB.taxAuditCancel}"></h:commandButton>
            <h:commandButton value="查看变动" styleClass="button01" type="button" onclick="openChangeRecord();"></h:commandButton>
            <h:commandButton value="查看汇总" styleClass="button01" type="button" onclick="showSum();"></h:commandButton>

 <c:verbatim>
        </td>
        </tr>

        <tr><td height=8px align="right">
</c:verbatim>
            <h:inputText id="name" value="#{wage_flowBB.personCode}"   size="10" styleClass="input"  />
            <h:commandButton value="查询" id="queryPerson"    styleClass="button01"  action="#{wage_flowBB.queryTaxByName}"/>


            <h:selectOneMenu id="sortList" >
               <c:selectItems value="#{wage_flowBB.sortList}"></c:selectItems>
            </h:selectOneMenu>
            <h:commandButton value="求和" type="button" styleClass="button01" onclick="return beginGroup();"/>
            <h:commandButton value="分类" type="button" styleClass="button01" onclick="return beginClass();"/>

            <h:commandButton value="显示卡片" type="button" styleClass="button01" onclick="return doViewCard();"></h:commandButton>
            <h:commandButton value="导出到Excel" styleClass="button01" type="button" onclick="doExport();"/>
<c:verbatim>
        </td></tr>

        <tr><td height=8px >
 </c:verbatim>
            <h:panelGrid columns="3" align="center" width="95%" >
                <h:outputText value="审批人：#{wage_flowBB.date.approver}"/>
                <h:outputText value="复核人：#{wage_flowBB.date.checker}"/>
                <h:outputText value="制表人：#{wage_flowBB.date.creator}"/>
            </h:panelGrid>
<c:verbatim>
        </td></tr>

        <tr><td>
            <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                <jsp:param name="hasOperSign" value="true"/>
                <jsp:param name="operSignType" value="checkbox"/>
                <jsp:param name="hasEdit" value="true"/>
                <jsp:param name="isEditList" value="false"/>
                <jsp:param name="isCheckRight" value="true"/>
                <jsp:param name="isForward" value="true"/>
                <jsp:param name="isRow" value="true"/>
                <jsp:param name="rowFuncName" value="forViewPerson"/>
                <jsp:param name="isPage" value="true"/>
                <jsp:param name="fixcol" value="4"/>
            </jsp:include>
     </td></tr>
     </table>
</c:verbatim>    
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr>
    </table>
</marquee>
