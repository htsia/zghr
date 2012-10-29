<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function cancelFile(){
		document.all("BulletinEditForm:excelFile").value = null;
	}
</script>
<x:saveState value="#{sys_forumEditBB}"/>
	<h:form id="BulletinEditForm" enctype="multipart/form-data">
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                 <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1318","提出问题")%>  
                 </f:verbatim>
           </h:panelGroup>
       </h:panelGrid>
        <f:verbatim>
            <br>
        </f:verbatim>
        <h:panelGrid border="0" columns="2" align="center" cellspacing="2" width="95%" cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
            <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1319","问题")%>  
            </f:verbatim>
			<h:inputTextarea value="#{sys_forumEditBB.uqbo.subject}" rows="5" cols="100"/> 

             <f:verbatim>
                  <%=LanguageSupport.getResource("XTGL-1320","附件")%>  
            </f:verbatim>         	
			<h:panelGroup>
				<x:inputFileUpload styleClass="input" id="excelFile" value="#{sys_forumEditBB.excelFile}" storage="file" size="25" />
				<h:outputText value=""></h:outputText>
				<h:commandButton value="删除" styleClass="button01" onclick="cancelFile();"></h:commandButton>	
			</h:panelGroup>	           		
		</h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>

        <h:panelGrid border="0" columns="2" cellpadding="2" align="right">
			<h:commandButton value="保存" action="#{sys_forumEditBB.save}" styleClass="button01" />
			<h:commandButton value="返回" onclick="window.close();" styleClass="button01" type="button"/>
		</h:panelGrid>
	</h:form>


