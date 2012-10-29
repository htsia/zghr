<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
   
</c:verbatim>
      <script type="text/javascript">
      function forSave() {
          PutTextareaValue(document.all('form1:textarea'),fGetContent());
          return forsubmit(document.forms(0));
          return false;
      }
      </script>
  <x:saveState value="#{trainDemandBullMgrBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{trainDemandBullMgrBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ������� -> ��������"/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid width="100%" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="��ѵ��������"></h:outputText>
               <h:selectOneMenu value="#{trainDemandBullMgrBB.bullBo.demandType}">
                     <c:selectItem itemLabel="��������" itemValue="0"/>
                     <c:selectItem itemLabel="��������" itemValue="1"/>
               </h:selectOneMenu>
			
               <h:outputText value="��ʼʱ��"></h:outputText>
			   <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{trainDemandBullMgrBB.bullBo.beginDate}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            	</h:panelGroup>
               <h:outputText value="����ʱ��"></h:outputText>
			   <h:panelGroup>
                <h:inputText styleClass="input" id="endDate" value="#{trainDemandBullMgrBB.bullBo.endDate}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">
                </c:verbatim>
            	</h:panelGroup>
            </h:panelGrid>
             <h:panelGrid width="100%" columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            	 <h:outputText value="����"></h:outputText>
            	<h:inputTextarea id="textarea" style="display:none;" value="#{trainDemandBullMgrBB.bullBo.content}" />
            	<c:verbatim>
                 <script language="javascript">
                    gFrame = 1;//1-�ڿ����ʹ�ñ༭��
                    gContentId = "form1:textarea";//Ҫ�������ݵ�content ID
                    OutputEditorLoading();
                </script>
                <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
                </c:verbatim>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" styleClass="button01"  action="#{trainDemandBullMgrBB.save}" onclick="return forSave();"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
