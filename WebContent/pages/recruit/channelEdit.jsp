<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
 	  
      <script type="text/javascript">
          function checksave(){
        	  if(document.all('form1:chanName').value=="" || document.all('form1:chanPer1').value==""|| document.all('form1:chanAdde').value==""|| document.all('form1:chanTel1').value=="" )
              {
              alert("��"+'*'+"Ϊ������Ϣ��");
              return false;
              }
             return true;
          }
          function forBack(form){
             window.close();
          }
      </script>

  <x:saveState value="#{recruit_channeleditBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{recruit_channeleditBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="chanID" value="#{recruit_channeleditBB.channelbo.chanID}"></h:inputHidden>
      
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ҵ������ -> ������Ϣά�� "/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="������Ϣ����*"></h:outputText>
               <h:inputText id="chanName" value="#{recruit_channeleditBB.channelbo.chanName}"></h:inputText>

               <h:outputText value="��ϵ��1����*"></h:outputText>
               <h:inputText id="chanPer1" value="#{recruit_channeleditBB.channelbo.chanPer1}"></h:inputText>

               <h:outputText value="��ϵ��1�ֻ�"></h:outputText>
               <h:inputText id="chanMobile1" value="#{recruit_channeleditBB.channelbo.chanMobile1}"></h:inputText>

               <h:outputText value="��ϵ��1�绰*"></h:outputText>
               <h:inputText id="chanTel1" value="#{recruit_channeleditBB.channelbo.chanTel1}"></h:inputText>

               <h:outputText value="��ϵ��2����"></h:outputText>
               <h:inputText id="chanPer2" value="#{recruit_channeleditBB.channelbo.chanPer2}"></h:inputText>

               <h:outputText value="��ϵ��2�ֻ�"></h:outputText>
               <h:inputText id="chanMobile2" value="#{recruit_channeleditBB.channelbo.chanMobile2}"></h:inputText>

               <h:outputText value="��ϵ��2�绰"></h:outputText>
               <h:inputText id="chanTel2" value="#{recruit_channeleditBB.channelbo.chanTel2}"></h:inputText>

               <h:outputText value="��ϵ��ַ*"></h:outputText>
               <h:inputText id="chanAdde" value="#{recruit_channeleditBB.channelbo.chanAdde}"></h:inputText>

               <h:outputText value="����"></h:outputText>
               <h:inputText id="chanDesc" value="#{recruit_channeleditBB.channelbo.chanDesc}"></h:inputText>

           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" onclick="return checksave()"  action="#{recruit_channeleditBB.save}" styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
 