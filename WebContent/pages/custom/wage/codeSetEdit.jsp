<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
	function forsave(){
		var name=document.getElementById("formCodeSetEdit:setName").value;
		if(name==''){
			alert("请输入代码集名字");
			return false;
		}
		return true;
	}
</script>
<x:saveState value="#{sys_codeSetListBB}"/>
<x:saveState value="#{sys_codeSetEditBB}"/>
	<h:form id="formCodeSetEdit">
        <h:inputHidden id="pageInit" value="#{sys_codeSetEditBB.pageInit}"/>
        <h:inputHidden value="#{sys_codeSetEditBB.setId}"/>
        <h:inputHidden value="#{sys_codeSetEditBB.editStatus}"/>

        <h:panelGrid columns="1" width="97%" cellpadding="0" align="center"
			cellspacing="0" border="0" >

			<h:panelGrid columns="2" width="97%" cellpadding="0" border="1" align="center" styleClass="table03"  columnClasses="td_form01,td_form02">
                 <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1009", "代码集名称")%>
		         </f:verbatim>
				<h:inputText id="setName" value="#{sys_codeSetEditBB.cs.setName}" alt="代码集名称|0|s|50" styleClass="input" />
				 <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1006", "启用/禁用")%>
		         </f:verbatim>
				<h:selectOneRadio value="#{sys_codeSetEditBB.cs.setStatus}">
					<f:selectItem itemValue="1" itemLabel="启用" />
					<f:selectItem itemValue="0" itemLabel="禁用" />
				</h:selectOneRadio>

                 <f:verbatim>
				   <%=LanguageSupport.getResource("XTGL-1134", "是否区间编码")%>
		         </f:verbatim>
                <h:selectOneRadio value="#{sys_codeSetEditBB.cs.scaleCode}">
                      <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                      <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                </h:selectOneRadio>
                <h:outputText rendered="#{sys_codeSetEditBB.operRight}" value="是否公共"/>
                <h:selectOneRadio value="#{sys_codeSetEditBB.cs.publicFlag}" rendered="#{sys_codeSetEditBB.operRight}">
                      <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                      <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                </h:selectOneRadio>

            </h:panelGrid>

			<f:verbatim>
				<br>
			</f:verbatim>
			<h:panelGrid columns="2" width="20%" cellpadding="0"
				align="center" border="0">
				<h:commandButton value="保 存" action="#{sys_codeSetEditBB.saveCodeSet}" onclick="return forsave();" styleClass="button01" />
				<h:commandButton value="返 回" action="setlist" styleClass="button01" >
                </h:commandButton>
            </h:panelGrid>
		</h:panelGrid>
	</h:form>
