<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ include file="/pages/include/taglib.jsp"%>

<script type="text/javascript">
    function addDefine(){
        window.showModalDialog("/system/AddExclude.jsf", null, "dialogWidth:450px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function modiDefine(id){
        window.showModalDialog("/system/AddExclude.jsf?typeid="+id, null, "dialogWidth:450px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }

</script>

<x:saveState value="#{sys_workexcludeBB}"></x:saveState>
<h:form id="form1">
	<c:verbatim>
		<table height="96%" width="98%" align="center">
            <tr><td height=30 align="right">
    </c:verbatim>
                 <h:commandButton value="新增" styleClass="button01" onclick="return addDefine();" ></h:commandButton>
    <c:verbatim>
            </td></tr>

			<tr>
				<td colspan="2" valign="top">
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
   </c:verbatim>
						<x:dataTable value="#{sys_workexcludeBB.flowlist}" var="list"
							align="center" id="dateList" rowIndexVar="index"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<c:facet name="header">
								    <f:verbatim>
                  				        <%=LanguageSupport.getResource("XTGL-1029","序号")%>  
                                   </f:verbatim>
								</c:facet>
								<h:outputText value="#{index+1}" />
							</h:column>

                            <h:column>
                                <c:facet name="header">
                                    <f:verbatim>
                                          流程类别
                                   </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.typeName}" />
                            </h:column>

                            <h:column>
                                <c:facet name="header">
                                    <f:verbatim>
                                          排除机构
                                   </f:verbatim>
                                </c:facet>
                                <h:outputText value="#{list.orgname}" />
                            </h:column>

							<h:column>
								<c:facet name="header">
								 <f:verbatim>
                  				        <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
                                   </f:verbatim>
								</c:facet>
								<h:commandButton value="修改"  styleClass="button01" onclick="modiDefine('#{list.typeID}')">
                                </h:commandButton>
                                <h:commandButton value="删除"  styleClass="button01" onclick="return confirm('确定要删除吗？')">
                                </h:commandButton>
							</h:column>
						</x:dataTable>
						<c:verbatim>
					</div>
                  </td>
			</tr>
        </table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>