<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
	   function caclDeptKPI(id){
	        window.showModalDialog("/xys/eva/caclDeptKpi.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
	        return true;
	   }
       function caclPersKPI(id){
            window.showModalDialog("/xys/eva/caclPersonKpiIndex.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function caclPers360(id){
    	   window.showModalDialog("/xys/eva/caclPerson360Index.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.9+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       
       function caclTotal(id){
    	   window.showModalDialog("/xys/eva/caclEvaObjIndex.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.9+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       
    </script>

<x:saveState value="#{xys_evaPlanAuditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaPlanAuditBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                        绩效管理 ->结果审批
           </td>
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="显示全部"></h:outputText>
                <h:selectBooleanCheckbox value="#{xys_evaPlanAuditBB.selectAll}" onclick="submit();" valueChangeListener="#{xys_evaPlanAuditBB.queryAll}" />
                <h:outputText value="  "></h:outputText>
                <h:outputText value="记录数:#{xys_evaPlanAuditBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{xys_evaPlanAuditBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{xys_evaPlanAuditBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{xys_evaPlanAuditBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{xys_evaPlanAuditBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{xys_evaPlanAuditBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{xys_evaPlanAuditBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{xys_evaPlanAuditBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_evaPlanAuditBB.planList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="年度"/></c:facet>
            <h:outputText value="#{list.year}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="周期类型"/></c:facet>
            <h:outputText value="#{list.planType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划等级"/></c:facet>
            <h:outputText value="#{list.planGrade}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="分数保留位数"/></c:facet>
            <h:selectOneMenu value="#{list.scorePers}" disabled="true">
                <c:selectItem itemLabel="整数" itemValue="0"/>
                <c:selectItem itemLabel="一位小数" itemValue="1"/>
                <c:selectItem itemLabel="两位小数" itemValue="2"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="3">
            <h:commandButton value="部门KPI查询" onclick="caclDeptKPI('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            <h:commandButton value="个人KPI查询" onclick="caclPersKPI('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            <h:commandButton value="能力态度查询" onclick="caclPers360('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            </h:panelGrid>
            <h:panelGrid columns="3">
            <h:commandButton value="综合结果查询" onclick="caclTotal('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            <h:commandButton value="结果审批批准" styleClass="button01" action="#{xys_evaPlanAuditBB.auditOK}" rendered="#{list.status=='3'}">
            	<x:updateActionListener value="#{list.planId}" property="#{xys_evaPlanAuditBB.planId}"/>
            </h:commandButton>
            <h:commandButton value="结果审批退回" styleClass="button01" action="#{xys_evaPlanAuditBB.auditNO}" rendered="#{list.status=='3'}">
            	<x:updateActionListener value="#{list.planId}" property="#{xys_evaPlanAuditBB.planId}"/>
            </h:commandButton>
            </h:panelGrid>
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
