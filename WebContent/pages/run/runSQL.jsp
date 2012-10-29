<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
 <h:form id="form1">
        <c:verbatim>
            <table width="80%" height="98%" align="center">
            <tr><td height="8">
        </c:verbatim>
             <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1008","数据库类型")%>  
            </f:verbatim>
              <h:outputText value="#{run_SystemInfoBackingBean.dbType}"></h:outputText>
              <h:outputText value="         "></h:outputText>
              <h:selectBooleanCheckbox value="#{run_SystemInfoBackingBean.paged}"></h:selectBooleanCheckbox>
               <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1019","分页显示")%>  
            </f:verbatim>
              <h:outputText value="         "></h:outputText>
               <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-1020","返回行数")%>  
            </f:verbatim>
              <h:inputText value="#{run_SystemInfoBackingBean.numLine}"></h:inputText>
         <c:verbatim>
            </td></tr>
            <tr><td td height="8">
        </c:verbatim>
             <h:inputTextarea value="#{run_SystemInfoBackingBean.sql}" cols="120" rows="10"></h:inputTextarea>
             <h:commandButton styleClass="button01" value="执行" action="#{run_SystemInfoBackingBean.doSql}" rendered="#{run_SystemInfoBackingBean.allowSQL}"></h:commandButton>
         <c:verbatim>
            </td></tr>

            <tr><td align="left" td height="8">
        </c:verbatim>
               <f:verbatim>
                   <%=LanguageSupport.getResource("YXGL-1021","返回信息:")%>  
            </f:verbatim>
              <h:outputText value="#{run_SystemInfoBackingBean.output}"></h:outputText>

        <c:verbatim>
        </td></tr>

        <tr><td>
            <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                <jsp:param name="para" value="true"/>
            </jsp:include>
         </td></tr>
        </table></c:verbatim>
 </h:form>
