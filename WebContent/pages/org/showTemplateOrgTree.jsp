<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
    function addOrg(){
        window.showModalDialog("/org/OrgTemplateItemEdit.jsf?templateId="+document.all('form1:templateID').value, null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
        var url="/pages/org/templateOrgTree.jsp";
        document.all('main').src=url;
    }
    function addPosition(){
    	window.showModalDialog("/org/addPostByTemplate.jsf?templateId="+document.all('form1:templateID').value, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.4+"px;center:center;resizable:yes;status:no;scroll:yes;");
    	var url="/pages/org/templateOrgTree.jsp";
        document.all('main').src=url;
    }
    function modify(){
        if(document.all('form1:orgId').value==""){
            alert("请选择修改的机构");
        }else{
        	window.showModalDialog("/org/OrgTemplateItemEdit.jsf?orgId="+document.all('form1:orgId').value, null, "dialogWidth:400px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        var url="/pages/org/templateOrgTree.jsp";
        document.all('main').src=url;
    }
    function refreshList(orgid){
    	document.all('form1:orgId').value=orgid;
    	document.all('post').src = "/org/orgTemPost.jsf?orgId="+orgid;
    }
    function deleteitem(){
    	 if(document.all('form1:orgId').value==""){
             alert("请选择修改的机构");
         }
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 40;
        $("iframe[name=main]").height(mainHeight);
        document.getElementById("post").style.height = "" + mainHeight + "px";
    }

</script>
<h:form id="form1">
    <h:inputHidden value="#{orgTemplateBB.ininTree}"></h:inputHidden>
    <h:inputHidden id="templateID" value="#{orgTemplateBB.templateId}"></h:inputHidden>
    <h:inputHidden id="orgId" ></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td colspan=2 height=8>
        </td></tr>

        <tr><td height=8 align="left">
        </td>
        <td height=8 align="right">
    </c:verbatim>
        <h:commandButton value="增加机构" styleClass="button01" type="button" onclick="addOrg();"></h:commandButton>
        <h:commandButton value="增加岗位" styleClass="button01" type="button" onclick="addPosition();"></h:commandButton>
        <h:commandButton value="修改" styleClass="button01" type="button" onclick="modify();"></h:commandButton>
        <h:commandButton value="删除" styleClass="button01" onclick="deleteitem()" action="#{orgTemplateBB.deleteOrg}"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr>
        <td height=100% width="30%">
            <iframe id="main" frameborder="0" scrolling="auto" width=100% height=100% src="/pages/org/templateOrgTree.jsp" ></iframe>
        </td>
        <td height=100%>
        	<iframe id="post" frameborder="0" scrolling="auto" width=100% height=100%></iframe>
        </td>
        </tr>
        
        </table>
    </c:verbatim>
</h:form>

