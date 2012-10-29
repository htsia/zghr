<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ include file="/pages/include/taglib.jsp"%>

<script type="text/javascript">
    function modifyInfo(id){
        window.showModalDialog("/system/wfInfoEdit.jsf?defid="+id, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function addFlow(){
        window.showModalDialog("/system/wfInfoEdit.jsf", null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function noFlowSet(){
        window.showModalDialog("/system/ExcludeFlowList.jsf", null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function configWorkFlow(id){
        window.showModalDialog("/system/workFlowEdit.jsf?id="+id, null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function viewFlow(){
        window.showModalDialog("/system/viewWorkFlow.jsf?Init=true", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
</script>
<x:saveState value="#{sys_workflowcfgBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden id="initListFlow"	value="#{sys_workflowcfgBB.initListFlow}" />
	<c:verbatim>
		<table height="96%" width="99%" align="center">
			<tr>
				<td height=8><strong><%=LanguageSupport.getResource("XTGL-1028", "当前机构:")%></strong>
					</c:verbatim> <h:outputText value="#{sys_workflowcfgBB.orgName}"></h:outputText>
					<c:verbatim>
				</td>

				<td height=8 align="right"></c:verbatim>
                        <h:selectOneMenu onchange="disPlayProcessBar();submit();" value="#{sys_workflowcfgBB.typeid}">
                               <c:selectItems value="#{sys_workflowcfgBB.flowtypeList}"></c:selectItems>
                        </h:selectOneMenu>
                        <h:commandButton value="监控" onclick="return viewFlow();" styleClass="button01" type="button"></h:commandButton>
                        <h:commandButton value="增加" onclick="return addFlow();" styleClass="button01"></h:commandButton>
                        <h:commandButton value="不走流程设置" type="button" onclick="return noFlowSet();" styleClass="button01"></h:commandButton>
                    <c:verbatim>
				</td>
			</tr>

			<tr>
				<td colspan="2" valign="top">
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<x:dataTable value="#{sys_workflowcfgBB.flowlist}" var="list"
							align="center" id="dateList" rowIndexVar="index"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="100%">
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1029","序号")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

							<h:column >
								<c:facet name="header" >
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("JGGL-1058","名称")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.defName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1030","是否启用")%>  
                                   </f:verbatim>
								</c:facet>
								<h:selectOneRadio value="#{list.isuse}" disabled="true">
									<c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
									<c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
								</h:selectOneRadio>
							</h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1031","适用机构")%>  
                                   </f:verbatim>
								</c:facet>
								<h:selectOneMenu value="#{list.orguid}" disabled="true">
									<c:selectItems value="#{sys_workflowcfgBB.orgList}"></c:selectItems>
								</h:selectOneMenu>
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1032","适用部门")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.deptiDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1033","适用条件")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.applyDes}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
                                   </f:verbatim>
								</c:facet>
								<h:commandButton value="修改属性" styleClass="button01"
									onclick="return modifyInfo('#{list.defID}')" />
								<h:commandButton value="配置节点" styleClass="button01"
									type="button" onclick="configWorkFlow('#{list.defID}')" />
							</h:column>
						</x:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
