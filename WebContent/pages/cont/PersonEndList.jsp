<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contPersonBB}"/>
<h:form id="form1">
    <h:inputHidden id="init_a" value="#{cont_contPersonBB.init_b}"/>
    <f:verbatim>
    <table height=100% width=100% align="center">
        <tr><td height="1">
    </f:verbatim>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 合同管理 ->  合同到期员工列表"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid  border="0"  align="center" columns="1" width="95%">
         <h:panelGrid  border="0"  cellspacing="0" align="left" columns="3" >
             <h:outputText value="姓名或员工编号："/>
             <h:inputText styleClass="input" size="20" id="personNameQry" value="#{cont_contPersonBB.personNameQry}"/>
             <h:commandButton styleClass="button01" value=" 查询 " action="#{cont_contPersonBB.doQueryEnd}"/>
         </h:panelGrid>

        <h:panelGrid align="right" styleClass="locked_top">
            <h:panelGroup>
                <h:outputText value="记录数:#{cont_contPersonBB.pagevo.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="页数:#{cont_contPersonBB.pagevo.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="每页有#{cont_contPersonBB.pagevo.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="当前为第#{cont_contPersonBB.pagevo.currentPage}页"></h:outputText>
                <h:commandButton value="首页" action="#{cont_contPersonBB.Endfirst}" styleClass="button01"></h:commandButton>
                <h:commandButton value="上页" action="#{cont_contPersonBB.Endpre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="下页" action="#{cont_contPersonBB.Endnext}" styleClass="button01"></h:commandButton>
                <h:commandButton value="尾页" action="#{cont_contPersonBB.Endlast}" styleClass="button01"></h:commandButton>
                <h:commandButton styleClass="button01" value="返回合同续签" action="cont_followSignList_jsf"/>
            </h:panelGroup>
        </h:panelGrid>
        
     </h:panelGrid>
	<f:verbatim>
		</td></tr><tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
	</f:verbatim>
    <x:dataTable value="#{cont_contPersonBB.endps}" var="list"  rowIndexVar="index" align="center"
                     headerClass="td_top" id="dateList"
                     rowClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" styleClass="table03" width="95%" border="1">
            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同编号"/></c:facet>
                <h:outputText value="#{list.contCode}"/>
            </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
            <h:outputText value="#{list.contPersonBO.personCode}"/>
        </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同开始时间"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="合同结束时间"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>
</x:dataTable>
<f:verbatim>
			</div></td></tr></table>
		</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>