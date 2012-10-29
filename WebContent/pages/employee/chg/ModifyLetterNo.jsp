<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<x:saveState value="#{emp_letterBB}"></x:saveState>
<base target="_self">
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{emp_letterBB.initEditNo}"/>
    <h:inputHidden  value="#{emp_letterBB.letterType}"/>
    <table>
    <tr><td align="right">
         <h:commandButton value="±£´æ" styleClass="button01" action="#{emp_letterBB.modiLetterNo}"/>
     </td></tr>
     <tr><td>
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2158", "Ô­±àºÅ")%>
		  	</f:verbatim>
            <h:outputText id="oldname" value="#{emp_letterBB.oldLetter}" />
             <f:verbatim>
				 <%=LanguageSupport.getResource("RYGL-2159", "ÐÂ±àºÅ")%>
		  	</f:verbatim>
            <h:inputText id="newname" value="#{emp_letterBB.newLetter}" />
       </h:panelGrid>
      </td></tr>
   </table>
</h:form>