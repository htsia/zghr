<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function checkform() {
	return forsubmit(document.forms(0)); 	
}

function selectInfoItem() {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/wage/base/FormulaInfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        //debugger;
        document.all("form1:infoItem").value = rs[0];
        return true;
    }
    return false;
}
</script>

<x:saveState value="#{empTypeChangeBB}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{empTypeChangeBB.initOrgEdit}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<f:verbatim>
                人员类别变动关联薪资设置
            </f:verbatim>
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="98%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03" width="98%">
			<f:verbatim>
				<%=LanguageSupport.getResource("JGGL-1002",
									"机构名称 ")%>
			</f:verbatim>
			<h:inputText value="#{empTypeChangeBB.orgchangebo.orgName}"
				readonly="true"></h:inputText>
			<f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2143",
									"薪资变动相关指标项 ")%>
			</f:verbatim>

			<h:panelGrid width="98%" align="center">
				<h:panelGrid width="98%" align="right">
					<h:inputHidden id="infoItem" value="#{empTypeChangeBB.infoItem}"></h:inputHidden>
					<h:panelGroup>
						<h:commandButton value="增加"
							action="#{empTypeChangeBB.addfield}"
							onclick="return selectInfoItem();" styleClass="button01"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid>

				<h:dataTable value="#{empTypeChangeBB.baseFields}" var="list"
					align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="90%">
					<h:column>
						<c:facet name="header">
						<f:verbatim>
				               <%=LanguageSupport.getResource("XTGL-1157", "顺序 ")%>
			            </f:verbatim>
						</c:facet>
						<h:outputText value="#{list.itemSequence}" />
					</h:column>

					<h:column>
						<c:facet name="header">
						   	<f:verbatim>
				               <%=LanguageSupport.getResource("XRYGL-2047", "信息集")%>
			            </f:verbatim>
						</c:facet>
						<h:outputText value="#{list.setId}" />
					</h:column>

					<h:column>
						<c:facet name="header">
						    	<f:verbatim>
				               <%=LanguageSupport.getResource("RYGL-2048", "信息项 ")%>
			            </f:verbatim>
						</c:facet>
						<h:outputText value="#{list.itemName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
						   	<f:verbatim>
				               <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%>
			            </f:verbatim>
						</c:facet>
						<h:commandButton styleClass="button01" value="删除"
							action="#{empTypeChangeBB.delfield}" onclick="return confirm('确定删除吗');">
							<x:updateActionListener property="#{empTypeChangeBB.infoItem}"
								value="#{list.itemId}" />
						</h:commandButton>
						<h:commandButton styleClass="button01" value="上移"
							action="#{empTypeChangeBB.movePre}">
							<x:updateActionListener property="#{empTypeChangeBB.infoItem}"
								value="#{list.itemId}" />
						</h:commandButton>
						<h:commandButton styleClass="button01" value="下移"
							action="#{empTypeChangeBB.moveNext}">
							<x:updateActionListener property="#{empTypeChangeBB.infoItem}"
								value="#{list.itemId}" />
						</h:commandButton>
					</h:column>

				</h:dataTable>
			</h:panelGrid>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="保存"
				action="#{empTypeChangeBB.saveOrgTypeChangeBO}"
				styleClass="button01" onclick="checkform()" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
