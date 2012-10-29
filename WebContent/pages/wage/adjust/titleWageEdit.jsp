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
<x:saveState value="#{titleChgWagemgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{titleChgWagemgrBB.pageInit1}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
            	<h:outputText value="分段计算工资："></h:outputText>
                <h:selectOneMenu value="#{titleChgWagemgrBB.isPartWage}">
                    <c:selectItem itemLabel="否" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="是" itemValue="1"></c:selectItem>
                </h:selectOneMenu>
                <h:outputText value="记录数:#{titleChgWagemgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{titleChgWagemgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{titleChgWagemgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{titleChgWagemgrBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{titleChgWagemgrBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{titleChgWagemgrBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{titleChgWagemgrBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{titleChgWagemgrBB.last1}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td height="200">
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{titleChgWagemgrBB.wageItemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="指标项"/></c:facet>
            <h:outputText value="#{list.fieldId}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="指标名称"/></c:facet>
            <h:outputText value="#{list.fieldDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="原值"/></c:facet>
            <h:outputText value="#{list.oldValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="新值"/></c:facet>
            <h:outputText value="#{list.newValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="生效时间"/></c:facet>
            <h:outputText value="#{list.updateDate}"/>
        </h:column>
    </x:dataTable>

	<c:verbatim>
	</div>
	</td></tr>
	<tr>
		<td align="right">
	</c:verbatim>
		<h:commandButton value="生效" styleClass="button01" action="#{titleChgWagemgrBB.shengxiao}"></h:commandButton>
	<c:verbatim>	
		&nbsp;&nbsp;&nbsp;</td>
	</tr>
	</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
