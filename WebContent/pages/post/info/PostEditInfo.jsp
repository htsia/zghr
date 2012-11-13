<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.post.util.PostTool"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String pk = request.getParameter("pk");
    if(pk == null || "".equals(pk)){
        pk = (String)request.getAttribute("P_POSTID");
    }
    String type = CommonFuns.filterNull(request.getParameter("type"));
    String flag = CommonFuns.filterNull(request.getParameter("flag"));
    if ("".equals(flag)){
        flag="2";
    }
%>

<script type="text/javascript">
        var fk = "<%=pk%>";
        var type="<%=type%>";
        var flag="<%=flag%>";
        function refreshList(setId, rsType) {
            if (rsType == "1") {
                document.rs.location.href = "/post/info/PostInfoDetail.jsf?setId=" + setId + "&flag="+flag+"&fk=" + fk+"&type="+type;
            } else {
                document.rs.location.href = "/post/info/PostInfoDetailList.jsf?setId=" + setId + "&flag="+flag+"&fk=" + fk+"&type="+type;
            }
        }
        function OpenRpt(){
            if (document.all("ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("ReportID").value+"&Parameter="+fk;
            window.open(url);
            return false;
        }
        
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("rs").style.height = "" + mainHeight + "px";
        }
    </script>

<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
    <tr>
        <td  valign="bottom" class="td_title"><img src="/images/tips.gif" alt=""> 
         <%=LanguageSupport.getResource("JGGL-1078"," 岗位名称")%> :
         <%=CommonFuns.filterNull(PostTool.getPostName(pk))%></td>
        <td align="right" class="td_title">
</c:verbatim>
            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{post_editPostBB.regTableList}"/>
            </h:selectOneMenu>
            <h:commandButton styleClass="button01" type="button" value="显示登记表" onclick="OpenRpt();"></h:commandButton>
<c:verbatim>
        </td>
    </tr>
</table>
</c:verbatim>

<c:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table03">
    <tr>
        <td width="200" align="center" valign="top" id=showTree>
               <iframe name="tree" height="400"  frameborder="0"  width="100%"
                                scrolling="auto" src="/pages/common/InfoItemTree.jsp?setType=C"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" alt="" onclick="ctrlbar()">
        </td>

        <td align="right" valign="top">
             <iframe name="rs" frameborder="0"  width="100%"  scrolling="auto"   src="/post/info/PostInfoDetail.jsf?setId=C001&flag=<%=flag%>&fk=<%=pk%>&type=<%=type%>"></iframe>
        </td>
    </tr>
 </table>
</c:verbatim>