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
        if(document.all("form1:content").value==null||document.all("form1:content").value==""){
            alert("工作总结不能为空");
            return false;
        }else{
        	return true;
        }
    }
    function viewAtt(id){
	  	 window.open('/pages/eva/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
	}
</script>

<x:saveState value="#{selfInputworkSumBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden id="initEdit" value="#{selfInputworkSumBB.initEdit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 自助填写工作总结"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
        <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="单位"/>
            <h:inputText  value="#{selfInputworkSumBB.orgName}" readonly="true"/>

            <h:outputText value="部门"/>
            <h:inputText  value="#{selfInputworkSumBB.deptName}" readonly="true"/>

            <h:outputText value="姓名"/>
            <h:inputText  value="#{selfInputworkSumBB.personName}" readonly="true"/>
            <h:outputText value="岗位"/>
            <h:inputText  value="#{selfInputworkSumBB.postName}" readonly="true"/>
            <h:outputText value="述职报告（.doc）" rendered="#{selfInputworkSumBB.method=='input'}"/>
            <h:panelGroup rendered="#{selfInputworkSumBB.method=='input'}">
            <x:inputFileUpload styleClass="input" id="excelFile" value="#{selfInputworkSumBB.excelFile}"  storage="file" size="25" />
		    <h:commandButton    value="上传"  styleClass="button01" action="#{selfInputworkSumBB.uploadFile}"/>
		    </h:panelGroup>
		    <h:outputText value="查看"/>
		    <h:commandLink value="工作总结" onclick="viewAtt('#{selfInputworkSumBB.attId}')"  rendered="#{selfInputworkSumBB.isExist=='1'}"></h:commandLink>
			<h:outputText value="无" rendered="#{selfInputworkSumBB.isExist=='0'}"></h:outputText>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="#{selfInputworkSumBB.showFiled}"/>
            <h:inputTextarea id="content" value="#{selfInputworkSumBB.content}" cols="75" rows="10"/>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2" rendered="#{selfInputworkSumBB.method=='input'}">
            <h:commandButton styleClass="button01" value="保存" action="#{selfInputworkSumBB.save}" 
                             onclick="return forCheck();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
