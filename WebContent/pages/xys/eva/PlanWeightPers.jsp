<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">

      
    </script>

<x:saveState value="#{xys_PlanPostMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_PlanPostMgrBB.initPers}"></h:inputHidden>
    <h:inputHidden id="postId" value="#{xys_PlanPostMgrBB.postId}"></h:inputHidden>
     <c:verbatim>
         <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                       绩效管理 -> 查看关联人员
           </td>
        </tr>
    </table>
       <table height=90% width=98% align="center">
       <tr><td height=8>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_PlanPostMgrBB.persList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="是否排除"/></c:facet>
            <h:selectOneMenu value="#{list.isExc}" disabled="true">
            	<c:selectItem itemLabel="否" itemValue="0" />
            	<c:selectItem itemLabel="是" itemValue="1"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="排除" action="#{xys_PlanPostMgrBB.excPers}"  styleClass="button01" rendered="#{list.isExc=='0'}">
                   <x:updateActionListener property="#{xys_PlanPostMgrBB.personId}" value="#{list.personId}"/>
            </h:commandButton>
            <h:commandButton value="恢复" action="#{xys_PlanPostMgrBB.selPers}"  styleClass="button01" rendered="#{list.isExc=='1'}">
                   <x:updateActionListener property="#{xys_PlanPostMgrBB.personId}" value="#{list.personId}"/>
            </h:commandButton>
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
