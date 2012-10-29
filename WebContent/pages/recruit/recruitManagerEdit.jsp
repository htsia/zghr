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
    	function chkData(){
    		 PutTextareaValue(document.all('form1:desc'),fGetContent());
             return forsubmit(document.forms(0));
         }
       	function forBack(form){
             window.close();
       }
      </script>
  
  <x:saveState value="#{recruit_ManagerEditBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{recruit_ManagerEditBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" ��Ƹ����-> ������Ƹ�ƻ�"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="center">
      	  <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             <h:outputText value="�ƻ�����"></h:outputText>
               <h:inputText value="#{recruit_ManagerEditBB.planbo.planName}" id="teachername"></h:inputText>
				<h:outputText value="��������"></h:outputText>
               		<h:panelGroup>
	                <h:inputText styleClass="input" id="planType" code="" dict="yes" dict_num="2201"
	                             readonly="true" value="#{recruit_ManagerEditBB.planbo.planType}"
	                             alt="��������|0|s|50||"/>
	                <c:verbatim>
	                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:planType')">
	                </c:verbatim>
	             </h:panelGroup>
	            <h:outputText value="�ƻ���ʽ"></h:outputText>
	            <h:selectOneMenu value="#{recruit_ManagerEditBB.planbo.planMethod}">
	            	<c:selectItem itemLabel="�ڲ���Ƹ" itemValue="0"></c:selectItem>
	            	<c:selectItem itemLabel="�ⲿ��Ƹ" itemValue="1"></c:selectItem>
	            </h:selectOneMenu>
	            <h:outputText value="�ƻ�����"></h:outputText>
	            <h:selectOneMenu value="#{recruit_ManagerEditBB.planbo.postMode}">
	            	<c:selectItem itemLabel="����λ" itemValue="0"></c:selectItem>
	            	<c:selectItem itemLabel="����λ���" itemValue="1"></c:selectItem>
	            </h:selectOneMenu>
               	<h:outputText value="Ԥ��"></h:outputText>
              	<h:inputText value="#{recruit_ManagerEditBB.planbo.budget}"></h:inputText>
              	<h:outputText value="��ʼ����"></h:outputText>
               <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{recruit_ManagerEditBB.planbo.startDate}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            	</h:panelGroup>
				<h:outputText value="��������"></h:outputText>
               		<h:panelGroup>
                	<h:inputText styleClass="input" id="endDate" value="#{recruit_ManagerEditBB.planbo.endDate}"
                             readonly="true" alt="��������|0|d|50||"/>
               		<c:verbatim>
                  	<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">
                	</c:verbatim>
            	</h:panelGroup>
           		<h:outputText value="�Ƿ���Ҫ����"></h:outputText>
           		<h:selectOneMenu value="#{recruit_ManagerEditBB.planbo.haveTest}">
           			<c:selectItem itemLabel="��Ҫ" itemValue="1"/>
           			<c:selectItem itemLabel="����Ҫ" itemValue="0"/>
           		</h:selectOneMenu>
           		<h:outputText value="���ӦƸ��λ"></h:outputText>
           		<h:inputText value="#{recruit_ManagerEditBB.planbo.maxRecuPost}"></h:inputText>
			</h:panelGrid>
			 <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
              	<h:outputText value="�ƻ�����"></h:outputText>
              	<h:inputTextarea id="desc" rows="3" cols="75" style="display:none;" value="#{recruit_ManagerEditBB.planbo.description}" />
                <c:verbatim>
				<script language="javascript">
                        gFrame = 1;//1-�ڿ����ʹ�ñ༭��
                        gContentId = "form1:desc";//Ҫ�������ݵ�content ID
                        OutputEditorLoading();
                  </script>
				 <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
				</c:verbatim>
			</h:panelGrid>
			<h:panelGrid columns="2" align="right" cellspacing="2">
              <h:commandButton value="����" id="save" onclick="return chkData();"
              	action="#{recruit_ManagerEditBB.save}" styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
  <script type="text/javascript">
    interpret(document.forms(0));
</script>
