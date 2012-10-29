<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
        function doQuery(id) {
            window.showModalDialog("/recruit/innerRecruitDemandQuery.jsf?planID="+id, null, "dialogWidth:900px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function post(id) {
            window.showModalDialog("/recruit/innerRecruitPostList.jsf?planID="+id, null, "dialogWidth:900px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{recu_innerRecruitDemandBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{recu_innerRecruitDemandBB.initPlanAudit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{recu_innerRecruitDemandBB.superId}"></h:inputHidden>
   
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr><td height="8"> 
    </c:verbatim>
    
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{recu_innerRecruitDemandBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
          	<h:panelGroup>
            	<h:selectBooleanCheckbox value="#{recu_innerRecruitDemandBB.selectAll}" onclick="submit();" valueChangeListener="#{recu_innerRecruitDemandBB.queryAll}"/>
				<h:outputText value="全部显示"/>
          	</h:panelGroup>
            <h:panelGroup>
                <h:outputText value="记录数:#{recu_innerRecruitDemandBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recu_innerRecruitDemandBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recu_innerRecruitDemandBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recu_innerRecruitDemandBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{recu_innerRecruitDemandBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recu_innerRecruitDemandBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recu_innerRecruitDemandBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recu_innerRecruitDemandBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <x:dataTable value="#{recu_innerRecruitDemandBB.planList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
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
                 <c:facet name="header"><h:outputText value="操作"/></c:facet>
                 <h:commandButton value="发布" styleClass="button01" rendered="#{list.planStatus=='2'}" action="#{recu_innerRecruitDemandBB.publish}">
                 	<x:updateActionListener property="#{recu_innerRecruitDemandBB.planId}" value="#{list.planID}"/>
                 </h:commandButton>
            	<h:commandButton value="查看岗位" styleClass="button01" onclick="return doQuery('#{list.planID}');"></h:commandButton>
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