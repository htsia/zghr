<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
      	function selRole(id){
      		window.returnValue=id;
      		window.close();
      	}
    </script>

<x:saveState value="#{xys_evaRoleBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaRoleBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="roleId" value="#{xys_evaRoleBB.roleId}"></h:inputHidden>
    <h:inputHidden id="templateId" value="#{xys_evaRoleBB.templateId}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                  绩效管理 ->角色定义
           </td>
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="90%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{xys_evaRoleBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{xys_evaRoleBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{xys_evaRoleBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{xys_evaRoleBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{xys_evaRoleBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{xys_evaRoleBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{xys_evaRoleBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{xys_evaRoleBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{xys_evaRoleBB.roleList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
         <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="名称"/></c:facet>
            <h:outputText value="#{list.roleName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建机构"/></c:facet>
            <h:outputText value="#{list.createOrg}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="缺省360模版"/></c:facet>
            <h:outputText value="#{list.template360}"/>
        </h:column>
       
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="选择" onclick="selRole('#{list.roleId}')" styleClass="button01"></h:commandButton>
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
