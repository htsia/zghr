<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">

</script>

<x:saveState value="#{law_browbb}"/>
<h:form id="form1">
      <h:inputHidden value="#{law_browbb.pageInit}"></h:inputHidden>
    <f:verbatim>
        <table  width=100% height=98%>
        <tr><td height=8 align="right">
   </f:verbatim>
         <h:selectBooleanCheckbox value="#{law_browbb.showAllChild}" onclick="submit();" valueChangeListener="#{law_browbb.changemode}"></h:selectBooleanCheckbox><h:outputText value="显示下级目录中文件"></h:outputText>
    <f:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </f:verbatim>
			<x:dataTable value="#{law_browbb.lawlist}" id="dateList"  width="1000"
				headerClass="tr_fixrow td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="0"
                columnClasses="td_middle_left,td_middle,td_middle_center,td_middle_center">

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>

					<h:commandButton value="查看详细信息" styleClass="button01" type="button" onclick="return doShowLaw('#{briefList.fileID}');">
					</h:commandButton>
				</h:column>
                
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="类别" style="width:120px"/>
                    </f:facet>
                    <h:outputText value="#{briefList.typeName}" style="width:120px"></h:outputText>
                </h:column>

				<h:column>
					<f:facet name="header">
						<h:outputText value="标题" />
					</f:facet>
                    <h:outputText value="#{briefList.title}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="发布时间" style="width:100px"/>
                    </f:facet>
                    <h:outputText value="#{briefList.publicDate}" style="width:100px"></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="生效时间" style="width:100px"/>
                    </f:facet>
                    <h:outputText value="#{briefList.actDate}" style="width:100px"></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="失效时间" style="width:100px"/>
                    </f:facet>
                    <h:outputText value="#{briefList.invalidDate}" style="width:100px"></h:outputText>
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


