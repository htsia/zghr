<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addPlan(){
             window.showModalDialog("/employee/abroad/deptPlanEdit.jsf?superId=new", "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/employee/abroad/deptPlanEdit.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
            return true;
        }
        function query(id){
            window.showModalDialog("/employee/abroad/deptPlanDetial.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
            return true;
        }
        function selectPerson(id){
        	 window.showModalDialog("/employee/abroad/selectPersonList.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:400px; status:0;resizable:yes");
             return true;
        }
    </script>

<x:saveState value="#{deptAboardListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{deptAboardListBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 
               <%=LanguageSupport.getResource("RYGL-1330", " 出国管理  ")%> ->
               <%=LanguageSupport.getResource("RYGL-1334", " 部门出访计划")%>   
             </td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{deptAboardListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{deptAboardListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{deptAboardListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{deptAboardListBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{deptAboardListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{deptAboardListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{deptAboardListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{deptAboardListBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addPlan();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{deptAboardListBB.planList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划类型"/></c:facet>
            <h:outputText value="#{list.planTypeDes}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="计划时间"/></c:facet>
            <h:outputText value="#{list.planDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="出访国家"/></c:facet>
            <h:outputText value="#{list.country}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="开始日期"/></c:facet>
            <h:outputText value="#{list.beginDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束日期"/></c:facet>
            <h:outputText value="#{list.endDate}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="客户"/></c:facet>
            <h:outputText value="#{list.costomer}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="预算"/></c:facet>
            <h:outputText value="#{list.budget}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="制定人"/></c:facet>
            <h:outputText value="#{list.maker}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="制定时间"/></c:facet>
            <h:outputText value="#{list.makDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
       
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.planId}')" styleClass="button01" rendered="#{list.isExecute=='0'}"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{deptAboardListBB.delete}" styleClass="button01" rendered="#{list.isExecute=='0'}">
                  <x:updateActionListener property="#{deptAboardListBB.planId}" value="#{list.planId}"/>
            </h:commandButton>
            <h:commandButton value="编辑人员" onclick="return selectPerson('#{list.planId}')" styleClass="button01" ></h:commandButton>
            <h:commandButton value="查看" onclick="return query('#{list.planId}')" styleClass="button01"></h:commandButton>
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
