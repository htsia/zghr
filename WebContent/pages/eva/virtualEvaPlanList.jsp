<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
 <script type="text/javascript">
	 function addPlan(){
	     window.showModalDialog("/eva/addMixPlan.jsf?planID="+document.all("form1:planID").value, "", "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.3+"px; status:0;resizable:yes");
	     return true;
	 }
 </script>
<x:saveState value="#{eva_planExecuteBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_planExecuteBB.initMixPlan}"/>
	<h:inputHidden id="planID" value="#{eva_planExecuteBB.planID}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 虚拟计划设置"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" align="center" width="98%">
		<h:panelGrid columns="1" align="right" >
			<h:commandButton value="选择计划"  styleClass="button01" onclick="addPlan()"></h:commandButton>
		</h:panelGrid>
        <h:dataTable value="#{eva_planExecuteBB.mixPlanList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03"  >
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
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
                <c:facet name="header"><h:outputText value="考核模型"/></c:facet>
                <h:outputText value="#{list.evaModelDes}"/>
        </h:column>
        <h:column>
                <c:facet name="header"><h:outputText value="权重(%)"/></c:facet>
                <h:outputText value="#{list.purview}"/>
        </h:column>
        <h:column>
               <c:facet name="header"><h:outputText value="操作"/></c:facet>
               <h:commandButton value="删除"  styleClass="button01" action="#{eva_planExecuteBB.deleteMix}">
                    <x:updateActionListener property="#{eva_planExecuteBB.mixId}" value="#{list.mixId}"/>
               </h:commandButton>
        </h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>