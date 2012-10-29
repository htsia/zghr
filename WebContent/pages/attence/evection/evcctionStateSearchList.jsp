<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script>

    function addMore(){
        window.showModalDialog("/attence/evection/evcctionStateAdd.jsf","","dialogWidth:600px; dialogHeight:400px; status:0;resizable:yes");
        return true;
    }

</script>
<x:saveState value="#{evcctionStateSearchBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{evcctionStateSearchBB.pageInit}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=100% align="center">
       <tr><td height=8 class="td_page">
    </c:verbatim>
	<h:panelGrid width="98%" columns="1">
		<h:panelGrid columns="1" >

                        <h:panelGroup>
                            <h:outputText escape="false" value="时间： " />
				<h:inputText styleClass="input" id="beginTime" size="30"
					alt="起始日期|0|d" value="#{evcctionStateSearchBB.beginTime}"
				    readonly="true" onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:beginTime'})"/>

			<h:outputText escape="false" value=" 至  " />
				<h:inputText styleClass="input" id="endTime" alt="结束日期|0|d"
					size="30" value="#{evcctionStateSearchBB.endTime}" readonly="true" onclick="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true,el:'form1:endTime'})"/>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="姓名或员工编号"></h:outputText>
                <h:inputText value="#{evcctionStateSearchBB.personValue}" styleClass="input"></h:inputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="岗位名称："></h:outputText>
                <h:inputText value="#{evcctionStateSearchBB.postName}" styleClass="input"></h:inputText>
                <h:commandButton value="查询" action="#{evcctionStateSearchBB.seePersonAddWorkMessage}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>

		</h:panelGrid>
        <h:panelGrid columns="1"  align="right">
                        <h:panelGroup>
				<h:outputText
					value="记录数:#{evcctionStateSearchBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{evcctionStateSearchBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{evcctionStateSearchBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="当前为第#{evcctionStateSearchBB.mypage.currentPage}页"></h:outputText>

				<h:commandButton value="首页" action="#{evcctionStateSearchBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{evcctionStateSearchBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{evcctionStateSearchBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{evcctionStateSearchBB.last}"
					styleClass="button01"></h:commandButton>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="增加" styleClass="button01" style="button" onclick="addMore();"></h:commandButton>
			</h:panelGroup>

		</h:panelGrid>
	</h:panelGrid>
      <c:verbatim>
	  </td></tr>

	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	<x:dataTable value="#{evcctionStateSearchBB.persBos}" id="dateList"
		headerClass="td_top tr_fixrow" rowIndexVar="index" var="list"
		styleClass="table03" border="1" width="100%"
		columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center">
		<h:column>
			<c:facet name="header">
				<h:outputText value="序号" />
			</c:facet>
			<h:outputText value="#{index+1}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="出差人" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.personName}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="计算时间" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.caclDate}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="开始时间" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.beginTime}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="结束时间" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.endTime}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="天数" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.lastDate}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="事由" styleClass="td03" />
			</f:facet>
			<h:outputText escape="false" value="#{list.reason}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="目的地" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.dest}" />
		</h:column>
        <h:column>
			<f:facet name="header">
				<h:outputText value="编辑" styleClass="td03" />
			</f:facet>

			<h:commandButton action="#{evcctionStateSearchBB.deleteEvcction}" styleClass="button01" value="删除">
                <x:updateActionListener property="#{evcctionStateSearchBB.evcctionCollectNo}" value="#{list.evcctionCollectNo}"/>
			</h:commandButton>
		</h:column>
	</x:dataTable>
     <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
	setDataTableOver("form1:dateList");
</script>






