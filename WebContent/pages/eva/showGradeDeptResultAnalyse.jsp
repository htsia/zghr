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
            <td class="td_title"><img src="/images/tips.gif"> ��Ч����-> ���ſ������ݷ���</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
         
          <h:panelGrid align="right" columns="2">
          		
             	<h:panelGroup>
                <h:outputText value="����ģ�壺"></h:outputText>
                <h:selectOneMenu id="templateID" value="#{evaDeptResultAnslyseBB.templateId}" onchange="submit();" valueChangeListener="#{evaDeptResultAnslyseBB.changeTemp}">
                   <c:selectItems value="#{evaDeptResultAnslyseBB.templates}"></c:selectItems>
           		</h:selectOneMenu>
           		<h:outputText value="  "></h:outputText>
                <h:outputText value="��¼��:#{evaDeptResultAnslyseBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{evaDeptResultAnslyseBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{evaDeptResultAnslyseBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{evaDeptResultAnslyseBB.pagevo.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{evaDeptResultAnslyseBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaDeptResultAnslyseBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaDeptResultAnslyseBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{evaDeptResultAnslyseBB.last}" styleClass="button01"></h:commandButton>
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

