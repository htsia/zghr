<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript">
       function selPost(){
    	   fPopUpMutiPostDlg(document.all("form1:postIds"), document.all("form1:postNames"),null);
       }
       
   </script>
  <x:saveState value="#{xys_evaRelSetMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initAdd" value="#{xys_evaRelSetMgrBB.initAdd}"></h:inputHidden>
      <h:inputHidden id="postId" value="#{xys_evaRelSetMgrBB.postId}"></h:inputHidden>
      <h:inputHidden id="postIds" value="#{xys_evaRelSetMgrBB.postIds}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ч���� ->���˹�ϵ"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��λ"></h:outputText>
			   <h:panelGroup>
                   <h:inputTextarea id="postNames" rows="5" cols="40" value="#{xys_evaRelSetMgrBB.postNames}" readonly="true"></h:inputTextarea>
                   <h:commandButton type="button" styleClass="button_post" onclick="selPost()"></h:commandButton>
			   </h:panelGroup>
			   <h:outputText value="������"></h:outputText>
               <h:selectOneMenu value="#{xys_evaRelSetMgrBB.groupId}">
               		<c:selectItems value="#{xys_evaRelSetMgrBB.groupList}"/>
               </h:selectOneMenu>
               <h:outputText value="���˹�ϵ"></h:outputText>
               <h:selectOneMenu value="#{xys_evaRelSetMgrBB.evaType}">
               		 <c:selectItem itemLabel="���ϼ�" itemValue="4"/>
                     <c:selectItem itemLabel="ֱ���ϼ�" itemValue="1"/>
                      <c:selectItem itemLabel="�����ϼ�" itemValue="5"/>
                      <c:selectItem itemLabel="ͬ��" itemValue="2"/>
                      <c:selectItem itemLabel="����ͬ��" itemValue="6"/>
                       <c:selectItem itemLabel="�¼�" itemValue="3"/>
               </h:selectOneMenu>
               
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����"  styleClass="button01"  action="#{xys_evaRelSetMgrBB.saveAdd}" />
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>