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
        <script language="javascript" src="/js/editor2.js"></script>
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
    
<x:saveState value="#{eva_itemKeyBB}"/>
<h:form id="form1" >
        <h:inputHidden id="pageInit" value="#{eva_itemKeyBB.editItem}"/>
<c:verbatim>
        <table width="100%"  align="center" class="table03">
            <tr>
                <td class="td_form01" align="right" width="80">名称</td>
                <td class="td_form02" >
</c:verbatim>
                    <h:inputText  id="title" value="#{eva_itemKeyBB.itemkeyBO.itemName}"  readonly="true" size="45" maxlength="45"  ></h:inputText>
<c:verbatim>
                </td>
              
        <tr>
         <td class="td_form01" align="right" width="80">描 述</td>
        	<td class="td_form02" >
</c:verbatim>
            <h:inputTextarea cols="45" rows="3" value="#{eva_itemKeyBB.itemkeyBO.itemDes}" readonly="true">
            </h:inputTextarea>
<c:verbatim>
        </td>
        </tr>
            </tr>
  <tr>
        <td class="td_form01" align="right" width="80">分数低限</td>
        <td class="td_form02" >
</c:verbatim>
            <h:inputText  value="#{eva_itemKeyBB.itemkeyBO.lowValue}" readonly="true"></h:inputText>
<c:verbatim>
        </td>
   </tr>
   <tr>
         <td class="td_form01" align="right" width="80">分数高限</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  value="#{eva_itemKeyBB.itemkeyBO.highValue}" readonly="true"></h:inputText>
<c:verbatim>
        </td>
    </tr>
     <tr>
        <td class="td_form01" align="right" width="80">打分标准</td>
        <td class="td_form02">
</c:verbatim>
             <h:inputTextarea id="textarea" rows="15" cols="60" style="display:none;"
                        value="#{eva_itemKeyBB.itemkeyBO.scoreStandard}" />
<c:verbatim>
        <script language="javascript">
            gFrame = 1;//1-在框架中使用编辑器
            gContentId = "form1:textarea";//要载入内容的content ID
            OutputEditorLoading();
        </script>
        <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:200px;overflow:visible;" ></iframe>

        </td>
    </tr>
    
  

        </table>
   
</c:verbatim>
</h:form>
