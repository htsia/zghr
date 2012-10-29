<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
    function addMaster(){
        window.showModalDialog("/eva/addMaster.jsf?objectID="+document.all('form1:objectID').value, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function beginInput(){
       	var url="/eva/TemplateSetScore.jsf?templateID="+document.all('form1:templateID').value+"&masterID="+document.all('form1:masterID').value+"&objectID="+document.all('form1:objectID').value;
        document.all('main').src=url;
    }
</script>
<x:saveState value="#{evaTempMasterBB}"/>
<h:form id="form1">
   <h:inputHidden value="#{evaTempMasterBB.objectsInit}"></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td colspan=2 height=8>
        </td></tr>
		<tr><td height=8 align="left">
    </c:verbatim>
            <h:outputText value="临时考核主体:#{evaTempMasterBB.masterName}"></h:outputText>
            <h:outputText value="   "></h:outputText>
    <c:verbatim>
        </td>
        <td height=8 align="right">
    </c:verbatim>
        <h:selectOneMenu id="objectID" value="#{evaTempMasterBB.objectID}"  onchange="submit();"  valueChangeListener="#{evaTempMasterBB.doObject}">
            <c:selectItems value="#{evaTempMasterBB.objectsList}"></c:selectItems>
        </h:selectOneMenu>
        <h:inputHidden id="templateID" value="#{evaTempMasterBB.templateID}"></h:inputHidden>
        <h:inputHidden id="masterID" value="#{evaTempMasterBB.masterID}"></h:inputHidden>
        <h:commandButton value="开始录入" styleClass="button01" type="button" onclick="beginInput();"></h:commandButton>
        <h:commandButton value="关闭" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td colspan=2>
            <iframe id="main" width=100% height=100%></iframe>
        </td></tr>
        
        </table>
    </c:verbatim>

</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>
