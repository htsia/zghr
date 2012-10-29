<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function keySet(id) {
            window.showModalDialog("/xys/eva/ScoreCtrEdit.jsf?ctrId="+id, null, "dialogWidth:"+screen.width*0.4+"px;dialogHeight:"+screen.height*0.3+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
     }
</script>
<x:saveState value="#{being_gradeErrorMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{being_gradeErrorMgrBB.pageInit}"></h:inputHidden>
     <h:inputHidden id="planId" value="#{being_gradeErrorMgrBB.planId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
     </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                
                <h:outputText value="记录数:#{being_gradeErrorMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{being_gradeErrorMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{being_gradeErrorMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{being_gradeErrorMgrBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{being_gradeErrorMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{being_gradeErrorMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{being_gradeErrorMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{being_gradeErrorMgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{being_gradeErrorMgrBB.errorList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="错误内容"/></c:facet>
            <h:outputText value="#{list.error}"/>
        </h:column>
         
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
             <h:commandButton value="开始打分" styleClass="button01" action="#{being_gradeErrorMgrBB.beginAgain}">
             	<x:updateActionListener value="#{list.objId}" property="#{being_gradeErrorMgrBB.objId}"></x:updateActionListener>
             	<x:updateActionListener value="#{list.objType}" property="#{being_gradeErrorMgrBB.objType}"></x:updateActionListener>
             	<x:updateActionListener value="#{list.errorId}" property="#{being_gradeErrorMgrBB.errorId}"></x:updateActionListener>
             </h:commandButton>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
