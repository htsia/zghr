<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{sys_AddressBookBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{sys_AddressBookBB.editBook}"/>
    <h:inputHidden id="bookID" value="#{sys_AddressBookBB.bookbo.bookID}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
             <f:verbatim>
                     <%=LanguageSupport.getResource("JGGL-1058","名称")%> 
             </f:verbatim>
            <h:inputText id="name" value="#{sys_AddressBookBB.bookbo.bookName}" />
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{sys_AddressBookBB.save}"
                             onclick="if(forsubmit(document.forms(0))){}else{return false;}"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
