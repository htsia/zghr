<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    </script>

<x:saveState value="#{xys_evaPlanCaclBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaPlanCaclBB.initEvaObjSelf}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{xys_evaPlanCaclBB.planId}"></h:inputHidden>
    <h:inputHidden id="itemId" value="#{xys_evaPlanCaclBB.itemId}"></h:inputHidden>
    <c:verbatim>
    <br>
       <table height=90% width=100% align="center">
       <tr><td height=8>
       </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{xys_evaPlanCaclBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{xys_evaPlanCaclBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{xys_evaPlanCaclBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{xys_evaPlanCaclBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{xys_evaPlanCaclBB.first4}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{xys_evaPlanCaclBB.pre4}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{xys_evaPlanCaclBB.next4}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{xys_evaPlanCaclBB.last4}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{xys_evaPlanCaclBB.evaObjList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
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
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="KPI"/></c:facet>
            <h:outputText value="#{list.scoreKpi}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="能力态度"/></c:facet>
            <h:outputText value="#{list.score360}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="其他"/></c:facet>
            <h:outputText value="#{list.scoreXspj}"/>
        </h:column>
              <h:column>
            <c:facet name="header"><h:outputText value="合计得分"/></c:facet>
            <h:outputText value="#{list.totalScore}"/>
        </h:column>
        
        
        <h:column>
            <c:facet name="header"><h:outputText value="部门平均"/></c:facet>
            <h:outputText value="#{list.scoreDeptAvg}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="部门还原"/></c:facet>
            <h:outputText value="#{list.scoreDeptKpiRecover}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="调整后"/></c:facet>
            <h:outputText value="#{list.adjustTotalScore}"/>
        </h:column>
  
        
        <h:column rendered="#{xys_evaPlanCaclBB.showMode=='1' }">
            <c:facet name="header"><h:outputText value="等级"/></c:facet>
            <h:outputText value="#{list.natureGrade}"/>
        </h:column>
        <h:column rendered="#{xys_evaPlanCaclBB.showMode=='2' }">
            <c:facet name="header"><h:outputText value="等级"/></c:facet>
            <h:outputText value="#{list.forceGrade}"/>
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
