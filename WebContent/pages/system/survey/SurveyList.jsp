<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function queryStatus(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要处理的问卷!");
            return false;
        }
        window.open("/system/survey/PaperStatus.jsf?paperID="+document.all("form1:currentID").value, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=auto,menubar=no");
        return false;
    }
    function queryResult(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要处理的问卷!");
            return false;
        }
        window.open("/system/survey/SurveyResult.jsf?act=resultinit&paperID="+document.all("form1:currentID").value, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=auto,menubar=no");
        return false;
    }
    function queryDetail(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要处理的问卷!");
            return false;
        }
        window.open("/system/survey/SurveyDetailIndex.jsf?act=pageinit&paperID="+document.all("form1:currentID").value, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.05+",width="+screen.width*0.9+",toolbar=no,scrollbars=auto,menubar=no");
        return false;
    }
    function addDictionary(){
        window.showModalDialog("/system/survey/PaperEdit.jsf?act=add&ModuleID="+document.all("form1:moduleID").value, null, "dialogWidth:500px; dialogHeight:360px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/system/survey/ShowSurveyPaper.jsf";
    }
    function modifyDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要修改的问卷!");
            return false;
        }
        window.showModalDialog("/system/survey/PaperEdit.jsf?paperID="+document.all("form1:currentID").value, null, "dialogWidth:500px; dialogHeight:360px;center:center;resizable:no;status:no;scroll:no;");
        document.tree.location.href="/system/survey/ShowSurveyPaper.jsf";
        return false;
    }
    function deletedDictionary(){
        if (document.all("form1:currentID").value==null || document.all("form1:currentID").value==""){
            alert("请选择要删除的问卷!");
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
        document.main.location.href = "/system/survey/QuestionList.jsf?superId=" + orgId;
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 80;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("main").style.height = "" + mainHeight + "px";
    }
</script>
<x:saveState value="#{sys_surveyBB}"></x:saveState>
<h:form id="form1">
	  <h:inputHidden id="pageInit" value="#{sys_surveyBB.pageInit}"/>
	  <h:inputHidden id="currentID" value="#{sys_surveyBB.currentID}"></h:inputHidden>
	  <h:inputHidden id="moduleID" value="#{sys_surveyBB.moduleID}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="#{sys_surveyBB.unitName}"/>
        </h:panelGroup>
      </h:panelGrid>

      <f:verbatim>
      <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="250">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td height="8px"></td></tr>
                    <tr><td align="right">
      </f:verbatim>
                        <h:commandButton styleClass="button01" type="button" value="增加" onclick="addDictionary();"></h:commandButton>
                        <h:commandButton styleClass="button01" type="button" value="修改" onclick="modifyDictionary()"></h:commandButton>
                        <h:commandButton styleClass="button01"  value="删除" action="#{sys_surveyBB.Delete}" onclick="return deletedDictionary();">
                        </h:commandButton>
                        <h:commandButton styleClass="button01"  type="button" value="管理"  onclick="queryStatus();"></h:commandButton>
                        <h:commandButton styleClass="button01"  type="button" value="统计"  onclick="queryResult();"></h:commandButton>
                        <h:commandButton styleClass="button01"  type="button" value="明细"  onclick="queryDetail();"></h:commandButton>
      <f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                    		<iframe name="tree" height="100%"  frameborder="1" framespacing="0" scrolling="auto" width="100%"
                                    src="/system/survey/ShowSurveyPaper.jsf" ></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                    src="/system/survey/QuestionList.jsf"></iframe>
            </td>
        </tr>
    </table>
   </f:verbatim>    
</h:form>


