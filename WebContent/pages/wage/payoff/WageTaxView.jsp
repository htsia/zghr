<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript">
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
    function doExport() {
       window.open('/wage/payoff/SetSelectToExport.jsf','','toolbar=0,scrollbars=1,height='+screen.height*0.8+',width=500,top=40,left='+(screen.width-500)/2);
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

<body>
<x:saveState value="#{wage_flowBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.viewTax}"/>
    <h:inputHidden value="#{wage_flowBB.inputItem}"/>
    <h:inputHidden value="#{wage_flowBB.finalTax}"/>
    <h:inputHidden id="setId" value="#{wage_flowBB.date.setId}"/>
    <h:inputHidden id="dateId" value="#{wage_flowBB.date.dateId}"/>
    <h:inputHidden id="setName" value="#{wage_flowBB.date.setName}"/>
    <h:inputHidden id="unitId" value="#{wage_flowBB.date.unitID}"/>
    <c:verbatim>
    <table width=100% height=97% border=0 >
    <tr><td height=8px>
    </c:verbatim>
        <h:panelGrid width="98%" align="center">
            <h:panelGrid columns="4" width="100%" align="center" >
              <h:panelGroup>
                <h:outputText value="发薪日期:#{wage_flowBB.date.date}"/>
                <h:outputText value="      "></h:outputText>

                <h:outputText value="财务审核状态:"></h:outputText>
                <h:outputText escape="false" value="<font color=red>#{wage_flowBB.date.taxCheckResultDes}</font>"></h:outputText>
                <h:outputText value="    "></h:outputText>
              </h:panelGroup>

                <h:panelGroup>
                    <h:inputText id="name" value="#{wage_flowBB.personCode}"   size="10" styleClass="input"  />
                    <h:commandButton value="查询" id="queryPerson"    styleClass="button01"  action="#{wage_flowBB.queryTaxByName}"/>
                </h:panelGroup>

                <h:panelGroup>
                    <h:commandButton value="审核通过"  styleClass="button01" rendered="#{wage_flowBB.date.status=='6' || wage_flowBB.date.status=='1'}" action="#{wage_flowBB.taxCheckOK}"></h:commandButton>
                    <h:commandButton value="审核不通过" styleClass="button01" rendered="#{wage_flowBB.date.status=='6'|| wage_flowBB.date.status=='1'}" action="#{wage_flowBB.taxCheckCancel}"></h:commandButton>
                </h:panelGroup>

                <h:panelGroup>
                    <h:selectOneMenu id="sortList" >
                       <c:selectItems value="#{wage_flowBB.sortList}"></c:selectItems>
                    </h:selectOneMenu>
                    <h:commandButton value="求和" type="button" styleClass="button01" onclick="return beginGroup();"/>
                    <h:commandButton value="分类" type="button" styleClass="button01" onclick="return beginClass();"/>
                    <h:commandButton value="显示卡片" type="button" styleClass="button01" onclick="return doViewCard();"></h:commandButton>
                    <h:commandButton value="导出到Excel" styleClass="button01" type="button" onclick="doExport();"/>
                </h:panelGroup>
            </h:panelGrid>
        </h:panelGrid>

        <h:panelGrid columns="3" align="center" width="95%" >
            <h:outputText value="审批人：#{wage_flowBB.date.approver}"/>
            <h:outputText value="复核人：#{wage_flowBB.date.checker}"/>
            <h:outputText value="制表人：#{wage_flowBB.date.creator}"/>
        </h:panelGrid>
    <c:verbatim>
    </td>
</tr>
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
