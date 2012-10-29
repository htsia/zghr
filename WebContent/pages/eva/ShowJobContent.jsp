<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function addJob(){
            window.showModalDialog("/eva/EditJobContent.jsf","","dialogWidth:300px; dialogHeight:300px; status:0;resizable:yes");
            return true;
        }

        function modify(id){
            window.showModalDialog("/eva/EditJobContent.jsf?taskID="+id,"","dialogWidth:300px; dialogHeight:300px; status:0;resizable:yes");
            return true;
        }
    </script>
<x:saveState value="#{eva_jobContentBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_jobContentBB.pageInit}"/>
	<h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 自助岗位职责考核"/>
        </h:panelGroup>
        <h:panelGrid>
		<h:commandButton value="增加" onclick="return addJob();" styleClass="button01"></h:commandButton>
        </h:panelGrid>
    </h:panelGrid>
	
    <h:panelGrid columns="1" align="center" width="98%">
        <h:dataTable value="#{eva_jobContentBB.jobList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03"  >
        <h:column>
            <c:facet name="header"><h:outputText value="具体内容"/></c:facet>
            <h:outputText value="#{list.content}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="权重"/></c:facet>
            <h:outputText value="#{list.preview}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="自评分"/></c:facet>
            <h:outputText value="#{list.selfScore}"/>
        </h:column>

		<h:column>
            <c:facet name="header"><h:outputText value="完成情况"/></c:facet>
            <h:outputText value="#{list.result}"/>
        </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="编辑" onclick="return modify('#{list.taskID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{eva_jobContentBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{eva_jobContentBB.taskID}" value="#{list.taskID}"/>
            </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>