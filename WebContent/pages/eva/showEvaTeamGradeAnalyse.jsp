<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
          
    </script>

<x:saveState value="#{evaTeamResultAnslyseBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaTeamResultAnslyseBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{evaTeamResultAnslyseBB.planId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> ��Ч����-> �Ŷӿ������ͷ���</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
         
          <h:panelGrid align="right" columns="2">
          		
             	<h:panelGroup>
                <h:outputText value="����ģ�壺"></h:outputText>
                <h:selectOneMenu id="templateID" value="#{evaTeamResultAnslyseBB.templateId}" onchange="submit();" valueChangeListener="#{evaTeamResultAnslyseBB.changeTemp}">
                   <c:selectItems value="#{evaTeamResultAnslyseBB.templates}"></c:selectItems>
           		</h:selectOneMenu>
           		<h:outputText value="  "></h:outputText>
                <h:outputText value="��¼��:#{evaTeamResultAnslyseBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{evaTeamResultAnslyseBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{evaTeamResultAnslyseBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{evaTeamResultAnslyseBB.pagevo.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{evaTeamResultAnslyseBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaTeamResultAnslyseBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaTeamResultAnslyseBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{evaTeamResultAnslyseBB.last}" styleClass="button01"></h:commandButton>
         </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
		<jsp:include page="/pages/eva/teamGradeAnalyseResult.jsp"></jsp:include>
	  </div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
