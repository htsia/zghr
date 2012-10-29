<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function forsel(){
	    var item = document.getElementsByName("selectItem");
        var selId="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	selId+=item[i].value+",";    
                }
            }
        }
        if(selId==""){
        	alert("请选择考勤机");
        	return false;
        }
        window.returnValue = selId;
        window.close();
        return false;
	}
</script>
<x:saveState value="#{attMachineMgrBB}"></x:saveState>
<h:inputHidden value="#{attMachineMgrBB.pageInit}"/>
<h:form id="form1">
	<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 考勤管理-> 选择考勤机</td>
        </tr>
    </table>
		<table height=98% width=98% align="center">
			<tr>
				<td height=8></c:verbatim> <br />
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="right" columns="2">
						<h:panelGroup>
							<h:outputText
								value="记录数:#{attMachineMgrBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="页数:#{attMachineMgrBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="每页有#{attMachineMgrBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="当前为第#{attMachineMgrBB.mypage.currentPage}页"></h:outputText>

							<h:commandButton value="首页"
								action="#{attMachineMgrBB.first}" styleClass="button01"></h:commandButton>
							<h:commandButton value="上页"
								action="#{attMachineMgrBB.pre}" styleClass="button01"></h:commandButton>
							<h:commandButton value="下页"
								action="#{attMachineMgrBB.next}" styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页"
								action="#{attMachineMgrBB.last}" styleClass="button01"></h:commandButton>
							<h:outputText value="  "/>
							<h:commandButton value=" 选择  " onclick="return forsel();" styleClass="button01"/>
						</h:panelGroup>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{attMachineMgrBB.list}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">

					<h:column>
				        <f:facet name="header">
				            <f:verbatim escape="false">
				                <input type="checkbox" name="all"
				                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
				            </f:verbatim>
				        </f:facet>
				        <f:verbatim escape="false">
				            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim><h:outputText value="#{list.machineIP}"/><f:verbatim escape="false">"/></div></f:verbatim>
				    </h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤机名称" />
						</c:facet>
						<h:outputText value="#{list.machineName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤机IP" />
						</c:facet>
						<h:outputText value="#{list.machineIP}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="安装位置" />
						</c:facet>
						<h:outputText value="#{list.machinePlace}" />
					</h:column>
					
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
</body>
