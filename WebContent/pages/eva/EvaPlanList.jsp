<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
 <script type="text/javascript">
	 function modify(id){
	     window.showModalDialog("/eva/EvaPlanEdit.jsf?planID="+id, "", "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:yes");
	     return true;
	 }
	 function viewAtt(id){
	  	 window.open('/pages/eva/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
	 }
	  function setGrade(planId){
		  window.showModalDialog("/eva/setPlanTemplate.jsf?planId="+planId, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px; status:0;resizable:yes");
		  return true;
	 }
	  function setElecitonGrade(planId){
		  window.showModalDialog("/eva/setPlanEleciton.jsf?planId="+planId, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px; status:0;resizable:yes");
		  return true;
	  }
 </script>
<x:saveState value="#{eva_planBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_planBB.pageInit}"/>

    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 考核计划查询"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" align="center" width="98%">

        <h:panelGrid columns="1" align="right">
            <h:panelGroup>
                <h:outputText value="计划状态"></h:outputText>
                <h:selectOneMenu value="#{eva_planBB.status}" onchange="submit();" valueChangeListener="#{eva_planBB.changeStatus}">
                    <c:selectItem itemLabel="全部" itemValue="-1"></c:selectItem>
                    <c:selectItem itemLabel="起草" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="报批" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="批准" itemValue="2"></c:selectItem>
                    <c:selectItem itemLabel="执行" itemValue="3"></c:selectItem>
                    <c:selectItem itemLabel="结果报批" itemValue="4"></c:selectItem>
                     <c:selectItem itemLabel="结果审批批准" itemValue="4"></c:selectItem>
                    <c:selectItem itemLabel="结束" itemValue="5"></c:selectItem>
                </h:selectOneMenu>
            </h:panelGroup>
        </h:panelGrid>

        <h:dataTable value="#{eva_planBB.planList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03"  >
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
            <h:outputText value="#{list.aduitContent}"/>
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
            <c:facet name="header"><h:outputText value="结果审批意见"/></c:facet>
            <h:outputText value="#{list.resultAuditExplain}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="绩效考核文件"/></c:facet>
            <h:commandLink value="查看"   onclick="viewAtt('#{list.evaFile}')" rendered="#{list.haveEvaFile=='1'}">
            </h:commandLink>
        </h:column>
		<h:column>
                <c:facet name="header"><h:outputText value="考核模型"/></c:facet>
                <h:outputText value="#{list.evaModelDes}"/>
        </h:column>
        <h:column>
                <c:facet name="header"><h:outputText value="考核客体类型"/></c:facet>
                <h:outputText value="#{list.objectTypeDes}"/>
        </h:column>
         <h:column>
                <c:facet name="header"><h:outputText value="分数小数位"/></c:facet>
                <h:outputText value="#{list.scorePersDes}"/>
        </h:column>
         <h:column>
                <c:facet name="header"><h:outputText value="层次权重小数位"/></c:facet>
                <h:outputText value="#{list.levelPersDes}"/>
        </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="删除" rendered="#{list.status=='0'}" styleClass="button01" action="#{eva_planBB.deletePlan}">
                    <x:updateActionListener property="#{eva_planBB.planID}" value="#{list.planId}"/>
                </h:commandButton>
                <h:commandButton value="修改" rendered="#{list.status=='0' || list.status=='7'}" onclick="return modify('#{list.planId}')" styleClass="button01"></h:commandButton>
                <h:commandButton value="报批" rendered="#{list.status=='0'}" styleClass="button01" action="#{eva_planBB.ApplyPlan}">
                    <x:updateActionListener property="#{eva_planBB.planID}" value="#{list.planId}"/>
                </h:commandButton>
                <h:commandButton value="执行" rendered="#{list.status=='2'}" styleClass="button01" action="#{eva_planBB.executePlan}">
                    <x:updateActionListener property="#{eva_planBB.planID}" value="#{list.planId}"/>
                </h:commandButton>
                <h:commandButton value="结果报批" rendered="#{list.status=='3'}" styleClass="button01" action="#{eva_planBB.ApplyResult}">
                    <x:updateActionListener property="#{eva_planBB.planID}" value="#{list.planId}"/>
                </h:commandButton>
                <h:commandButton value="发布考核文件" styleClass="button01" action="#{eva_planBB.publishEvaFile}" rendered="#{list.haveEvaFile=='1'&&list.hasSendBull=='0'}">
                    <x:updateActionListener property="#{eva_planBB.planID}" value="#{list.planId}"/>
                </h:commandButton>
                <h:commandButton value="考核模板设置" rendered="#{(list.status=='0' || list.status=='7')&&list.evaModel=='0'}" onclick="return setGrade('#{list.planId}')" styleClass="button01"></h:commandButton>
                <h:commandButton value="投票比例控制" rendered="#{(list.status=='0' || list.status=='7')&&list.evaModel=='3'}" onclick="return setElecitonGrade('#{list.planId}')" styleClass="button01"></h:commandButton>
                <h:commandButton value="录入总结" rendered="#{list.showWorkSum=='0'}" styleClass="button01" action="#{eva_planBB.setRegWorkSum}">
                    <x:updateActionListener property="#{eva_planBB.planID}" value="#{list.planId}"/>
                </h:commandButton>
                <h:commandButton value="取消录入总结" rendered="#{list.showWorkSum=='1'}" styleClass="button01" action="#{eva_planBB.setNoRegWorkSum}">
                    <x:updateActionListener property="#{eva_planBB.planID}" value="#{list.planId}"/>
                </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>