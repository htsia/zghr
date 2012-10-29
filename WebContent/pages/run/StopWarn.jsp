<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>
 
<x:saveState value="run_SystemInfoBackingBean"></x:saveState>
 <h:form id="form1">
     <h:panelGrid columns="2" width="95%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
         <h:outputText value="停机警告时间(分钟)"/>
         <h:inputText id="name" value="#{run_SystemInfoBackingBean.warnTime}" />

         <h:outputText value="预计停机时间(分钟)"/>
         <h:inputText id="desc" value="#{run_SystemInfoBackingBean.stopTime}" />

          <h:outputText value="操作"/>
          <h:panelGroup>
              <h:commandButton value="确定" styleClass="button01" action="#{run_SystemInfoBackingBean.doStop}"></h:commandButton>
              <h:commandButton value="取消" type="button" onclick="window.close()" styleClass="button01"></h:commandButton>
          </h:panelGroup>
     </h:panelGrid>

 </h:form>
