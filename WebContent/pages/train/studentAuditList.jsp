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
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{studentAudit_ListBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
          <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{studentAudit_ListBB.selectAll}" onclick="submit();" valueChangeListener="#{studentAudit_ListBB.queryAll}"/>
				<h:outputText value="全部显示"/>
          </h:panelGroup>
            <h:panelGroup>
                <h:outputText value="记录数:#{studentAudit_ListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{studentAudit_ListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{studentAudit_ListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{studentAudit_ListBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{studentAudit_ListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{studentAudit_ListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{studentAudit_ListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{studentAudit_ListBB.last}" styleClass="button01"></h:commandButton>
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
		               <c:facet name="header"><h:outputText value="序号"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="性别" />
						</c:facet>
						<h:outputText value="#{list.personSex}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="所报班级" />
						</c:facet>
						<h:outputText value="#{list.className}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="报名时间" />
						</c:facet>
						<h:outputText value="#{list.signTime}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="所属部门" />
						</c:facet>
						<h:outputText value="#{list.personDept}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="状态" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
        	<h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="审批" styleClass="button01" rendered="#{list.status=='报名'}" onclick="return doAudit('#{list.studentID}');"></h:commandButton>
            </h:column>
    </x:dataTable>
    
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>