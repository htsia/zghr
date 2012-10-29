<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function addDictionary(){
        window.showModalDialog("/xys/eva/SetDeptObjKeyLibEdit.jsf?objId="+document.all('form1:objId').value, null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/xys/eva/SetDeptObjLibTree.jsp?objId="+document.all('form1:objId').value;
    }
    function modifyDictionary(){
        if (document.all("form1:libId").value==null || document.all("form1:libId").value==""){
            alert("请选择要修改的指标库!");
            return false;
        }
        window.showModalDialog("/xys/eva/SetDeptObjKeyLibEdit.jsf?libId="+document.all("form1:libId").value, null, "dialogWidth:330px; dialogHeight:140px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/pages/xys/eva/SetDeptObjLibTree.jsp?objId="+document.all('form1:objId').value;
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:libId").value==null || document.all("form1:libId").value==""){
            alert("请选择要删除的指标库!");
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
        document.all("form1:libId").value=orgId;
        document.main.location.href = "/xys/eva/SetDeptObjKey.jsf?libId=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
    
</script>

<h:form id="form1">
      <h:inputHidden id="initLib" value="#{xys_KpiDeptSetBB.initLib}"></h:inputHidden>
	  <h:inputHidden id="libId" value="#{xys_KpiDeptSetBB.libId}"></h:inputHidden>
     <h:inputHidden id="objId" value="#{xys_KpiDeptSetBB.objId}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="KPI指标设置"/>
            <f:verbatim>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </f:verbatim>
            <h:commandButton styleClass="button01"  value="加载标准指标库" action="#{xys_KpiDeptSetBB.loadStrLib}" disabled="#{xys_KpiDeptSetBB.disabled}"></h:commandButton>
            <f:verbatim>
            &nbsp;&nbsp;
            </f:verbatim>
            <h:commandButton styleClass="button01"  value="加载上年度指标库" action="#{xys_KpiDeptSetBB.loadBeforeLib}" disabled="#{xys_KpiDeptSetBB.disabled}"></h:commandButton>
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
                        <h:commandButton styleClass="button01" type="button" value="增加" onclick="addDictionary();" disabled="#{xys_KpiDeptSetBB.disabled}"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary()" disabled="#{xys_KpiDeptSetBB.disabled}"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="删除" action="#{xys_KpiDeptSetBB.deleteLib}" onclick="return deletedDictionary();" disabled="#{xys_KpiDeptSetBB.disabled}"></h:commandButton>
<f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>
                     <%
                        String objId=(String)session.getAttribute("objId");
                    %>
                    <tr> <td valign="top">
                            <iframe name="tree" height="100%"  frameborder="1" framespacing="0" scrolling="yes" width="100%"
                                    src="/pages/xys/eva/SetDeptObjLibTree.jsp?objId=<%=objId%>"></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    src="/xys/eva/SetDeptObjKey.jsf?libId=NULL"></iframe>
            </td>
        </tr>
    </table>
</f:verbatim>    
</h:form>


