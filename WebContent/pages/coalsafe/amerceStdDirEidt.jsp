<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <c:verbatim>
    
        <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    </c:verbatim>

    <script type="text/javascript">
         function doCheck(){
            if (document.all('form1:dirName').value==""){
                alert("请录入名称!");
                return false;
            }
            return true;
        }
         function selAmerceDir(codec, valuec) {
        	    showx = event.screenX - event.offsetX - 150;
        	    showy = event.screenY - event.offsetY + 18;
        	    retval = window.showModalDialog("/pages/coalsafe/selDirSet.jsp", "", "dialogWidth:300px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
        	    //debugger;
        	    if (retval != null) {
        	        rs = retval.split(",");
        	        valuec.value = rs[1];
        	        codec.value = rs[0];
        	    }
        	}
    </script>

<x:saveState value="#{cocalAmerceStdSetBB}"/>
<h:form id="form1" >
        <h:inputHidden id="pageInit" value="#{cocalAmerceStdSetBB.editDir}"/>
<c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td width=100px class="td_form01" align="right">目录名称</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText id="dirName" value="#{cocalAmerceStdSetBB.majorDir.dirName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
		<tr>
                <td width=100px class="td_form01" align="right">上级目录</td>
                <td class="td_form02">
</c:verbatim>
                <h:inputText id="parentname" readonly="true" value="#{cocalAmerceStdSetBB.majorDir.superName}" />
                <h:inputHidden id="parentid" value="#{cocalAmerceStdSetBB.majorDir.superId}" />
                <h:commandButton type="button" styleClass="button_select" onclick="selAmerceDir(document.all('form1:parentid'),document.all('form1:parentname'))"/>
<c:verbatim>
                </td>
            </tr>
	 
</table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="保存" onclick="return doCheck();" action="#{cocalAmerceStdSetBB.saveDir}" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
