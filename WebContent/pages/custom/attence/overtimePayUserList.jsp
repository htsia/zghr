<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" contenteditable="inherit">
   function forSel() {
	 	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
	 	var type = document.all("form1:personType").value;
	 	if(type==null || type==""){
	 		return false;
	 	}
	 	return true;
   }
</script>

<x:saveState value="#{attPutoffMgrBB}"></x:saveState>
<h:inputHidden value="#{attPutoffMgrBB.overtimeInit}"></h:inputHidden>
<h:form id="form1">
	<h:inputHidden id="putoffsum" value="#{attPutoffMgrBB.putoffsum}"/>
	<h:inputHidden id="personType" value="#{attPutoffMgrBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attPutoffMgrBB.personTypeValue}"/>
    <c:verbatim>
    <div align="center">
    <font color='red'> 本页面的数据来自您对 带薪假休假管理  的 存休转工资的操作，请先将加班费转化完毕，再查看</font>
    </div>
     </c:verbatim><c:verbatim>
       <table height=100% width=100% align="center">
       <tr><td height=1>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
	    <h:panelGrid align="left" columns="1">
	       <h:panelGroup>
	       	   <h:outputText value="姓名或编号"/>
               <h:inputText value="#{attPutoffMgrBB.nameStr}" styleClass="input" size="10"/> 
               <h:commandButton styleClass="button01" value="人员类别" onclick="return forSel();" action="#{attPutoffMgrBB.doQuery}"/>
               <h:outputText value="选择月份"/>
               <h:inputText id="selectMonth" readonly="true" styleClass="input" onclick="WdatePicker({alwaysUseStartDate:true,dateFmt:'yyyy-MM'})" value="#{attPutoffMgrBB.overtimePayMonth}" />
               <h:commandButton styleClass="button01" value="查询" action="#{attPutoffMgrBB.doQuery}"/> 
               

               <h:outputText value="  "/>
	           <h:outputText value="记录数:#{attPutoffMgrBB.mypage.totalRecord}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="页数:#{attPutoffMgrBB.mypage.totalPage}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="每页有#{attPutoffMgrBB.mypage.pageSize}"></h:outputText>
		       <h:outputText value="  "></h:outputText>
		       <h:outputText value="当前为第#{attPutoffMgrBB.mypage.currentPage}页"></h:outputText>
		     		<h:commandButton value="首页" action="#{attPutoffMgrBB.first}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="上页" action="#{attPutoffMgrBB.pre}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="下页" action="#{attPutoffMgrBB.next}" styleClass="button01"></h:commandButton>
		       <h:commandButton value="尾页" action="#{attPutoffMgrBB.last}" styleClass="button01"></h:commandButton>
		      </h:panelGroup>
	    </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{attPutoffMgrBB.overtimeList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
            <h:outputText value="#{list.id}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="二级部门"/></c:facet>
            <h:outputText value="#{list.secDeptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>        
        <h:column>
            <c:facet name="header"><h:outputText value="月份"/></c:facet>
            <h:outputText value="#{list.yearMonth}"/>
        </h:column>  
        <h:column>
            <c:facet name="header"><h:outputText value="加班小时数"/></c:facet>
            <h:outputText value="#{list.overtimeHours}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="加班费"/></c:facet>
            <h:outputText value="#{list.overtimePay}"/>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
