<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    	function add(){
    		window.showModalDialog("/xys/eva/DeptKpiDivEdit.jsf?objId="+document.all("form1:objId").value, null, "dialogWidth:"+screen.width*0.4+"px;dialogHeight:"+screen.height*0.3+"px;center:center;resizable:no;status:no;scroll:yes;");
    	    return true;
    	}
    </script>

<x:saveState value="#{xys_deptKpiDivMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_deptKpiDivMgrBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="objId" value="#{xys_deptKpiDivMgrBB.objId}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title" height="10px"><img src="/images/tips.gif">
                      绩效管理 ->部门KPI分解
           </td>
        </tr>
    </table>
    <br>
       <table height=90% width=100% align="center">
       <tr><td height=8 align="right">
       </c:verbatim>
   			<h:commandButton value="增加人员" onclick="add()" styleClass="button01" rendered="#{xys_deptKpiDivMgrBB.deptDesabled=='0'}"></h:commandButton>
       <c:verbatim>
      &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{xys_deptKpiDivMgrBB.divList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
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
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="权重"/></c:facet>
            <h:outputText value="#{list.weight}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="删除" action="#{xys_deptKpiDivMgrBB.deleteDiv}" styleClass="button01" onclick="return confirm('确实删除选中项吗！');" rendered="#{xys_deptKpiDivMgrBB.deptDesabled=='0'}">
            	<x:updateActionListener value="#{list.divId}" property="#{xys_deptKpiDivMgrBB.divId}"></x:updateActionListener>
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
