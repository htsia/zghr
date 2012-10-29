<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
</script>
<c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{emptitleauditgroupmgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emptitleauditgroupmgrBB.initPersonList}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{emptitleauditgroupmgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{emptitleauditgroupmgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{emptitleauditgroupmgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{emptitleauditgroupmgrBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{emptitleauditgroupmgrBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{emptitleauditgroupmgrBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{emptitleauditgroupmgrBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{emptitleauditgroupmgrBB.last1}" styleClass="button01"></h:commandButton>
	            <h:outputText value=" "></h:outputText>
	            <h:commandButton value="增加"  onclick="return fPopUpBackPerTreeDlg('');" action="#{emptitleauditgroupmgrBB.addPerson}" styleClass="button01"/>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{emptitleauditgroupmgrBB.personList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="所属机构"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{emptitleauditgroupmgrBB.deleteGroupPerson}" styleClass="button01">
                  <x:updateActionListener property="#{emptitleauditgroupmgrBB.itemId}" value="#{list.itemId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>

	<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
