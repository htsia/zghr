<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function show(id) {
	window.open('/pages/run/dataexchange/showProduct.jsp?receiveId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
}
function modify(id){
	window.showModalDialog("/run/dataexchange/uploadProduct.jsf?proId="+id, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}

</script>

<x:saveState value="#{daexloginBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{daexloginBB.pageInit}"/>
	<f:verbatim>
		<table width="100%" height="100%">
			<tr>
				<td colspan="3" height="58">
				 <table width="100%" border="0" cellpadding="0" cellspacing="0" background="../../images/maininterface/hd_top.jpg" style="backgroud:#1F93B8">
        <tr>
            <td width="40" height="58">&nbsp;</td>
            <td  width="40%"><img src="../../images/maininterface/logo.jpg" align="left" alt="" height="58" valign="top">
                <span style="font-size:30px; color:#ffffff; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px; width:320px;"></span>
           </td>
            <td align="right" >
                 <table height="58" width="100" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="top" width="81"></td>
                    <td valign="top" width="69">
                   </td>
                    <td valign="top" width="69"></td>
                  </tr>
                </table>
            </td>
       </tr>
      </table>
			</td>
			</tr>
			<tr>
				<td colspan="3" height="10" valign="top">
				 <table width="100%" border="0" cellpadding="0" cellspacing="0" background="../../images/maininterface/hd_nav_unsel.gif">
          <tr>
            <td width="20" height="30">&nbsp;</td>
            <td ><img src="../../images/maininterface/menu/web-server.gif" align="absmiddle"> &nbsp;欢迎使用数据交换平台</td>
             <td width="20" height="30">&nbsp;</td>
             <td >
             </td>

            <td align="right" class="F02"></td>
            <td width="14" class="F02"></td>
          </tr>
        </table>
				
				</td>
			</tr>
			<tr>
				<td width="49%">
					<table height=96% width=100%>
     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="right">       
            </td>
            <td align="right">
</f:verbatim>
				<h:panelGroup>
                <h:outputText value="记录数:#{daexloginBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{daexloginBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{daexloginBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{daexloginBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{daexloginBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{daexloginBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{daexloginBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{daexloginBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{daexloginBB.sendList}" var="list" align="center"  id="dateList" rowIndexVar="index"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="98%" >
            
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
                <h:outputText value="#{list.protype}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="产生方法"/></c:facet>
                <h:outputText value="#{list.methodDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="通知消费者信息"/></c:facet>
                <h:outputText value="#{list.sendMsg}"/>
            </h:column>
            <h:column >
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="上传" styleClass="button01" onclick="return modify('#{list.proId}');"/>
            </h:column>
        </x:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
				</td>
				<td width="2%">&nbsp;</td>
				<td width="49%">
				<table height=96% width=100%>
     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="right">       
            </td>
            <td align="right">
</f:verbatim>
				<h:panelGroup>
                <h:outputText value="记录数:#{daexloginBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{daexloginBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{daexloginBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{daexloginBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{daexloginBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{daexloginBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{daexloginBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{daexloginBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{daexloginBB.receiveList}" var="list" align="center"  id="dateList2" rowIndexVar="index"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="98%" >
            
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
                <h:commandButton value="下载"  action="#{daexloginBB.downLoad}" styleClass="button01">
                  <x:updateActionListener property="#{daexloginBB.receiveId}" value="#{list.receiveId}"/>
           		</h:commandButton>
           		<h:commandButton value="查看" styleClass="button01" onclick="return show('#{list.receiveId}');"/>
            </h:column>
        </x:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
   setDataTableOver("form1:dateList2");
</script>