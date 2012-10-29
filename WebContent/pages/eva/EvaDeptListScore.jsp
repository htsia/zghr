<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
          function inputScore(id){
        	 window.showModalDialog("/eva/InputDeptScore.jsf?objectID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.8+"px;resizable:yes;status:yes;scroll:yes;");
        	 return false;
          }
    </script>

<x:saveState value="#{evaDeptSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaDeptSetBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{evaDeptSetBB.planId}"></h:inputHidden>
    <h:inputHidden id="orgId" value="#{evaDeptSetBB.orgId}"></h:inputHidden>
    <h:inputText id="deptIds" value="#{evaDeptSetBB.deptIds}" style="display:none;" code="" dict="yes" dict_num="OU"></h:inputText>
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 绩效管理-> 部门考核打分</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
         
          <h:panelGrid align="right" columns="2">
          		
             	<h:panelGroup>
                <h:outputText value="记录数:#{evaDeptSetBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{evaDeptSetBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{evaDeptSetBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{evaDeptSetBB.pagevo.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{evaDeptSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{evaDeptSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{evaDeptSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{evaDeptSetBB.last}" styleClass="button01"></h:commandButton>
         </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{evaDeptSetBB.objectList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="部门名称"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属机构"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="模板名称"/></c:facet>
            <h:outputText value="#{list.templateName}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="打分" onclick="inputScore('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
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
