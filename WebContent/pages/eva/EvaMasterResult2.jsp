<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
 <script type="text/javascript">
 function queryMaster(objId){
     window.showModalDialog("/eva/queryMasterList.jsf?objectID="+objId,"", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:yes;scroll:yes;");
     return true;
 }
 </script>
<x:saveState value="#{evaobjectScoreListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaobjectScoreListBB.pageInit}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <%
       		String planId=(String)session.getAttribute("planId");
       %>
       <tr>
       			<td align="center" width="16%" class=activeTab><a href="EvaMasterResult2.jsf?planId=<%=planId%>">打分汇总情况</a></td>
                <td align="center" width="16%" class=tab><a href="evaObjectScoreList.jsf?planId=<%=planId%>">打分明细情况</a></td>
      </tr>
       <tr><td height=8 colspan="2"> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
    	<h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="姓名或员工编号"></h:outputText>
                <h:inputText id="condiValue" styleClass="input" value="#{evaobjectScoreListBB.condiValue}" size="20"></h:inputText>
                <h:commandButton id="btnSearch" value="查 询"  styleClass="button01" action="#{evaobjectScoreListBB.doQuery}"/>
                 <h:outputText value="  "></h:outputText>
                <h:outputText value="记录数:#{evaobjectScoreListBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{evaobjectScoreListBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{evaobjectScoreListBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{evaobjectScoreListBB.pagevo.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{evaobjectScoreListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{evaobjectScoreListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{evaobjectScoreListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{evaobjectScoreListBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td colspan="2">
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{evaobjectScoreListBB.objectList}" var="list" align="center" id="dateList"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="机构"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="客体名称"/></c:facet>
            <h:outputText value="#{list.objectName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="主体总数"/></c:facet>
            <h:outputText value="#{list.totalRecord}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="打分人数"/></c:facet>
            <h:outputText value="#{list.hasScoreCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="未打分人数"/></c:facet>
            <h:outputText value="#{list.notScoreCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
           <h:commandButton value="详细信息"  styleClass="button01" onclick="queryMaster('#{list.objectId}')"></h:commandButton>
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
