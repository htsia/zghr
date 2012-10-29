<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<html>
<head><title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <f:verbatim>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
        <script type="text/javascript" language="javascript">
            function forClear() {
                form1.all('form1:C001005').value = "";
                form1.all('form1:C001010').value = "";
                form1.all('form1:C001015').value = "";
                form1.all('form1:POSTID').value = "";
                form1.all('form1:C001001').value = "";
                form1.all('form1:C001020').value = "";
                form1.all('form1:C001030').value = "";
                form1.all('form1:C001025').value = "";
                form1.all('form1:C001035').value = "";
                form1.all('form1:C001735').value = "";
            }
        </script>
    </f:verbatim>
</head>

<body>
<h:form id="form1">
    <h:panelGrid width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" styleClass="td_title">
            <f:verbatim>
                <%=LanguageSupport.getResource("GWGL-1061"," 新增岗位模板")%> 
            </f:verbatim>
    </h:panelGrid>
    <f:verbatim><br></f:verbatim>
    <h:panelGrid border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02">
            <f:verbatim>
                <%=LanguageSupport.getResource("JGGL-1078"," 岗位名称")%> 
            </f:verbatim>
        <h:inputText styleClass="input" id="C001005" value="#{post_postTemplateEditBB.postvo.name}" alt="岗位名称|0|s|50||"/>
          <f:verbatim>
                <%=LanguageSupport.getResource("GWGL-1005"," 隶属机构")%> 
            </f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="C001010" code="" dict="yes" dict_num="OU" value="#{post_postTemplateEditBB.postvo.orgId}"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgDlg('form1:C001010')"/>
        </h:panelGroup>
          <f:verbatim>
                <%=LanguageSupport.getResource("GWGL-1062"," 上级岗位")%> 
            </f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="C001015" code="" dict="yes" dict_num="PO" value="#{post_postTemplateEditBB.postvo.superId}" alt="上级岗位|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="fPopUpPostDlg('form1:C001015')"/>
        </h:panelGroup>
        <f:verbatim>
                <%=LanguageSupport.getResource("GWGL-1007"," 岗位编号")%> 
         </f:verbatim>
        <h:inputText styleClass="input" readonly="true" id="C001003" value="#{post_postTemplateEditBB.postvo.postCode}" alt="岗位编号|1|s|50||"/>
         <f:verbatim>
                <%=LanguageSupport.getResource("JGGL-1079"," 岗位分类")%> 
         </f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="C001001" code="" dict="yes" dict_num="0110" value="#{post_postTemplateEditBB.postvo.postClass}" alt="岗位分类|0|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:C001001')"/>
        </h:panelGroup>
         <f:verbatim>
                <%=LanguageSupport.getResource("GWGL-1008"," 岗位等级")%> 
         </f:verbatim>
        <h:inputText styleClass="input" id="C001020" value="#{post_postTemplateEditBB.postvo.postLevel}" alt="岗位等级|1|i|4||"/>
         <f:verbatim>
                <%=LanguageSupport.getResource("JGGL-1080"," 更新日期")%> 
         </f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="C001030" value="#{post_postTemplateEditBB.postvo.updateDate}" alt="更新日期|0|d|50||"/>
            <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog('form1:C001030')"/>
        </h:panelGroup>
         <f:verbatim>
                <%=LanguageSupport.getResource("GWGL-1063"," 岗位IPE等级")%> 
         </f:verbatim>
        <h:inputText styleClass="input" id="C001025" value="#{post_postTemplateEditBB.postvo.postLevel}" alt="岗位IPE等级|1|i|4||"/>

         <f:verbatim>
                <%=LanguageSupport.getResource("GWGL-1009"," 岗位编制")%> 
         </f:verbatim>
        <h:inputText styleClass="input" id="C001735" value="#{post_postTemplateEditBB.postvo.workOut}" alt="岗位编制|1|i|50||"/>
        <h:outputText value=" "/>
        <h:outputText value=" "/>
 
         <f:verbatim>
                <%=LanguageSupport.getResource("GWGL-1010"," 岗位目的")%> 
         </f:verbatim>
        <h:inputTextarea rows="3" id="C001035" cols="80" value="#{post_postTemplateEditBB.postvo.postOrder}"/>
    </h:panelGrid>
    <f:verbatim><br></f:verbatim>
    <h:panelGrid columns="1" border="0" styleClass="table03" align="center">
        <h:panelGroup>
            <h:commandButton value="增加" onclick="javascript:return forsubmit(form1)" styleClass="button01" action="#{post_postTemplateEditBB.savePost}"/>
            <h:commandButton value="取消" type="button" onclick="forClear()" styleClass="button01"/>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
<f:verbatim>
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</f:verbatim>
</body>
</html>