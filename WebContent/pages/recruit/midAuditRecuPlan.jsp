<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
    function doAudit1(id){
        window.showModalDialog("/recruit/recuPlanAuditLevel1.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function doAudit2(id){
        window.showModalDialog("/recruit/recuPlanAuditLevel2.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function doAudit3(id){
        window.showModalDialog("/recruit/recuPlanAuditLevel3.jsf?planID="+id, null, "dialogWidth:630px; dialogHeight:700px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
        function doQuery(id) {
            window.open("/recruit/RecuPlanAuditQuery.jsf?planID="+id, null, 'height=450px, width=700px, top=100,left=200, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{midAuditrRecuPlanBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{midAuditrRecuPlanBB.initPlanAudit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{midAuditrRecuPlanBB.superId}"></h:inputHidden>
   	
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr><td height="8"> 
    </c:verbatim>
    
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{midAuditrRecuPlanBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
          <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{midAuditrRecuPlanBB.selectAll}" onclick="submit();" valueChangeListener="#{midAuditrRecuPlanBB.queryAll}"/>
				<h:outputText value="ȫ����ʾ"/>
          </h:panelGroup>
            <h:panelGroup>
                <h:outputText value="��¼��:#{midAuditrRecuPlanBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{midAuditrRecuPlanBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{midAuditrRecuPlanBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{midAuditrRecuPlanBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{midAuditrRecuPlanBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{midAuditrRecuPlanBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{midAuditrRecuPlanBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{midAuditrRecuPlanBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <x:dataTable value="#{midAuditrRecuPlanBB.planList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" >
             <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
            </h:column>
        	<h:column>
                <c:facet name="header"><h:outputText value="�ƻ�����"/></c:facet>
                <h:outputText value="#{list.planName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.approveReason}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ʼʱ��"/></c:facet>
                <h:outputText value="#{list.startDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                <h:outputText value="#{list.endDate}"/>
            </h:column>
            
			<h:column>
            <c:facet name="header"><h:outputText value="��Ƹְλ����"/></c:facet>
            <h:outputText value="#{list.postCount}"/>
        	</h:column>
        	
         	<h:column>
            <c:facet name="header"><h:outputText value="����������"/></c:facet>
            <h:outputText value="#{list.needCount}"/>
        	</h:column>
        	
         <h:column>
                 <c:facet name="header"><h:outputText value="����"/></c:facet>
                 <h:commandButton value="����" styleClass="button01" rendered="#{list.planStatus=='1' && list.curNodeOperate=='1641'}" onclick="return doAudit1('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="����" styleClass="button01" rendered="#{list.planStatus=='1' && list.curNodeOperate=='1642'}" onclick="return doAudit2('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="����" styleClass="button01" rendered="#{list.planStatus=='1' && list.curNodeOperate=='1643'}" onclick="return doAudit3('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="�鿴" styleClass="button01" onclick="return doQuery('#{list.planID}');" rendered="#{list.planStatus!='1'}"></h:commandButton>
                 <h:commandButton value="�鿴����" onclick="return showWorkFlowLogByLinkID('#{list.planID}')" styleClass="button01"></h:commandButton>
            </h:column>
    </x:dataTable>
    
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>