<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forAdd(){
        window.showModalDialog("/user/UserPortalEdit.jsf?userId=" + document.all("form1:perid").value, "", "dialogWidth:315px; dialogHeight:170px; center:center; status:0;resizable:yes");
        return true;
    }
</script>

<x:saveState value="#{sys_portalBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_portalBB.initUser}"></h:inputHidden>
    <h:inputHidden id="perid" value="#{sys_portalBB.userId}"></h:inputHidden>
    <f:verbatim>
    <table height=98% width=98% align="center">
    <tr><td align="right" height=8>
    </f:verbatim>
        <h:commandButton value="增加" styleClass="button01" onclick="forAdd();"></h:commandButton>
   <f:verbatim> 
    </td></tr>
        
    <tr><td>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
   </f:verbatim>
       <h:dataTable value="#{sys_portalBB.powerList}" var="list" align="center"  id="dateList"
                    headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                    styleClass="table03" width="95%" >

           <h:column>
               <c:facet name="header"><h:outputText value="应用名称"/></c:facet>
               <h:outputText value="#{list.funName}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="对应用户"/></c:facet>
               <h:outputText value="#{list.linkUserID}"/>
           </h:column>


           <h:column>
               <c:facet name="header"><h:outputText value="操作"/></c:facet>
               <h:commandButton value="删除" styleClass="button01" action="#{sys_portalBB.DeleteUser}">
                   <x:updateActionListener property="#{sys_portalBB.itemID}" value="#{list.itemID}"></x:updateActionListener>
               </h:commandButton>
           </h:column>
       </h:dataTable>
   <f:verbatim>
       </div>
   </td></tr>
   </table>
   </f:verbatim> 
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>