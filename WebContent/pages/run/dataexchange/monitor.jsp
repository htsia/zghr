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
                    <h:outputText value=" ���ݽ���ƽ̨ -> ���м��"/>
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
                <h:outputText value="��¼��:#{DaexMonitorMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{DaexMonitorMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{DaexMonitorMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{DaexMonitorMgrBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{DaexMonitorMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{DaexMonitorMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{DaexMonitorMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{DaexMonitorMgrBB.last}" styleClass="button01"></h:commandButton>
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
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="��Ӧ��Ʒ"/></c:facet>
                <h:outputText value="#{list.stockId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��Ӧϵͳ"/></c:facet>
                <h:outputText value="#{list.sysId}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="ʱ��"/></c:facet>
                <h:outputText value="#{list.actionDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.actionDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.actionResultDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="ʧ��ԭ��"/></c:facet>
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