<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function refreshList(setId, rsType) {
         document.rs.location.href = "/employee/batch/BatchAddInfo.jsf?setId=" + setId + "&flag=2";
    }

    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 30;
        document.getElementById("tree").style.height = "" + mainHeight + "px";
        document.getElementById("rs").style.height = "" + mainHeight + "px";
    }
</script>

<h:form>
    <h:inputHidden value="#{emp_BatchPersonListBB.pageInit}"/>
    <c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
    <tr>
        <td  valign="bottom" class="td_title" colspan=3 height=28>
        <%=LanguageSupport.getResource( "RYGL-0316", "批量增加")%>            
                </td>
    </tr>

    <tr>
        <td width="180" align="center" valign="top" id=showTree>
                <iframe name="tree" height="400"  frameborder="0"  width="100%" height="535"
                                scrolling="auto" src="/pages/common/InfoItemTree.jsp?setType=A&onlyMulti=true"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
         </td>

        <td align="right" valign="top">
            <iframe name="rs" frameborder="0"  width="100%" height="535" scrolling="auto"
                    src="/employee/batch/BatchAddInfo.jsf"></iframe>
        </td>
      </tr>
 </table>
</c:verbatim>
 </h:form>
