<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<f:verbatim>
    <script type="text/javascript">
        function inputScore(id) {
            window.open("/eva/selfAuditPlan.jsf?planID="+id, "", "height="+screen.height*0.8+", width="+screen.width*0.9+", top=50,left=100, toolbar=no, menubar=no, location=center, status=no,resizable=yes,scrollbars=yes ");
            return true;
        }
        function inputScore2(id) {
            window.open("/eva/selfAuditPlanShow.jsf?planID="+id, "", "height="+screen.height*0.8+", width="+screen.width*0.9+", top=50,left=100, toolbar=no, menubar=no, location=center, status=no,resizable=yes,scrollbars=yes ");
            return true;
        }
        function inputElection(id) {
            window.showModalDialog("/eva/EvaElectionShow.jsf?planID="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:yes;scroll:yes;");
            return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{eva_selfscorebb}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_selfscorebb.pageInit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 自助打分"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" align="center" width="98%">
        <h:dataTable value="#{eva_selfscorebb.planList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
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
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
               <h:commandButton value="打分"  styleClass="button01" onclick="inputScore('#{list.planId}')" rendered="#{list.evaModel=='0'&&list.allowMark=='1'}">
               </h:commandButton>
               <h:commandButton value="打分"  styleClass="button01" onclick="inputElection('#{list.planId}')" rendered="#{list.evaModel=='3'&&list.allowMark=='1'}">
               </h:commandButton>
               <%-- 
               <h:commandButton value="查看结果"  styleClass="button01" onclick="inputScore2('#{list.planId}')" rendered="#{list.evaModel=='0'&&list.allowMark=='0'}">
               </h:commandButton>
               --%>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>