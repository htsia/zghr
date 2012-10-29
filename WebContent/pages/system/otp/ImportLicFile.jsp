<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
</script>

<x:saveState value="#{sys_otpBB}"/>
 <h:form id="form1" enctype="multipart/form-data">
     <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" columns="1">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
               <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-0900"," 系统管理 ")%> ->
                 <%=LanguageSupport.getResource("XTGL-1338"," 导入授权文件")%> 
                 </f:verbatim>
          </h:panelGroup>
     </h:panelGrid>


        <h:panelGrid border="0" columns="2" cellpadding="8" align="right">
			<h:panelGroup>
                    <x:inputFileUpload styleClass="input" id="excelFile" value="#{sys_otpBB.excelFile}"  storage="file" size="25" />
                    <h:commandButton    value="上传"   styleClass="button01" action="#{sys_otpBB.uploadFile}"/>
            </h:panelGroup>
        </h:panelGrid>
</h:form>

