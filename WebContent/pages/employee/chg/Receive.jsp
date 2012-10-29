<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<base target="_self">
<script type="text/javascript">
    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }

        perID = document.all("form1:personId").value;
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID=&Parameter=&Title=";
        window.open(url);
        return false;
   }

</script>

<x:saveState value="#{emp_PersonChgListBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrgEdit" value="#{emp_PersonChgListBB.receiveEdit}"/>
    <h:inputHidden id="chgId" value="#{emp_PersonChgListBB.personchangevo.chgId}"/>
    <h:inputHidden id="personId" value="#{emp_PersonChgListBB.personchangevo.personId}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
          <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-2179", " 调配管理")%>->
                  <%=LanguageSupport.getResource("RYGL-2212", " 报到处理")%>
          </f:verbatim>
       </h:panelGroup>
    </h:panelGrid>
    <br>
    <h:panelGrid columns="2"  align="center" width="60%" columnClasses="td_form01,td_form02" styleClass="table03">
         <f:verbatim>
             <%=LanguageSupport.getResource("RYGL-2215", "接收日期")%>
          </f:verbatim>
        <h:panelGroup>
            <h:inputText id="date" value="#{emp_PersonChgListBB.personchangevo.receiveDate}"/>
            <c:verbatim>
               <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:date')">
            </c:verbatim>
         </h:panelGroup>
         <f:verbatim>
             <%=LanguageSupport.getResource("RYGL-2216", "相关表格")%>
          </f:verbatim>
        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:140">
               <c:selectItems value="#{emp_PersonChgListBB.reportList}"/>
            </h:selectOneMenu>
            <h:commandButton value="显示表格" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
        </h:panelGroup>

        <h:outputText value="操作"/>
        <h:panelGroup>
            <h:commandButton id="idOK" value="确定" onclick="return forsubmit(document.forms(0));" action="#{emp_PersonChgListBB.finish}" styleClass="button01" >
            </h:commandButton>
            <h:commandButton id="idCancel" value="返回" onclick="window.close()" styleClass="button01" >
            </h:commandButton>
        </h:panelGroup>
    </h:panelGrid>

        <f:verbatim>
             <%=LanguageSupport.getResource("RYGL-2181", "详细信息")%>：
          </f:verbatim>
     <br>
    <jsp:include page="/pages/common/activepage/ShowTable.jsp">
        <jsp:param name="para" value="true"/>
    </jsp:include>
</h:form>
