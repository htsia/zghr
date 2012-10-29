<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
    function showResult(planId,evamodle){
        window.open("/eva/EvaResultList.jsf?planId="+planId+"&evaModle="+evamodle, "", 'height=500px, width=600px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
        return true;
    }
    function changeGrade(objId){
	    window.showModalDialog("/eva/changeGrade.jsf?objectId="+objId+"&isVittual="+document.all("form1:isVittual").value, "", "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.3+"px;center:center;resizable:no;status:no;scroll:no;");
	    return true;
   }
</script>

<x:saveState value="#{eva_resultAuditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{eva_resultAuditBB.initAudit}"></h:inputHidden>
    <h:inputHidden id="isVittual" value="#{eva_resultAuditBB.isVittual}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 审批考核结果"/>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim>
    <br>
       <table height=98% width=98% align="center">
       <tr><td width="50"></td><td height=100>
    </c:verbatim>
        <h:panelGrid columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="审批意见"/>
            <h:selectOneMenu id="status" value="#{eva_resultAuditBB.planbo.resultAuditResult}">
                <c:selectItem itemValue="1" itemLabel="同意"/>
                <c:selectItem itemValue="0" itemLabel="不同意"/>
            </h:selectOneMenu>

            <h:outputText value="说明"/>
            <h:inputTextarea value="#{eva_resultAuditBB.planbo.resultAuditExplain}" rows="3" cols="60"/>
            <h:outputText value="操作"/>
            <h:commandButton styleClass="button01" value="审批" action="#{eva_resultAuditBB.audit}"
                             onclick="return forCheck();"/>
        </h:panelGrid>
     <c:verbatim>
      </td></tr>
       <tr><td height=8 colspan="2"> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
            	<h:outputText value="姓名或简称：" rendered="#{eva_resultAuditBB.evaModel=='0'}"></h:outputText>
         		<h:inputText value="#{eva_resultAuditBB.queryValue}" styleClass="input" size="20" rendered="#{eva_resultAuditBB.evaModel=='0'}"></h:inputText>
         		<h:commandButton styleClass="button01"  value="查询" action="#{eva_resultAuditBB.queryResult}" rendered="#{eva_resultAuditBB.evaModel=='0'}"></h:commandButton>
         		<h:outputText value=" "></h:outputText>
                <h:outputText value="记录数:#{eva_resultAuditBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{eva_resultAuditBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{eva_resultAuditBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{eva_resultAuditBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{eva_resultAuditBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{eva_resultAuditBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{eva_resultAuditBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{eva_resultAuditBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	  <tr><td colspan="2">
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{eva_resultAuditBB.objectScoreList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" rendered="#{eva_resultAuditBB.evaModel=='0'||eva_resultAuditBB.evaModel=='3'}">
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="名称"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="考核类型"/></c:facet>
            <h:outputText value="量表考核"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="最后得分"/></c:facet>
            <h:outputText value="#{list.score}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumScore}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="考核等级"/></c:facet>
            <h:outputText value="#{list.gradeName}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumGrade}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="排名"/></c:facet>
            <h:outputText value="#{list.sortId}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumSort}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
             <h:commandButton value="调整等级"  styleClass="button01" onclick="changeGrade('#{list.objectID}')"/>
        </h:column>
    </x:dataTable>

  
    <x:dataTable value="#{eva_resultAuditBB.jobEstimateScoreList}" var="list" align="center" id="dateList1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" rendered="#{eva_resultAuditBB.evaModel=='1'}">
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="考核类型"/></c:facet>
            <h:outputText value="职务考核"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="最后得分"/></c:facet>
            <h:outputText value="#{list.score}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumScore}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="考核等级"/></c:facet>
            <h:outputText value="#{list.gradeName}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumGrade}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="排名"/></c:facet>
            <h:outputText value="#{list.sortId}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumSort}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
    </x:dataTable>
    
     <x:dataTable value="#{eva_resultAuditBB.masterList}" var="list" align="center" id="dateList2"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" rendered="#{eva_resultAuditBB.evaModel=='2'}">
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="最后得分"/></c:facet>
            <h:outputText value="#{list.score}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumScore}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="考核等级"/></c:facet>
            <h:outputText value="#{list.gradeName}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumGrade}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="排名"/></c:facet>
            <h:outputText value="#{list.sortId}" rendered="#{eva_resultAuditBB.isVittual=='0'}"/>
            <h:outputText value="#{list.sumSort}" rendered="#{eva_resultAuditBB.isVittual=='1'}"/>
        </h:column>
    </x:dataTable>
	<c:verbatim>
	</div>
	</td></tr>
	<tr><td height="10">&nbsp;</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>