<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function inputScore(id){
   	 window.showModalDialog("/eva/InputTeamScore.jsf?objectID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.8+"px;resizable:yes;status:yes;scroll:yes;");
   	 return false;
     }
          
    </script>

<x:saveState value="#{evaTeamSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaTeamSetBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{evaTeamSetBB.planId}"></h:inputHidden>
    <h:inputHidden id="orgId" value="#{evaTeamSetBB.orgId}"></h:inputHidden>
    <h:inputHidden id="teamIds" value="#{evaTeamSetBB.teamIds}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> ��Ч����-> �Ŷӿ��˴��</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
         
          <h:panelGrid align="right" columns="2">
          		
             	<h:panelGroup>
                <h:outputText value="����ģ�壺"></h:outputText>
                <h:selectOneMenu id="templateID" value="#{evaTeamSetBB.templateId}" onchange="submit();" valueChangeListener="#{evaTeamSetBB.changeTemp}">
                   <c:selectItems value="#{evaTeamSetBB.templates}"></c:selectItems>
           		</h:selectOneMenu>
           		<h:outputText value="  "></h:outputText>
                <h:outputText value="��¼��:#{evaTeamSetBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{evaTeamSetBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{evaTeamSetBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{evaTeamSetBB.pagevo.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{evaTeamSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaTeamSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaTeamSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{evaTeamSetBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" onclick="return add()" styleClass="button01" action="#{evaTeamSetBB.addObject}"></h:commandButton>
         </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{evaTeamSetBB.objectList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�Ŷ�����"/></c:facet>
            <h:outputText value="#{list.teamName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.teamCreateDate}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="���" onclick="inputScore('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
       </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
