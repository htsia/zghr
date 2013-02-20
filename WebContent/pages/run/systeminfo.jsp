<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="../include/taglib.jsp" %>
    <script language="javascript">
        function showVersion(){
            window.open('/run/showHRVersion.jsf', "_blank", "height=500, width=400,toolbar=no,scrollbars=no,menubar=no");
            return false;
        }
    </script>
 <h:form id="form1">
     <c:verbatim><br></c:verbatim>
     <h:panelGrid columns="2" width="60%"  columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1001","系统编号")%>  
         </f:verbatim>
         <h:outputText  value="#{run_SystemInfoBackingBean.sysNo}" />

         <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1002","系统名称")%>  
         </f:verbatim>
         <h:outputText  value="人力资源管理信息系统V4.1" />

         <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1003","系统发布号")%>  
         </f:verbatim>
         <h:panelGroup>
             <h:outputText  value="#{run_SystemInfoBackingBean.buildInfo}" />
             <h:commandButton type="button" styleClass="button01" value="详细版本" onclick="showVersion();"></h:commandButton>
         </h:panelGroup>

         <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1005","发布时间")%>
         </f:verbatim>
         <h:outputText  value="#{run_SystemInfoBackingBean.buildDate}" />

         <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1006","报表服务版本")%>
         </f:verbatim>
         <h:outputText  value="#{run_SystemInfoBackingBean.rptVersion}" />
         
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1007","要求数据库更新")%>
         </f:verbatim>
         <h:panelGroup>
            <h:graphicImage value="/images/common/unvalidate.gif" rendered="#{run_SystemInfoBackingBean.requpdateNo!=run_SystemInfoBackingBean.updateNo}"></h:graphicImage>
            <h:outputText  value="#{run_SystemInfoBackingBean.requpdateNo}" />
         </h:panelGroup>
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1008","数据库类型")%>
         </f:verbatim>
         <h:outputText  value="#{run_SystemInfoBackingBean.dbType}" />
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1009","数据库更新号")%>
         </f:verbatim>
         <h:outputText  value="#{run_SystemInfoBackingBean.updateNo}" />
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1010","应用服务器")%> 
         </f:verbatim>
         <h:outputText  value="#{run_SystemInfoBackingBean.appName}" />
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1011","运行目录")%>  
         </f:verbatim>
         <h:outputText  value="#{run_SystemInfoBackingBean.appPath}" />
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1013","错误日志")%> 
         </f:verbatim>
         <h:panelGroup>
            <c:verbatim><a href="/log/newHRExcepiton.log" target="blank"></c:verbatim><h:outputText  value="#{run_SystemInfoBackingBean.logPath}" /><c:verbatim></a></c:verbatim> 
         </h:panelGroup>
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1014","运行模式")%>  
         </f:verbatim>
         <h:panelGroup>
            <h:outputText  value="#{run_SystemInfoBackingBean.appModal}" />
            <h:commandButton  styleClass="button01" value="调试模式" rendered="#{run_SystemInfoBackingBean.appModal=='正常模式'}" action="#{run_SystemInfoBackingBean.setDebug}"></h:commandButton>
             <h:commandButton  styleClass="button01" value="正常模式" rendered="#{run_SystemInfoBackingBean.appModal=='调试模式'}" action="#{run_SystemInfoBackingBean.setNoraml}"></h:commandButton>
         </h:panelGroup>
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1017","浏览器")%>  
         </f:verbatim>
         <h:outputLabel id="brow" />
 <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1018","分辨率")%> 
         </f:verbatim>
         <h:outputLabel id="presc" />

     </h:panelGrid>
     <script type="text/javascript">
         var presc=screen.width+"*"+screen.height;
         document.all('form1:presc').innerText=presc;
         document.all('form1:brow').innerText=judgeBrowser();
     </script>

 </h:form>
