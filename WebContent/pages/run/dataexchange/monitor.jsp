<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
</script>

<x:saveState value="#{DaexMonitorMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{DaexMonitorMgrBB.pageInit}"/>
    <h:inputHidden id="personStr" value=""/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 数据交换平台 -> 运行监控"/>
     <f:verbatim>
               </td>
               <td align="right" class=td_title >
               </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="right">       
            </td>
            <td align="right">
</f:verbatim>
				<h:panelGroup>
                <h:outputText value="记录数:#{DaexMonitorMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{DaexMonitorMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{DaexMonitorMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{DaexMonitorMgrBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{DaexMonitorMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{DaexMonitorMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{DaexMonitorMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{DaexMonitorMgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{DaexMonitorMgrBB.logList}" var="list" align="center"  id="dateList" rowIndexVar="index"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            
            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="对应产品"/></c:facet>
                <h:outputText value="#{list.stockId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="对应系统"/></c:facet>
                <h:outputText value="#{list.sysId}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="时间"/></c:facet>
                <h:outputText value="#{list.actionDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:outputText value="#{list.actionDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作结果"/></c:facet>
                <h:outputText value="#{list.actionResultDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="失败原因"/></c:facet>
                <h:outputText value="#{list.errMsg}"/>
            </h:column>
        </x:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>