<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
    function forAdd() {
        window.showModalDialog("/lead/LeadSQLEdit.jsf?resId="+document.all("form1:resId").value, null, "dialogWidth:430px; dialogHeight:320px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forModify(ID) {
        window.showModalDialog("/lead/LeadSQLEdit.jsf?resId="+document.all("form1:resId").value+"&sqlID="+ID, null, "dialogWidth:430px; dialogHeight:320px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>

<x:saveState value="#{textget}"/>
   <h:form id="form1">
	<h:inputHidden id="init" value="#{textget.pageInit}"></h:inputHidden>
    <h:inputHidden id="resId" value="#{textget.resId}"></h:inputHidden>
    <c:verbatim><br></c:verbatim>
	<h:panelGrid width="98%"  border="0"  cellpadding="2" cellspacing="0" columns="1" >
	   <h:panelGroup>
           <h:outputText value ="名称:#{textget.showname}"/>
           <h:outputText value ="    "/>
           <h:outputText value ="选择日期:"/>
           <h:selectOneMenu value="#{textget.selectDate}">
              <c:selectItems  value="#{textget.dateList}"></c:selectItems>
           </h:selectOneMenu>
           <h:commandButton value="查看" styleClass="button01" action="#{textget.queryTextResult}"></h:commandButton>
       </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="98%"  border="0"  cellpadding="2" cellspacing="0" columns="1" >
        <c:verbatim>
        <br>
        <%
            if (session.getAttribute("TextContent")!=null)
                out.print(session.getAttribute("TextContent").toString());              
        %>
        </c:verbatim>
    </h:panelGrid>
</h:form>
