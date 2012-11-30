<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addDictionary(){
        window.showModalDialog("/eva/itemKeySetEdit.jsf?superId=new", null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/eva/ShowItemSetType.jsp";
    }
    function modifyDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("��ѡ��Ҫ�޸ĵ����!");
            return false;
        }
        window.showModalDialog("/eva/itemKeySetEdit.jsf?setID="+document.all("form1:currentID").value, null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/eva/ShowItemSetType.jsp";
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("��ѡ��Ҫɾ�������!");
            return false;
        }
        if (confirm("ȷ��Ҫɾ����?")){
            return true;
        }
        else{
            return false;
        }
    }
    function refreshList(orgId) {
        document.all("form1:currentID").value=orgId;
        document.main.location.href = "/eva/EvaItemsMgrChild.jsf?setID=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        $("iframe[name=tree]").height(mainHeight);
        $("iframe[name=main]").height(mainHeight);
    }
    
</script>

<h:form id="form1">
	  <h:inputHidden id="currentID" value="#{eva_itemKeyBB.setID}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="#{eva_itemKeyBB.unitName}������ϵ"/>
        </h:panelGroup>
      </h:panelGrid>

       <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
</f:verbatim>
                        <h:commandButton styleClass="button01" type="button" value="����" onclick="addDictionary();"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="�޸�" onclick="modifyDictionary()"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="ɾ��" action="#{eva_itemKeyBB.deleteSet}" onclick="return deletedDictionary();"></h:commandButton>
<f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                            <iframe name="tree" height="400"  frameborder="1" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/eva/ShowItemSetType.jsp"></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/eva/EvaItemsMgrChild.jsf"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>


