<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function changeStatus(){
            if (form1.all("form1:status").value=="0"){
                form1.all("form1:idOK").value = "审批不通过";
            }
            else{
                form1.all("form1:idOK").value = "审批通过";
            }
        }
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }

            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var perID = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            perID = form1.chk[i].value;   // 取第一个
                            break;
                        }
                } else
                    perID = form1.chk.value;
                var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID=&Parameter=&Title=";
                window.open(url);
            } else {
                alert("请选择人员");
            }
           return false;
       }

    </script>
</head>

<body>
<x:saveState value="#{emp_PersonChgListBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrgEdit" value="#{emp_PersonChgListBB.fromOrgEdit}"/>
    <h:inputHidden id="ids" value="#{emp_PersonChgListBB.ids}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
          <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2179", "调配管理")%>->
				 <%=LanguageSupport.getResource("RYGL-2204", "调出审批")%>
	   	</f:verbatim>
       </h:panelGroup>
    </h:panelGrid>
    <br>
    <h:panelGrid columns="2"  align="center" width="60%" columnClasses="td_form01,td_form02" styleClass="table03">
        <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2184", "审批日期")%>
	   	</f:verbatim>
        <h:panelGroup>
            <h:inputText id="date" value="#{emp_PersonChgListBB.personchangevo.fromDate}"/>
            <c:verbatim>
               <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:date')">
            </c:verbatim>
         </h:panelGroup>
        <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2205", "审批表")%>
	   	</f:verbatim>
        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:140px">
               <c:selectItems value="#{emp_PersonChgListBB.reportList}"/>
            </h:selectOneMenu>
            <h:commandButton value="显示表格" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
        </h:panelGroup>

         <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2023", "审批意见")%>
	   	</f:verbatim>
        <h:panelGroup>
            <h:selectOneMenu id="status" value="#{emp_PersonChgListBB.personchangevo.fromOpinion}" onchange="changeStatus();">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="0" itemLabel="不同意"/>
            </h:selectOneMenu>
            <h:commandButton id="idOK" value="审批通过" action="#{emp_PersonChgListBB.fromApprove}" styleClass="button01" onclick="return confirm('您确认提交?')">
            </h:commandButton>
            <h:commandButton value="删除该条非法数据" styleClass="button01" onclick="return confirm('确定要删除该数据吗?')" rendered="#{emp_PersonChgListBB.fromDelete}" action="#{emp_PersonChgListBB.deleteInvalid}"></h:commandButton>
        </h:panelGroup>

         <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2024", "原因")%>
	   	</f:verbatim>
        <h:inputTextarea value="#{emp_PersonChgListBB.personchangevo.fromReason}" rows="3" cols="50"/>
    </h:panelGrid>

    <c:verbatim>
        <strong><%=LanguageSupport.getResource("RYGL-2206", "以下为薪资信息")%></strong><br>
        <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
        </jsp:include>
    </c:verbatim>
</h:form>
</body>
</html>