<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function keySet(id) {
            window.showModalDialog("/xys/eva/SetDeptObjKeyLib.jsf?objId="+id, null, "dialogWidth:"+screen.width*0.9+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
     }
</script>
<x:saveState value="#{xys_KpiPersonSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_KpiPersonSetBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{xys_KpiPersonSetBB.superId}"></h:inputHidden>
     <h:inputHidden id="planId" value="#{xys_KpiPersonSetBB.planId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="3">
		  <h:panelGrid align="center">
		  <h:panelGroup>
                  <h:outputText value="姓名或员工编号:"></h:outputText>
                  <h:inputText value="#{xys_KpiPersonSetBB.queryValue}" styleClass="input"></h:inputText>
                  <h:commandButton value="查询" action="#{xys_KpiPersonSetBB.doQuery}" styleClass="button01"></h:commandButton>
              </h:panelGroup>
		  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{xys_KpiPersonSetBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{xys_KpiPersonSetBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{xys_KpiPersonSetBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{xys_KpiPersonSetBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{xys_KpiPersonSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{xys_KpiPersonSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{xys_KpiPersonSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{xys_KpiPersonSetBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_KpiPersonSetBB.objList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
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
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="指标状态"/></c:facet>
            <h:selectOneMenu value="#{list.keyStatus}" disabled="true">
                 <c:selectItem itemLabel="新增" itemValue="1"/>
                 <c:selectItem itemLabel="报批" itemValue="2"/>
                 <c:selectItem itemLabel="批准" itemValue="3"/>
                 <c:selectItem itemLabel="退回" itemValue="F"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
             <h:commandButton value="指标设置" onclick="return keySet('#{list.objId}')" styleClass="button01"></h:commandButton>
             <h:commandButton value="删除" action="#{xys_KpiPersonSetBB.deleteObj}" onclick="return confirm('确实要删除指定被考核人员吗？');"
                               styleClass="button01" rendered="#{list.keyStatus=='1'||list.keyStatus=='2'||list.keyStatus=='F'}">
                   <x:updateActionListener property="#{xys_KpiPersonSetBB.objId}" value="#{list.objId}"/>
            </h:commandButton>
            <h:commandButton value="退回修改" action="#{xys_KpiPersonSetBB.refuseObj}" onclick="return confirm('确实要退回指定被考核人员的指标吗？');"
                               styleClass="button01" rendered="#{list.keyStatus=='3'}">
                   <x:updateActionListener property="#{xys_KpiPersonSetBB.objId}" value="#{list.objId}"/>
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
