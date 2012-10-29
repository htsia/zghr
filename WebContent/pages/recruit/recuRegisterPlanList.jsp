<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function showResult(planId,planMethod,planName){
    window.open("/recruit/recuRegisterPostList.jsf?planId="+planId+"&planMethod="+planMethod+"&planName="+planName, "", 'height='+screen.height*0.6+'px, width='+screen.width*0.6+'px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
    return true;
   }
   function showResult2(planId,planMethod,planName){
	    window.open("/recruit/recuRegisterPostList2.jsf?planId="+planId+"&planMethod="+planMethod+"&planName="+planName, "", 'height='+screen.height*0.6+'px, width='+screen.width*0.6+'px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	    return true;
	   }
  
</script>
<c:verbatim><base target="_self"></c:verbatim>

<x:saveState value="#{recu_registerManageBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{recu_registerManageBB.initPage}"/>
    <h:panelGrid columns="1" align="center" width="98%">
        <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{recu_registerManageBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recu_registerManageBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recu_registerManageBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recu_registerManageBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{recu_registerManageBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recu_registerManageBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recu_registerManageBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recu_registerManageBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
       
        <h:dataTable value="#{recu_registerManageBB.planList}" width="100%" var="list" align="center" id="dateList"
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
                <h:commandButton value="通知报道"  styleClass="button01" onclick="return showResult('#{list.planID}','#{list.planMethod}','#{list.planName}');">
                </h:commandButton>
                <h:commandButton value="报道处理"  styleClass="button01" onclick="return showResult2('#{list.planID}','#{list.planMethod}','#{list.planName}');">
                </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>