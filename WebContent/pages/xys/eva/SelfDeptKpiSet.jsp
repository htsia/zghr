<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function keySet(id) {
            window.showModalDialog("/xys/eva/SetDeptObjKeyLib.jsf?objId="+id, null, "dialogWidth:"+screen.width*0.7+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function preview(id){
            window.showModalDialog("/pages/xys/eva/PreviewDeptKpi.jsp?objId="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
        }
    </script>

<x:saveState value="#{self_DeptKpiSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{self_DeptKpiSetBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title" height="10px"><img src="/images/tips.gif">
                 绩效管理 ->部门KPI构建
           </td>
           <td class="td_title">
                </c:verbatim>
                 <h:outputText value="显示全部："/>
                 <h:selectBooleanCheckbox value="#{self_DeptKpiSetBB.selectAll}" onclick="submit();" valueChangeListener="#{self_DeptKpiSetBB.queryAll}" />
    <c:verbatim>
         &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
           </td>
        </tr>
    </table>
       <table height=90% width=100% align="center">
       <tr><td height=8>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <h:dataTable value="#{self_DeptKpiSetBB.objList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="年度"/></c:facet>
            <h:outputText value="#{list.year}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
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
              <h:commandButton value="指标设置" onclick="return keySet('#{list.objId}')" styleClass="button01" rendered="#{list.keyStatus=='1'||list.keyStatus=='F'}"></h:commandButton>
              <h:commandButton value="报批指标" action="#{self_DeptKpiSetBB.submitObj}" styleClass="button01" rendered="#{list.keyStatus=='1'||list.keyStatus=='F'}">
                   <x:updateActionListener property="#{self_DeptKpiSetBB.objId}" value="#{list.objId}"/>
              </h:commandButton>
              <h:commandButton value="预览" onclick="preview('#{list.objId}');"  type="button" styleClass="button01"></h:commandButton>
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
