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
	<script>
	function document.oncontextmenu(){event.returnValue=false;}
	function disableselect(e){
		return false}
		function reEnable(){return true
		}
		file://if IE4+
		document.onselectstart=new Function ("return false")
		file://if NS6
		if (window.sidebar){
		document.onmousedown=disableselect
		document.onclick=reEnable
		}
		</SCRIPT>
		<SCRIPT language=JavaScript type=text/JavaScript>
		<!--
		function MM_reloadPage(init) {    //reloads the window if Nav4 resized
		    if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
		      document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
		    else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
		}
		MM_reloadPage(true);
		//-->
	</script>
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
</script>

<x:saveState value="#{selfInputworkSumBB}"/>
<h:form id="form1">
    <h:inputHidden id="initEdit" value="#{selfInputworkSumBB.initEdit}"/>
    <h:panelGrid align="center" width="100%" columns="1">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="#{selfInputworkSumBB.showFiled}"/>
            <h:inputTextarea id="content" value="#{selfInputworkSumBB.content}" cols="95" rows="10" readonly="true"/>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2" rendered="#{selfInputworkSumBB.method=='input'}">
            <h:commandButton styleClass="button01" value="保存" action="#{selfInputworkSumBB.save}" 
                             onclick="return forCheck();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
