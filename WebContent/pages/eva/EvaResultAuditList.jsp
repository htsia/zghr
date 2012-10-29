<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script>
   function showResult(planId,evamodle){
	    window.showModalDialog("/eva/EvaResultList.jsf?planId="+planId+"&evaModle="+evamodle, "","dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
	    return true;
   }
   function aduit(planId,evamodle){
	    window.showModalDialog("/eva/EvaResultAuditEdit.jsf?planId="+planId+"&evaModle="+evamodle, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
	    return true;
   }
   
</script>

<x:saveState value="#{eva_resultAuditBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_resultAuditBB.pageInit}"/>
    <c:verbatim>
    <br/><br/><br/>
    </c:verbatim>
    
    <h:panelGrid columns="1" align="center" width="98%">
     
        <h:dataTable value="#{eva_resultAuditBB.planList}" width="100%" var="list" align="center" id="dateList"
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
                <h:commandButton value="结果审批" rendered="#{list.status=='4'}" styleClass="button01" onclick="return aduit('#{list.planId}','#{list.evaModel}');">
                </h:commandButton>
                <h:commandButton value="查看结果"  styleClass="button01" onclick="return showResult('#{list.planId}','#{list.evaModel}');"/>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>