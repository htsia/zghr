<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function refreshList(setId, rsType) {
             document.rs.location.href = "/employee/batch/BatchUpdateInfo.jsf?setId=" + setId + "&flag=2";
        }

        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 50;
            $("iframe[name=tree]").height(mainHeight);
            document.getElementById("rs").style.height = "" + mainHeight + "px";
        }
    </script>
<h:form>
<h:inputHidden value="#{emp_BatchPersonListBB.pageInit}"/>
<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
     <tr>
        <td  height="8"></td>
    </tr>
    <tr>
        <td width="170" valign="bottom" class="td_title"><img src="/images/tips.gif" alt="">
          <%=LanguageSupport.getResource("RYGL-0317"," ÅúÁ¿ÐÞ¸Ä ")%>   
       </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table03">
    <tr>
        <td width="180" align="center" valign="top" id=showTree>
                        <iframe name="tree" height="400"  frameborder="0"  width="100%" height="535"
                                scrolling="auto" src="/pages/common/InfoItemTree.jsp?setType=A&flag=2"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
        </td>

        <td align="right" valign="top">
                    <iframe name="rs" frameborder="0"  width="100%" height="535" scrolling="auto"
                            src="/employee/batch/BatchUpdateInfo.jsf"></iframe>
       </td>
    </tr>
 </table>
</c:verbatim>
</h:form>

