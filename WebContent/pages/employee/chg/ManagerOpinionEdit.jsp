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
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+document.all('form1:personID').value+"&ORGUID=&Parameter=&Title=";
            //alert(url);
            window.open(url);
           return false;
       }
        
    </script>
</head>

<body>
<x:saveState value="#{emp_PersonChgListBB}"/>
<h:form id="form1">
    <h:inputHidden id="toOrgEdit" value="#{emp_PersonChgListBB.managerOrgEdit}"/>
    <h:inputHidden id="ids" value="#{emp_PersonChgListBB.ids}"/>
    <h:inputHidden id="personID" value="#{emp_PersonChgListBB.personchangevo.personId}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <f:verbatim>
              <%=LanguageSupport.getResource( "RYGL-2179", "调配管理")%>->
              <%=LanguageSupport.getResource( "RYGL-2180", "主管部门审批")%>
         </f:verbatim>
       </h:panelGroup>
    </h:panelGrid>
    <br>
    <h:panelGrid columns="2"  align="center" width="60%" columnClasses="td_form01,td_form02" styleClass="table03">
         <f:verbatim>
              <%=LanguageSupport.getResource( "RYGL-2185", "审批表格")%>
         </f:verbatim>
        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:140">
               <c:selectItems value="#{emp_PersonChgListBB.reportList}"/>
            </h:selectOneMenu>
            <h:commandButton value="显示表格" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
        </h:panelGroup>
          <f:verbatim>
              <%=LanguageSupport.getResource( "RYGL-2184", "审批日期")%>
         </f:verbatim>
        <h:panelGroup>
            <h:inputText id="date" value="#{emp_PersonChgListBB.personchangevo.managerDate}"/>
            <c:verbatim>
               <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:date')">
            </c:verbatim>
         </h:panelGroup>
         <f:verbatim>
              <%=LanguageSupport.getResource( "RYGL-2183", "截至报到日期")%>
         </f:verbatim>
        <h:panelGroup>
            <h:inputText id="requestDate" value="#{emp_PersonChgListBB.personchangevo.requestDate}"/>
            <c:verbatim>
               <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:requestDate')">
            </c:verbatim>
         </h:panelGroup>
         <f:verbatim>
              <%=LanguageSupport.getResource( "RYGL-2023", "审批意见")%>
         </f:verbatim>
        <h:panelGroup>
            <h:selectOneMenu id="status" value="#{emp_PersonChgListBB.personchangevo.managerOpinion}" onchange="changeStatus();">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="0" itemLabel="不同意"/>
            </h:selectOneMenu>
            <h:commandButton id="idOK" value="审批通过" action="#{emp_PersonChgListBB.managerApprove}" styleClass="button01" onclick="return confirm('您确认提交?')">
            </h:commandButton>
        </h:panelGroup>


        <f:verbatim>
              <%=LanguageSupport.getResource( "RYGL-2182", "原因")%>
         </f:verbatim>
        <h:inputTextarea value="#{emp_PersonChgListBB.personchangevo.managerReason}" rows="3" cols="50"/>
    </h:panelGrid>

     <f:verbatim>
              <%=LanguageSupport.getResource( "RYGL-2181", "详细信息")%>  <br>
    </f:verbatim>
    <jsp:include page="/pages/common/activepage/ShowTable.jsp">
        <jsp:param name="para" value="true"/>
    </jsp:include>
</h:form>
</body>
</html>