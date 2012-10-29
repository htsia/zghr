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
    function addDictionary(){
        window.showModalDialog("/recruit/PaperEdit.jsf?act=add&ModuleID="+document.all("form1:moduleID").value, null, "dialogWidth:500px; dialogHeight:360px;center:center;resizable:no;status:no;scroll:no;");
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

<h:form id="form1">
	  <h:inputHidden id="currentID" value="#{recu_interviewResultBB.currentID}"></h:inputHidden>
	  <h:inputHidden id="moduleID" value="#{recu_interviewResultBB.moduleID}"></h:inputHidden>
	  <h:inputHidden id="postId" value="#{recu_interviewResultBB.postId}"></h:inputHidden>
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1" align="center">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="#{recu_interviewResultBB.unitName}面试结果综合"/>
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
                        <h:commandButton styleClass="button01"  value="删除" action="#{recu_interviewResultBB.Delete}" onclick="return deletedDictionary();">
                        	
                        </h:commandButton>
                        <h:commandButton styleClass="button01"  type="button" value="管理"  onclick="queryStatus();"></h:commandButton>
      <f:verbatim>
                        </td>
                    </tr>
                    <tr><td height="8px"></td></tr>

                    <tr> <td valign="top">
                    		<%
                    			String moduleID1=(String)request.getSession().getAttribute("ModuleID");
                    			String moduleID=request.getParameter("ModuleID");
                    			if(moduleID==null&&moduleID1!=null){
                    				request.getSession().setAttribute("ModuleID",moduleID1);
                    			}else{
                    				request.getSession().setAttribute("ModuleID",moduleID);
                    			}
                    	 %>
                            <iframe name="tree" frameborder="1" framespacing="0" scrolling="auto" width="100%"
                                    src="/system/survey/ShowSurveyPaper.jsf?ModuleID=<%=moduleID%>"></iframe>
                    </td></tr>
                </table>
            </td>

            <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
            </td>

            <td align="center" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr><td>
                            <iframe name="main" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                    src="/system/survey/QuestionList.jsf"></iframe>
                    </td></tr>
                </table>
            </td>
        </tr>
    </table>
   </f:verbatim>    
</h:form>


