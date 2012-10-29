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
            if(forsubmit(document.forms(0))){
                 return true;
            }
            else{
                return false;
            }
         }
       	function forBack(form){
             window.close();
       }
      </script>
  
  <x:saveState value="#{TrainPlan_makeBB}"/>
  <h:form id="form1" enctype="multipart/form-data">
      <h:inputHidden id="initEdit" value="#{TrainPlan_makeBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="培训计划-> 增加培训计划"/>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
      	
           <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             	<h:outputText value="计划名称"></h:outputText>
               	<h:inputText value="#{TrainPlan_makeBB.trainPlanbo.planName}" ></h:inputText>
				<h:outputText value="计划时间"></h:outputText>
              	<h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{TrainPlan_makeBB.trainPlanbo.dateValue}"
                             readonly="true" alt="开始日期|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            	</h:panelGroup>
              	<h:outputText value="预算"></h:outputText>
              	<h:inputText value="#{TrainPlan_makeBB.trainPlanbo.planBudget}"></h:inputText>
              	<h:outputText value="计划人数"></h:outputText>
              	<h:inputText value="#{TrainPlan_makeBB.trainPlanbo.createaOper}"></h:inputText>
              	<h:outputText value="附件"></h:outputText>
              	<h:panelGroup>
              		<x:inputFileUpload styleClass="input" id="excelFile" value="#{TrainPlan_makeBB.excelFile}"  storage="file" size="25" />
 					<h:commandButton    value="上传"  styleClass="button01" action="#{TrainPlan_makeBB.uploadFile}"/>
              	</h:panelGroup>
            </h:panelGrid>
			<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
				<h:outputText value="培训计划描述"/>
            <h:inputTextarea id="desc" value="#{TrainPlan_makeBB.trainPlanbo.planDesc}" cols="75" rows="3" style="display:none;"/>
            <c:verbatim>
                <script language="javascript">
                    gFrame = 1;//1-在框架中使用编辑器
                    gContentId = "form1:desc";//要载入内容的content ID
                    OutputEditorLoading();
                </script>
                <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
            </c:verbatim>
			</h:panelGrid>
			<h:panelGrid align="right">
              <h:commandButton value="保存" id="save" onclick="return chkData();"
              	action="#{TrainPlan_makeBB.save}" styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>
  <script type="text/javascript">
    interpret(document.forms(0));
</script>
