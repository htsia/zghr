<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function preview(){
       window.showModalDialog("/pages/eva/previewTemplate.jsp?templateID="+document.all('form1:templateID').value, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
    }
    function addDictionary(){
        window.showModalDialog("/eva/templateItemSetEdit.jsf?templateID="+document.all('form1:templateID').value, null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.all('tree').src="/pages/eva/ShowTemplateDefine.jsp?templateID="+document.all('form1:templateID').value;
    }
    function modifyDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要修改的类别!");
            return false;
        }
        window.showModalDialog("/eva/templateItemSetEdit.jsf?templateID="+document.all('form1:templateID').value+"&itemSet="+document.all("form1:currentID").value, null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.all('tree').src="/pages/eva/ShowTemplateDefine.jsp?templateID="+document.all('form1:templateID').value;
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要删除的类别!");
            return false;
        }
        if (confirm("确定要删除吗?")){
            return true;
        }
        else{
            return false;
        }
    }
    function refreshList(orgId) {
        document.all("form1:currentID").value=orgId;
        document.main.location.href = "/eva/templateDefineChild.jsf?templateID="+document.all('form1:templateID').value+"&SetID=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        var treeHeight=mainHeight -20;
        document.getElementById("tree").style.height = "" + treeHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>

<h:form id="form1">
    <h:inputHidden value="#{eva_templateBB.initContent}"></h:inputHidden>
    <h:inputHidden id="currentID" value="#{eva_templateBB.itemID}"></h:inputHidden>
    <h:inputHidden id="templateID" value="#{eva_templateBB.templateID}"></h:inputHidden>

      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="考核模板定义"/>
        </h:panelGroup>

         <h:panelGrid align="right">
             <h:commandButton value="预览" onclick="preview();"  type="button" styleClass="button01"></h:commandButton>
         </h:panelGrid>
      </h:panelGrid>

       <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
</f:verbatim>
                        <h:commandButton styleClass="button01" type="button" value="增加" onclick="addDictionary();"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary()"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="删除" action="#{eva_templateBB.deleteItemSet}" onclick="return deletedDictionary();"></h:commandButton>
<f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" height="400"  frameborder="1"  scrolling="yes" width="100%"></iframe>
                            <script type="text/javascript">
                                document.all('tree').src="/pages/eva/ShowTemplateDefine.jsp?templateID="+document.all('form1:templateID').value;
                            </script>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                <iframe name="main" height="100%"  frameborder="0"  scrolling="yes" width="100%"  ></iframe>
                <script type="text/javascript">
                    document.all('main').src="/eva/templateDefineChild.jsf?templateID="+document.all('form1:templateID').value;
                </script>

            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>


