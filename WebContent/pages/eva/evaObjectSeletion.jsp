<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  

<x:saveState value="#{evaobjectScoreListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaobjectScoreListBB.pageInit}"></h:inputHidden>
    <h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{evaobjectScoreListBB.doQuery}"></h:commandButton>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
    	<h:panelGrid align="right" >
    	  <h:outputText value="#{evaobjectScoreListBB.gradeDes}"></h:outputText>
    	  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
            	
                <h:outputText value="记录数:#{evaobjectScoreListBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{evaobjectScoreListBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{evaobjectScoreListBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{evaobjectScoreListBB.pagevo.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{evaobjectScoreListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{evaobjectScoreListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{evaobjectScoreListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{evaobjectScoreListBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{evaobjectScoreListBB.objectList}" var="list" align="center" id="dateList"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="机构"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="客体名称"/></c:facet>
            <h:outputText value="#{list.objectName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="客体得分"/></c:facet>
            <h:outputText value="#{list.score}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结果等级"/></c:facet>
            <h:outputText value="#{list.gradeName}"/>
        </h:column>
        <h:column>
        	<c:facet name="header"><h:outputText value="主体"/></c:facet>
          	<h:dataTable var="masterList" value="#{list.masterList}" columnClasses="td_middle_center" width="100%" >
	          	<h:column>
           			 <h:outputText value="#{masterList.personName}"/>
        		</h:column>
           </h:dataTable>
        </h:column>
        <h:column>
        	<c:facet name="header"><h:outputText value="主体类型"/></c:facet>
          	<h:dataTable var="masterList" value="#{list.masterList}" columnClasses="td_middle_center" width="100%" >
	          	<h:column>
           			 <h:outputText value="#{masterList.masterType}"/>
        		</h:column>
           </h:dataTable>
        </h:column>
         <h:column>
        	<c:facet name="header"><h:outputText value="投票结果"/></c:facet>
          	<h:dataTable var="masterList" value="#{list.masterList}" columnClasses="td_middle_center" width="100%" >
	          	<h:column>
           			 <h:outputText value="#{masterList.gradeId}"/>
        		</h:column>
           </h:dataTable>
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
