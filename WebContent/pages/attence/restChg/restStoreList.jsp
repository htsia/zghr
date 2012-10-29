<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>

<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<script>
       function queryOutWork() {
            window.showModalDialog("/attence/annualRuleListAdd.jsf?okID=100", null, "dialogWidth:" + screen.width * 0.2 + "px; dialogHeight:" + screen.height * 0.3 + "px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
</script>
<x:saveState value="#{attRestStoreBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="superID" value="#{attRestStoreBB.pageInit}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=100% align="center">
       <tr><td height=8 class="td_page">
    </c:verbatim>
	<h:panelGrid width="98%" columns="1" >
		<h:panelGrid columns="1" align="left" >
                        <h:panelGroup>
                            <h:outputText escape="false" value="时间： " />
				<h:inputText styleClass="input" id="beginDate" value="#{attRestStoreBB.beginTime}"
                             readonly="true" alt="开始日期|0|d|50||"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:beginDate')"></h:commandButton>
			    <h:outputText escape="false" value=" 至  " />
				<h:inputText styleClass="input" id="endDate" value="#{attRestStoreBB.endTime}"
                             readonly="true" alt="结束日期|0|d|50||"/>
                 <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:endDate')"></h:commandButton>
                <h:outputText value="  "/>
                <h:outputText value="姓名或员工编号:"></h:outputText>
                <h:inputText value="#{attRestStoreBB.personValue}" styleClass="input"></h:inputText>
                
                <h:commandButton value="查询" action="#{attRestStoreBB.doQuery}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
        <h:panelGrid columns="1" align="right">
                        <h:panelGroup>
				<h:outputText
					value="记录数:#{attRestStoreBB.mypage.totalRecord}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="页数:#{attRestStoreBB.mypage.totalPage}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText value="每页有#{attRestStoreBB.mypage.pageSize}"></h:outputText>
				<h:outputText value="  "></h:outputText>
				<h:outputText
					value="当前为第#{attRestStoreBB.mypage.currentPage}页"></h:outputText>

				<h:commandButton value="首页" action="#{attRestStoreBB.first}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="上页" action="#{attRestStoreBB.pre}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="下页" action="#{attRestStoreBB.next}"
					styleClass="button01"></h:commandButton>
				<h:commandButton value="尾页" action="#{attRestStoreBB.last}"
					styleClass="button01"></h:commandButton>
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
     <c:verbatim>
	  </td></tr>

	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	<x:dataTable value="#{attRestStoreBB.personList}" id="dateList"
		headerClass="td_fixtop" rowIndexVar="index" var="list"
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
				<h:outputText value="姓名" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.personId}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="记录类型" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.recordTypeDes}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="存休天数" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.days}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="状态" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.statusDes}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="存休日期" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.restTime}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="使用天数" styleClass="td03" />
			</f:facet>
			<h:outputText escape="false" value="#{list.useDays}" />
		</h:column>
		<h:column>
			<f:facet name="header">
				<h:outputText value="剩余天数" styleClass="td03" />
			</f:facet>
			<h:outputText value="#{list.levDays}" />
		</h:column>
        <h:column>
			<f:facet name="header">
				<h:outputText value="操作" styleClass="td03" />
			</f:facet>

			<h:commandButton action="#{attRestStoreBB.deleteOutWork}" styleClass="button01" value="置为失效">
                <x:updateActionListener property="#{attRestStoreBB.superFurloughNo}" value="#{list.outWorkCollectNo}"/>
			</h:commandButton>
            <h:commandButton value="查看公出"
						onclick="return forModify('#{list.itemID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="查看请假"
						onclick="return forModify('#{list.itemID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="查看加班"
						onclick="return forModify('#{list.itemID}')" styleClass="button01"></h:commandButton>
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






