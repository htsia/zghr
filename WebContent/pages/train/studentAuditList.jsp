<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
        function doAudit(id) {
            window.showModalDialog("/train/TrainStudentAuditEdit.jsf?studentID="+id, null, "dialogWidth:350px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{studentAudit_ListBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{studentAudit_ListBB.initPlanAudit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{studentAudit_ListBB.superId}"></h:inputHidden>
   
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr><td height="8"> 
    </c:verbatim>
    
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{studentAudit_ListBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
          <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{studentAudit_ListBB.selectAll}" onclick="submit();" valueChangeListener="#{studentAudit_ListBB.queryAll}"/>
				<h:outputText value="ȫ����ʾ"/>
          </h:panelGroup>
            <h:panelGroup>
                <h:outputText value="��¼��:#{studentAudit_ListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{studentAudit_ListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{studentAudit_ListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{studentAudit_ListBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{studentAudit_ListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{studentAudit_ListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{studentAudit_ListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{studentAudit_ListBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <x:dataTable value="#{studentAudit_ListBB.studentList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" >
           			<h:column>
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ա�" />
						</c:facet>
						<h:outputText value="#{list.personSex}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="�����༶" />
						</c:facet>
						<h:outputText value="#{list.className}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����ʱ��" />
						</c:facet>
						<h:outputText value="#{list.signTime}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="��������" />
						</c:facet>
						<h:outputText value="#{list.personDept}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="״̬" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
        	<h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="����" styleClass="button01" rendered="#{list.status=='����'}" onclick="return doAudit('#{list.studentID}');"></h:commandButton>
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