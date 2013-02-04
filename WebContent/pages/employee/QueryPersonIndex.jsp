<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script language="javascript">
        function forAdQry(form) {
            var rel = doAdvanceQuery('A', 'ORG', '110', 'Y', '', '','N','','N');
            if (rel){
                return forsubmit(document.forms(0));
            }else{
                return false;
            }
        }
    </script>

<x:saveState value="qry_namelistBB"></x:saveState>
<h:form id="form1">
   <h:inputHidden value="#{qry_namelistBB.pageInit}"></h:inputHidden>
    <f:verbatim>
     <table width=100% border=0 id="datatable" height=100%>
         <tr><td height=8>
</f:verbatim>
             <h:panelGrid width="95%" columns="1" border="0" align="center" cellpadding="0" cellspacing="0">
                 <h:panelGroup>
                   <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2419","人员名单 ")%>
                   </f:verbatim>
                     <h:selectOneMenu id="mType" value="#{qry_namelistBB.listID}">
                         <f:selectItems value="#{qry_namelistBB.nameList}"/>
                     </h:selectOneMenu>
                     <h:outputText value="   "/>
                      <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2420","查询条件 ")%>=>
                   </f:verbatim>
                     <h:commandButton value="查询" styleClass="button01" onclick="return forAdQry(document.forms(0))"
                                      action="#{qry_namelistBB.queryPersonList}"/>
                 </h:panelGroup>
             </h:panelGrid>
  <f:verbatim>
         </td></tr>
         <tr><td valign="top" height="400"><div style='width:100%;height:100%;overflow:auto' id=datatable>
                 <jsp:include page="/pages/employee/QueryPersonList.jsp"></jsp:include></div>
         </td></tr>
    </table>
    </f:verbatim>
</h:form>
