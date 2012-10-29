<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<f:verbatim>
    <script type="text/javascript">
        function doSet(planid) {
             window.showModalDialog("/eva/ResultAnalyseDeptSelf.jsf?planID="+planid, null, "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.7+"px;center:center;resizable:yes;status:no;scroll:yes;");
             return true;
        }
        function doSetGrade(planid,gradeId) {
	        window.showModalDialog("/eva/GradeResultAnalyseSelf.jsf?gradeId="+gradeId+"&planID="+planid, null, "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.7+"px;center:center;resizable:yes;status:no;scroll:yes;");
	        return true;
        }
    </script>
</f:verbatim>
<x:saveState value="#{eva_planExecuteBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_planExecuteBB.pageInitDept}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 查看部门考核结果"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" align="center" width="98%">
        <h:dataTable value="#{eva_planExecuteBB.planList}" width="100%" var="list" align="center" id="dateList"
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
                <c:facet name="header"><h:outputText value="考核客体类型"/></c:facet>
                <h:outputText value="#{list.objectTypeDes}"/>
        </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="量表结果分析"  styleClass="button01" onclick="doSet('#{list.planId}')" rendered="#{list.evaModel=='0'&& list.planObjectType=='0'}">
                </h:commandButton>
                <h:commandButton value="量表层次分析"  styleClass="button01" onclick="doSetGrade('#{list.planId}','#{list.planGrade}')" rendered="#{list.evaModel=='0' && list.planObjectType=='0'}">
                </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>