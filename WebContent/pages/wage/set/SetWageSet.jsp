<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doCheck() {
            if (document.all("form1:setMB").value==""){
                alert("请选择!");
                return false;
            }
            window.returnValue=document.all("form1:setMB").value;
            window.close();
            return true;
        }
        function doClose() {
            window.returnValue="";
            window.close();
            return true;
        }

    </script>

<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
<c:verbatim>
    <table align="center" width="98%">
    <tr>
        <td align="right"  class="td_title">
</c:verbatim>
            <h:commandButton styleClass="button01" type="button" value="保存"     onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="return doClose();"/>
<c:verbatim>
        </td>
    </tr>
        
    <tr>
        <td align="left">
</c:verbatim>
        <h:selectOneMenu id="setMB" >
           <c:selectItems value="#{wage_setBB.selUnititem}"/>
        </h:selectOneMenu>
<c:verbatim>
        </td>
     </tr>
    </table>
</c:verbatim>
</h:form>
