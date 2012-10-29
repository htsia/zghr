<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" language="javascript">
 function checkSubmit(form1) {
        flag = true;
        var name = form1.all("form1:templateClassId").value;
        if (name == "" || name == null) {
            alert("模板所属类别不能为空！");
            flag = false;
        }
        name = form1.all("form1:ispublic").value;
         if (name == "" || name == null) {
             alert("请选择是否公用！");
             flag = false;
         }
        return flag;
    }
</script>

<x:saveState value="#{cont_contTemplateBB}"></x:saveState>
<h:form id="form1" enctype="multipart/form-data" >
    <h:inputHidden id="init" value="#{cont_contTemplateBB.pageInit}"/>
    <h:panelGrid width="100%" border="0" styleClass="td_title" cellspacing="6" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="合同模板维护 "  ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid width="400" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="2" columnClasses="td_form01,td_form02">
                <h:outputText styleClass="td_form_required" value="模板所属类别"></h:outputText>
                <h:selectOneMenu value="#{cont_contTemplateBB.bo.contTemplateClassBO.templateClassId}" id="templateClassId" style="width:150">
                    <c:selectItems value="#{cont_contTemplateBB.item_templateClass}"/>
                </h:selectOneMenu>

                <h:outputText  styleClass="td_form_required" value="模板类型"></h:outputText>
                <h:panelGroup>
                        <h:inputText styleClass="input" value="#{cont_contTemplateBB.bo.templateType}" id="templateType"  code="" dict="yes" dict_num="2011" readonly="true" alt="模板类型|0" />
                        <c:verbatim><input type="button"  value="" onclick="PopUpCodeDlgOneControl('form1:templateType')" class="button_select"></c:verbatim>
                </h:panelGroup>

                <h:outputText styleClass="td_form_required" value="模板名称"></h:outputText>
                <h:inputText styleClass="input" id="templateName" size ="40" value="#{cont_contTemplateBB.bo.templateName}" maxlength="30" alt="模板名称|0|s" />

                <h:outputText styleClass="td_form_required" value="版本"></h:outputText>
                <h:panelGroup>
                    <h:outputText value="#{cont_contTemplateBB.bo.templateEdition}" />
                    <h:inputHidden id="templateEdition" value="#{cont_contTemplateBB.bo.templateEdition}"/>
                </h:panelGroup>

                <h:outputText styleClass="td_form_required" value="最后更新时间"></h:outputText>
                <h:panelGroup>
                    <h:outputText value="#{cont_contTemplateBB.bo.lastCreateDate}" />
                    <h:inputHidden id="lastCreateDate" value="#{cont_contTemplateBB.bo.lastCreateDate}"/>
                </h:panelGroup>

                <h:outputText styleClass="td_form_required" value="是否公用"></h:outputText>
                <h:selectOneMenu id="ispublic" value="#{cont_contTemplateBB.bo.isPublic}">
                    <c:selectItem itemLabel="" itemValue=""></c:selectItem>
                    <c:selectItem itemLabel="公用" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="不公用" itemValue="0"></c:selectItem>
                </h:selectOneMenu>

                <h:outputText rendered="#{cont_contTemplateBB.displayFlag}" styleClass="td_form_required" value="查看模板文件"></h:outputText>
                <h:panelGroup  rendered="#{cont_contTemplateBB.displayFlag}">
                    <c:verbatim escape="false"><A href="/pages/cont/Download.jsp?attachmentId=</c:verbatim><h:outputText value="#{cont_contTemplateBB.bo.attachmentId}"/><c:verbatim escape="false">" taget="_blank" ></c:verbatim>
                    <h:outputText value="点击查看" />
                    <c:verbatim escape="false"></A></c:verbatim>
                </h:panelGroup>

                <h:outputText value="上传模板文件"></h:outputText>
                <x:inputFileUpload id="myFileId" styleClass="input"
			        value="#{cont_contTemplateBB.myFile}"
			        storage="file"/>

    </h:panelGrid>

    <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
         <h:commandButton styleClass="button01" value="保存" action="#{cont_contTemplateBB.save}"  onclick="if( checkSubmit(document.forms(0))&&forsubmit(document.forms(0)) ){}else{return false;}"/>
         <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
    </h:panelGrid>
</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
