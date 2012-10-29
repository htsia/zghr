<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
	
    <script type="text/javascript">
    </script>

<x:saveState value="#{wage_AdjItemListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_AdjItemListBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{wage_AdjItemListBB.adjId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 薪酬管理 -> 晋级晋档</td>
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
                <h:outputText value="记录数:#{wage_AdjItemListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{wage_AdjItemListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{wage_AdjItemListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{wage_AdjItemListBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{wage_AdjItemListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{wage_AdjItemListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{wage_AdjItemListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{wage_AdjItemListBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{wage_AdjItemListBB.adjItemList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="范围字段所对值"/></c:facet>
            <h:outputText value="#{list.scopeValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="时间字段所对值"/></c:facet>
            <h:outputText value="#{list.timeValue}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="新结果"/></c:facet>
            <h:outputText value="#{list.resultNew}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="旧结果"/></c:facet>
            <h:outputText value="#{list.resultOld}"/>
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
