<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function add() {
    window.showModalDialog("/run/dataexchange/selSendProduct.jsf?sysId="+document.all("form1:sysId").value, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
</script>

<x:saveState value="#{ReceriveProdouctMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{ReceriveProdouctMgrBB.pageInit}"/>
    <h:inputHidden id="sysId" value="#{ReceriveProdouctMgrBB.sysId}"/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 数据交换平台 -> 订阅产品"/>
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
                <h:outputText value="记录数:#{ReceriveProdouctMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{ReceriveProdouctMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{ReceriveProdouctMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{ReceriveProdouctMgrBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{ReceriveProdouctMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{ReceriveProdouctMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{ReceriveProdouctMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{ReceriveProdouctMgrBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="选择产品"  styleClass="button01" onclick="return add()"/>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{ReceriveProdouctMgrBB.receiveList}" var="list" align="center"  id="dateList" rowIndexVar="index"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            
            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="产品名称"/></c:facet>
                <h:outputText value="#{list.proName}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="产品类型"/></c:facet>
                <h:outputText value="#{list.proType}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="通知消费者信息"/></c:facet>
                <h:outputText value="#{list.sendMsg}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="接收方法"/></c:facet>
                <h:outputText value="#{list.methodDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{ReceriveProdouctMgrBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{ReceriveProdouctMgrBB.receiveId}" value="#{list.receiveId}"/>
            	</h:commandButton>
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