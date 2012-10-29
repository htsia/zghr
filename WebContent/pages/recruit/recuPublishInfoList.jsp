<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function planpost(planid)
   {
	   window.open("/recruit/publishPostInfoList.jsf?planId="+planid+"&planMethod="+"1", "", 'height=500px, width=600px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	    return true;
    }
</script>
<c:verbatim><base target="_self"></c:verbatim>
<x:saveState value="#{recu_outterRecruitBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{recu_outterRecruitBB.initPage}"/>
   
    <h:panelGrid columns="1" align="center" width="98%">
       <h:panelGrid align="right" columns="2">
          <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{recu_outterRecruitBB.selectAll}" onclick="submit();" valueChangeListener="#{recu_outterRecruitBB.queryAll}"/>
				<h:outputText value="全部显示"/>
          </h:panelGroup>
            <h:panelGroup>
                <h:outputText value="记录数:#{recu_outterRecruitBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recu_outterRecruitBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recu_outterRecruitBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recu_outterRecruitBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{recu_outterRecruitBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recu_outterRecruitBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recu_outterRecruitBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recu_outterRecruitBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>
        <h:dataTable value="#{recu_outterRecruitBB.planList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03">
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="创建人"/></c:facet>
            <h:outputText value="#{list.createID}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="创建时间"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="审批人"/></c:facet>
            <h:outputText value="#{list.approveID}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="审批时间"/></c:facet>
            <h:outputText value="#{list.approveDate}"/>
        </h:column>
  
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="发布"  styleClass="button01" action="#{recu_outterRecruitBB.publish}" rendered="#{list.planStatus=='2'}">
                    <x:updateActionListener property="#{recu_outterRecruitBB.planID}" value="#{list.planID}"/>
                </h:commandButton>   
                <h:commandButton value="查看岗位"  styleClass="button01" onclick="planpost('#{list.planID}','#{list.planName}');"/>       
            </h:column>
    </h:dataTable>
    
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>