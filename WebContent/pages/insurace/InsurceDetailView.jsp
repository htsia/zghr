<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript">
    var lastRow;
    var currRow;
    function forSelectStyle(obj) {
        if (lastRow != null) {
            for (i = 0; i < lastRow.length; i++) {
                lastRow[i].style.backgroundColor = "#FFFFFF";
            }
        }
        currRow = obj.parentElement.cells;
        if (currRow != null) {
            for (i = 0; i < currRow.length; i++) {
                currRow[i].style.backgroundColor = "#7D9FC0";
                currRow[i].title=currRow[3].innerText;
            }
        }

        lastRow = currRow;
    }
    function forView(setId,payoffId,status,dt,approver,checker,creator){
        windowOpen("/pages/insurace/InsuraceWageDetailView.jsp?setId="+setId+"&dateId="+payoffId+"&status="+status+"&date="+dt+"&approver="+approver+"&checker="+checker+"&creator="+creator, '', '', '800', '400', 'yes', '100', '100', 'yes') ;
    }
    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }
        var url="/pages/report/flowreportshow.jsp?Title="+document.all("form1:ReportID").value;
        window.open(url);
        return false;
    }

</script>


<x:saveState value="#{wage_flowBB.date}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_flowBB.viewInsDetail}"/>
    <c:verbatim>
    <table width=98% height=98% align="center">
    <tr><td height=8>
    </c:verbatim>
        <h:panelGrid width="95%" align="center" columns="1">
            <h:panelGrid columns="2" width="100%" align="center" >
                <h:outputText escape="false" value="<strong>发薪日期:</strong>#{wage_flowBB.date.date}"/>
                <h:outputText escape="false" value="<strong>单位：元</strong>"/>
            </h:panelGrid>

            <h:panelGrid width="100%" columns="2" align="center"  columnClasses="f04">
                <h:panelGroup>
                    <h:selectOneMenu id="ReportID" style="width:150px">
                    <c:selectItems value="#{wage_flowBB.reportList}"/>
                    </h:selectOneMenu>
                     <h:commandButton value="显示审批表" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
                </h:panelGroup>

                <h:panelGroup>
                    <h:commandButton value="按部门汇总" styleClass="button01" onclick="forView('#{wage_flowBB.date.setId}','#{wage_flowBB.date.dateId}','#{wage_flowBB.date.status}','#{wage_flowBB.date.date}','#{wage_flowBB.date.approver}','#{wage_flowBB.date.checker}','#{wage_flowBB.date.creator}');return false;"/>
                    <h:commandButton value="导出到Excel" styleClass="button01" onclick="doExport();" type="button"/>
                </h:panelGroup>
            </h:panelGrid>

         <h:panelGrid columns="3" align="center" width="95%" >
            <h:outputText escape="false" value="<strong>审批人：</strong>#{wage_flowBB.date.approver}"/>
            <h:outputText escape="false" value="<strong>复核人：</strong>#{wage_flowBB.date.checker}"/>
            <h:outputText escape="false" value="<strong>制表人：</strong>#{wage_flowBB.date.creator}"/>
        </h:panelGrid>
        </h:panelGrid>
    <c:verbatim>
    </td></tr>

    <tr><td>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="false"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
            <jsp:param name="isPage" value="true"/>
            <jsp:param name="isScroll" value="false"/>
            <jsp:param name="isRow" value="false"/>
            <jsp:param name="isSelect" value="true"/>
            <jsp:param name="selectFucName" value="forSelectStyle(this)"/>
        </jsp:include>
    </td></tr>
    </table>
    </c:verbatim>
</h:form>
