<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function showResult(planId){
	    window.showModalDialog("/recruit/resumePostList.jsf?planId="+planId, "", "dialogHeight="+screen.height*0.8+"px; dialogWidth="+screen.width*0.8+"px; top=90;left=180; toolbar=no; menubar=no; scrollbars=yes; resizable=no;location=no; status=no");
	    return true;
   }
   function auditIv(planId){
	   window.showModalDialog("/recruit/AuditIvResume.jsf?planId="+planId, "", "dialogHeight="+screen.height*0.8+"px; dialogWidth="+screen.width*0.8+"px; top=90;left=180; toolbar=no; menubar=no; scrollbars=yes; resizable=no;location=no; status=no");
	    return true;
   }
</script>


<x:saveState value="#{recu_resumeInfoBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{recu_resumeInfoBB.initPage}"/>
    <h:panelGrid columns="1" align="center" width="98%">
         <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{recu_resumeInfoBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recu_resumeInfoBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recu_resumeInfoBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recu_resumeInfoBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{recu_resumeInfoBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recu_resumeInfoBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recu_resumeInfoBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recu_resumeInfoBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
       
        <h:dataTable value="#{recu_resumeInfoBB.planList}" width="100%" var="list" align="center" id="dateList"
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
                <h:commandButton value="简历浏览"  styleClass="button01" onclick="return showResult('#{list.planID}');">
                </h:commandButton>
                <h:commandButton value="通知面试名单审批"  styleClass="button01" onclick="return auditIv('#{list.planID}');" rendered="#{recu_resumeInfoBB.operApply}">
                </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>