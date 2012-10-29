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
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{midAuditrRecuPlanBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
          <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{midAuditrRecuPlanBB.selectAll}" onclick="submit();" valueChangeListener="#{midAuditrRecuPlanBB.queryAll}"/>
				<h:outputText value="全部显示"/>
          </h:panelGroup>
            <h:panelGroup>
                <h:outputText value="记录数:#{midAuditrRecuPlanBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{midAuditrRecuPlanBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{midAuditrRecuPlanBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{midAuditrRecuPlanBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{midAuditrRecuPlanBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{midAuditrRecuPlanBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{midAuditrRecuPlanBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{midAuditrRecuPlanBB.last}" styleClass="button01"></h:commandButton>
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
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
            </h:column>
        	<h:column>
                <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
                <h:outputText value="#{list.planName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="审批意见"/></c:facet>
                <h:outputText value="#{list.approveReason}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
                <h:outputText value="#{list.startDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
                <h:outputText value="#{list.endDate}"/>
            </h:column>
            
			<h:column>
            <c:facet name="header"><h:outputText value="招聘职位个数"/></c:facet>
            <h:outputText value="#{list.postCount}"/>
        	</h:column>
        	
         	<h:column>
            <c:facet name="header"><h:outputText value="总需求人数"/></c:facet>
            <h:outputText value="#{list.needCount}"/>
        	</h:column>
        	
         <h:column>
                 <c:facet name="header"><h:outputText value="操作"/></c:facet>
                 <h:commandButton value="审批" styleClass="button01" rendered="#{list.planStatus=='1' && list.curNodeOperate=='1641'}" onclick="return doAudit1('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="审批" styleClass="button01" rendered="#{list.planStatus=='1' && list.curNodeOperate=='1642'}" onclick="return doAudit2('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="审批" styleClass="button01" rendered="#{list.planStatus=='1' && list.curNodeOperate=='1643'}" onclick="return doAudit3('#{list.planID}');"></h:commandButton>
                 <h:commandButton value="查看" styleClass="button01" onclick="return doQuery('#{list.planID}');" rendered="#{list.planStatus!='1'}"></h:commandButton>
                 <h:commandButton value="查看流程" onclick="return showWorkFlowLogByLinkID('#{list.planID}')" styleClass="button01"></h:commandButton>
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