<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{taskEstimateLogBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{taskEstimateLogBB.pageInit}"/>
    <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 绩效管理 ->任务考核日志"/>
          </h:panelGroup>
     </h:panelGrid>
    <c:verbatim>
	<br><br>
	</c:verbatim>
    <h:panelGrid columns="1" align="center" width="98%">
     
        <h:dataTable value="#{taskEstimateLogBB.logList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03">
        <h:column>
            <c:facet name="header"><h:outputText value="操作用户"/></c:facet>
            <h:outputText value="#{list.operId}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="动作"/></c:facet>
            <h:outputText value="#{list.actionDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作时间"/></c:facet>
            <h:outputText value="#{list.actionDate}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="内容"/></c:facet>
            <h:outputText value="#{list.content}"/>
        </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>