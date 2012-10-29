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
    function forCheck() {
       
    	if(document.all("form1:evaModel").value=="-1"||document.all("form1:evaModel").value==""){
            alert("考核模型不能为空！");
            return false;
        }
    	PutTextareaValue(document.all('form1:desc'),fGetContent());
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>
<x:saveState value="#{eva_planeditBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{eva_planeditBB.initEdit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 修改考核计划"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
        <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="名称"/>
            <h:inputText id="name"  value="#{eva_planeditBB.planbo.planName}" />

            <h:outputText value="考核周期"/>
            <h:inputText id="planDate"  value="#{eva_planeditBB.planbo.planDate}" />

            <h:outputText value="开始日期"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{eva_planeditBB.planbo.beginDate}"
                             readonly="true" alt="开始日期|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            </h:panelGroup>

            <h:outputText value="结束日期"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endDate" value="#{eva_planeditBB.planbo.endDate}"
                             readonly="true" alt="结束日期|0|d|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endDate')">
                </c:verbatim>
            </h:panelGroup>

            <h:outputText value="周期类型"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="planType" code="" dict="yes" dict_num="0650"
                             readonly="true" value="#{eva_planeditBB.planbo.planType}"
                             alt="周期类型|0|s|50||"/>
                <c:verbatim>
                  <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:planType')">
                </c:verbatim>
             </h:panelGroup>
             <h:outputText value="结果等级"/>
            <h:panelGroup>
            	<h:inputHidden id="codec" value="#{eva_planeditBB.planbo.planGrade}"/>
                <h:inputText id="valuec" readonly="true" value="#{eva_planeditBB.planbo.planGradeName}"/>
                <h:commandButton type="button" onclick="PopUpGradeTypeTwoControl(document.all('form1:codec'), document.all('form1:valuec'))" styleClass="button_select"></h:commandButton>
             </h:panelGroup>
            <h:outputText value="权重方式"></h:outputText>
            <h:selectOneMenu value="#{eva_planeditBB.planbo.pruview}">
                <c:selectItem itemLabel="按个人" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="按层次关系" itemValue="1"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="考核模型"></h:outputText>
            <h:selectOneMenu value="#{eva_planeditBB.planbo.evaModel}" onchange="submit();" valueChangeListener="#{eva_planeditBB.changeMode}">
                <c:selectItem itemLabel="选择" itemValue="-1"></c:selectItem>
                <c:selectItem itemLabel="量表打分" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="岗位考核" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="任务考核" itemValue="2"></c:selectItem>
                <c:selectItem itemLabel="选票" itemValue="3"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="考核客体类型" rendered="#{eva_planeditBB.planbo.evaModel=='0'||eva_planeditBB.planbo.evaModel=='3'}"></h:outputText>
            <h:selectOneMenu value="#{eva_planeditBB.planbo.planObjectType}" rendered="#{eva_planeditBB.planbo.evaModel=='0'||eva_planeditBB.planbo.evaModel=='3'}">
                <c:selectItem itemLabel="个人" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="部门" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="团队" itemValue="2"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="分数小数位"></h:outputText>
            <h:selectOneMenu value="#{eva_planeditBB.planbo.scorePers}">
                <c:selectItem itemLabel="整数" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="一位小数" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="两位小数" itemValue="2"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="层次权重小数位"></h:outputText>
            <h:selectOneMenu value="#{eva_planeditBB.planbo.levelPers}">
                <c:selectItem itemLabel="整数" itemValue="0"></c:selectItem>
                <c:selectItem itemLabel="一位小数" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="两位小数" itemValue="2"></c:selectItem>
            </h:selectOneMenu>
            <h:outputText value="考核文件"></h:outputText>
            <h:panelGroup>
            	<x:inputFileUpload styleClass="input" id="excelFile" value="#{eva_planeditBB.excelFile}"  storage="file" size="25" />
 				<h:commandButton    value="上传"  styleClass="button01" action="#{eva_planeditBB.uploadFile}"/>
            	<h:outputText value="(.doc)"></h:outputText>
            </h:panelGroup>
            <h:outputText value="上传文件名"></h:outputText>
            <h:outputText value="#{eva_planeditBB.uploadeFileName}"></h:outputText>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="考核计划描述"/>
            <h:inputTextarea id="desc" value="#{eva_planeditBB.planbo.description}" cols="75" rows="3" style="display:none;"/>
            <c:verbatim>
                <script language="javascript">
                    gFrame = 1;//1-在框架中使用编辑器
                    gContentId = "form1:desc";//要载入内容的content ID
                    OutputEditorLoading();
                </script>
                <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
            </c:verbatim>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eva_planeditBB.modify}"
                             onclick="return forCheck();"/>
        </h:panelGrid>

    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>