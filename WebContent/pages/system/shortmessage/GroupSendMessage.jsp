<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function cancelFile(){
    	document.all("form1:excelFile").value = null ;
    }
</script>
<x:saveState value="#{sys_smEditBackingBean}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{sys_smEditBackingBean.pageInit}"></h:inputHidden>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1304", "发送人")%>:
			</f:verbatim> 
            <h:outputText id="name" value="#{sys_smEditBackingBean.sendName}" />

             <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1364", "接收群")%>:
			</f:verbatim> 
            <h:selectManyCheckbox value="#{sys_smEditBackingBean.inputList}" layout="pageDirection">
                <c:selectItems value="#{sys_smEditBackingBean.groupList}"></c:selectItems>
            </h:selectManyCheckbox>
			
			<f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1320", "附件")%>:
			</f:verbatim> 
          	<h:panelGroup>          		
          		<x:inputFileUpload styleClass="input" id="excelFile" value="#{sys_smEditBackingBean.excelFile}" storage="file" size="25" />
          		<h:outputText value=" "></h:outputText>
          		<h:commandButton value="删除" styleClass="input" onclick="cancelFile()"></h:commandButton>
          	</h:panelGroup>
          	
            <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1111", "内容")%>:
			</f:verbatim> 
            <h:inputTextarea id="content" value="#{sys_smEditBackingBean.sbo.content}" cols="60" rows="10"/>

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="发送" action="#{sys_smEditBackingBean.saveGroup}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>

        </h:panelGrid>
    </h:panelGrid>
</h:form>