<%@ page contentType="text/html;charset=GBK" language="java" %>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" language="javascript">
         with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 30;
            document.getElementById("content").style.height = "" + mainHeight + "px";
        }
        function navigate(){
            if (document.all("form1:time").value!=""){
               document.content.location.href = "/file/lead/"+document.all("form1:time").value;
             }
        }
    </script>
<x:saveState value="#{htmlBackingBean}"/>
<h:form id="form1">
    <h:inputHidden value="#{htmlBackingBean.initShowChild}"></h:inputHidden>
    <c:verbatim>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">
    <tr><td height=8></td></tr>

    <tr>
        <td >
    </c:verbatim>        
            <h:selectOneMenu id="time" onclick="navigate();">
                <c:selectItems value="#{htmlBackingBean.timeList}"></c:selectItems>
            </h:selectOneMenu>
    <c:verbatim>
        </td>
    </tr>

    <tr>
    <td align="center" valign="top" class="explorer">
        <iframe name="content" frameborder="0"  scrolling="auto" width="100%"    src=""></iframe>
    </td>
    </tr>
</table>
    </c:verbatim>
</h:form>
<script type="text/javascript" language="javascript">
    navigate();
</script>
