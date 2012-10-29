<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
	function showResult(planId,evamodle){
	    window.open("/eva/showEvaResultList.jsf?planId="+planId+"&evaModle="+evamodle, "", "height="+screen.height*0.6+", width="+screen.width*0.6+", top=100,left=150, toolbar=no, menubar=no, location=center, status=no,resizable=yes,scrollbars=yes");
	    return true;
   }
</script>
<x:saveState value="#{eva_resultPublishBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_resultPublishBB.pageInit}"/>
    <c:verbatim>
    <br/><br/><br/>
    </c:verbatim>
    
    <h:panelGrid columns="1" align="center" width="98%">
     
       
        <h:dataTable value="#{eva_resultPublishBB.planList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03">
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="考核类型"/></c:facet>
            <h:outputText value="#{list.evaModelDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="创建人"/></c:facet>
            <h:outputText value="#{list.createPersonName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
            <h:outputText value="#{list.beginDate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
            <h:outputText value="#{list.endDate}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="结果审批人"/></c:facet>
            <h:outputText value="#{list.resultAuditPerson}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="结果审批时间"/></c:facet>
            <h:outputText value="#{list.resultAuditDate}"/>
        </h:column>
  
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="结果发布" rendered="#{list.status=='5'&& list.planObjectType!='1' && list.planObjectType!='2'}"  styleClass="button01" action="#{eva_resultPublishBB.publish}" >
                    <x:updateActionListener property="#{eva_resultPublishBB.planID}" value="#{list.planId}"/>
                    <x:updateActionListener value="#{list.evaModel}" property="#{eva_resultPublishBB.evaModel}"/>
                </h:commandButton>
                 <h:commandButton value="查看结果"  styleClass="button01" onclick="return showResult('#{list.planId}','#{list.evaModel}');"/>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>