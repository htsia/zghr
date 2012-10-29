<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script language="javascript">
        function powerSet(id){
            window.showModalDialog("/system/powerSet.jsf?nodeid="+id, null, "dialogWidth:700px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function addNode(){
            window.showModalDialog("/system/wfNodeEdit.jsf?defid="+document.all('form1:defid').value, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function modeNode(id){
            window.showModalDialog("/system/wfNodeEdit.jsf?nodeid="+id, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function cfgTrans(id){
            window.showModalDialog("/system/cfgNodeTrans.jsf?nodeid="+id, null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{sys_workflowcfgBB}" />
<h:form id="form1">
	<h:inputHidden value="#{sys_workflowcfgBB.initNode}" />
	<h:inputHidden id="defid" value="#{sys_workflowcfgBB.defid}" />
	<f:verbatim>
		<table height=98% width=98%>
			<tr>
				<td height=8 align="left">
                   <jsp:include	page="/pages/system/workflow/workflowChart.jsp"></jsp:include>
                </td>
			</tr>

			<tr>
				<td height=8 align="right"><input
					value="<%=LanguageSupport.getResource("XTGL-1139", "增加节点")%>"
					type="button" onclick="addNode();document.all('form1').submit();"
					class="button01"></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable styleClass="table03" align="center" width="95%"
							id="dateList" headerClass="tr_fixrow td_top"
							columnClasses="td_middle_center,td_middle,td_middle"
							value="#{sys_workflowcfgBB.nodeList}" var="list" border="0">
							<h:column>
								<f:facet name="header">
								    <f:verbatim>
								        <font  class="td03">
								        <%=LanguageSupport.getResource("XTGL-1140", "节点序号")%>
								        </font>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.seq}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								     <f:verbatim>
								        <font  class="td03">
								        <%=LanguageSupport.getResource("XTGL-1141", "节点名称")%>
								        </font>
								    </f:verbatim>
								</f:facet>
								<h:outputText value="#{list.nodeName}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								     <f:verbatim>
								        <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
								    </f:verbatim>      
								</f:facet>
								<h:commandButton value="删除" styleClass="button01"
									action="#{sys_workflowcfgBB.deleteNode}"
									rendered="#{list.nodeType=='M'}">
									<x:updateActionListener property="#{sys_workflowcfgBB.nodeid}"
										value="#{list.nodeID}"></x:updateActionListener>
								</h:commandButton>
								<h:commandButton value="基本属性" styleClass="button01"
									onclick="return modeNode('#{list.nodeID}')"></h:commandButton>
								<h:commandButton value="权限配置" type="button"
									styleClass="button01"
									onclick="return powerSet('#{list.nodeID}')"></h:commandButton>
								<h:commandButton value="转向配置" styleClass="button01"
									onclick="return cfgTrans('#{list.nodeID}')"></h:commandButton>
							</h:column>

						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
    setDataTableOver("form1:dateList");
</script>
