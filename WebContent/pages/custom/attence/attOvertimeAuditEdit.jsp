<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <script type="text/javascript">
  //��֤����ԭ���Ƿ����
  function check(){
	  var reason=document.all("form1:reason").value;
	  if(reason.length>100){
		  alert("�����������");
		  return false;
	  }
  }
  </script>
  
  
  <x:saveState value="#{attOvertimeAuditBB}" />
  <h:inputHidden id="initEdit" value="#{attOvertimeAuditBB.initAuditEdit}"/>
  <h:form id="form1">
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ���ڹ��� ->�Ӱ�����"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="center">
		   <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		     <h:outputText value="�������"/>
		     <h:selectOneMenu value="#{attOvertimeAuditBB.result}">
		     	<c:selectItem itemLabel="ͨ��" itemValue="1"/>
		     	<c:selectItem itemLabel="�˻�" itemValue="0"/>
		     </h:selectOneMenu>
		     <h:outputText value="�������"/>
             <h:inputTextarea id="reason" cols="60" rows="5" value="#{attOvertimeAuditBB.reason}"></h:inputTextarea>
		   </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01" onclick="return check()" action="#{attOvertimeAuditBB.saveAudit}"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>