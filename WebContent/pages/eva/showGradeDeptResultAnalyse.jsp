<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
          
    </script>

<x:saveState value="#{evaDeptResultAnslyseBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaDeptResultAnslyseBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{evaDeptResultAnslyseBB.planId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 绩效管理-> 部门考核数据分析</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
         
          <h:panelGrid align="right" columns="2">
          		
             	<h:panelGroup>
                <h:outputText value="考核模板："></h:outputText>
                <h:selectOneMenu id="templateID" value="#{evaDeptResultAnslyseBB.templateId}" onchange="submit();" valueChangeListener="#{evaDeptResultAnslyseBB.changeTemp}">
                   <c:selectItems value="#{evaDeptResultAnslyseBB.templates}"></c:selectItems>
           		</h:selectOneMenu>
           		<h:outputText value="  "></h:outputText>
                <h:outputText value="记录数:#{evaDeptResultAnslyseBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{evaDeptResultAnslyseBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{evaDeptResultAnslyseBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{evaDeptResultAnslyseBB.pagevo.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{evaDeptResultAnslyseBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{evaDeptResultAnslyseBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{evaDeptResultAnslyseBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{evaDeptResultAnslyseBB.last}" styleClass="button01"></h:commandButton>
         </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
		<jsp:include page="/pages/eva/deptGradeAnalyseResult.jsp"></jsp:include>
	  </div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

