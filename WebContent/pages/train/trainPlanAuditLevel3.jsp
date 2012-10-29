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
        <script language="javascript" src="/js/editor2.js"></script>
        <script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>
<c:verbatim><base target='_self'></c:verbatim>
<x:saveState value="#{midTrainplanAuditeditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{midTrainplanAuditeditBB.initAudit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="��ѵ���� -> ��ѵ�ƻ�����"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
    	<h:panelGrid width="100%" columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
    	 <h:outputText value="�������"/>
            <h:selectOneMenu id="status" value="#{midTrainplanAuditeditBB.planbo.midAudResult3}">
                <c:selectItem itemValue="1" itemLabel="ͬ��"/>
                <c:selectItem itemValue="0" itemLabel="��ͬ��"/>
            </h:selectOneMenu>

            <h:outputText value="ԭ��"/>
            <h:inputTextarea value="#{midTrainplanAuditeditBB.planbo.midAudContent3}" rows="3" cols="80"/>

            <h:outputText value="����"/>
            <h:commandButton styleClass="button01" value="����" action="#{midTrainplanAuditeditBB.audit3}"
                             onclick="return forCheck();"/>
    	
    	</h:panelGrid>
        <h:panelGrid width="100%" columns="4" cellspacing="2" columnClasses="td_form01,td_form02,td_form01,td_form02" styleClass="table03">
            <h:outputText value="����"/>
            <h:inputText id="name" readonly="true" value="#{midTrainplanAuditeditBB.planbo.planName}" />

            <h:outputText value="�ƻ����"/>
            <h:inputText id="year" readonly="true" value="#{midTrainplanAuditeditBB.planbo.year}" />

            <h:outputText value="�ƻ�����"/>
            <h:inputText id="jidu" readonly="true" value="#{midTrainplanAuditeditBB.planbo.dateType}" />

            <h:outputText value="�ƻ��·�"/>
            <h:inputText id="month" readonly="true" value="#{midTrainplanAuditeditBB.planbo.month}" />

            <h:outputText value="Ԥ���ܶ�"/>
            <h:inputText id="budget" readonly="true" value="#{midTrainplanAuditeditBB.planbo.planBudget}" />

            <h:outputText value="�ƻ�����"/>
            <h:inputText id="renshu" readonly="true" value="#{midTrainplanAuditeditBB.planbo.createaOper}" />

        </h:panelGrid>
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
			<h:outputText value="��ѵ�ƻ�����"/>
            <h:inputTextarea id="desc" value="#{midTrainplanAuditeditBB.planbo.planDesc}" cols="75" rows="3" style="display:none;"/>
            <c:verbatim>
                <script language="javascript">
                    gFrame = 1;//1-�ڿ����ʹ�ñ༭��
                    gContentId = "form1:desc";//Ҫ�������ݵ�content ID
                    OutputEditorLoading();
                </script>
                <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
            </c:verbatim>
	    </h:panelGrid>
	 </h:panelGrid>
</h:form>
