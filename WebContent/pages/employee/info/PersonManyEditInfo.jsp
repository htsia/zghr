<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
     String backFlag = request.getParameter("backFlag");
     String url = "/pages/common/InfoItemTree.jsp?setType=A";
    if("1".equals(backFlag)){
          url = "/pages/employee/info/BackInfoTree.jsp?setType=A";
    }
%>
    <script type="text/javascript">
        function refreshList(setId, rsType) {
            fk = document.all("personid").value;
            document.all("stype").value = rsType;
            document.all("setid").value = setId;
            if (rsType == "1") {
                document.rs.location.href = "/employee/info/PersonInfoDetail.jsf?setId=" + setId + "&flag=2&fk=" + fk;
            } else {
                document.rs.location.href = "/employee/info/PersonInfoDetailList.jsf?setId=" + setId + "&flag=2&fk=" + fk;
            }
        }

        function forPersonList(setId, setType, perid, sname) {
            document.all("personid").value = perid;
            document.all("name").innerText="人员姓名："+sname;
            if (setType == "1") {
                document.rs.location.href = "/employee/info/PersonInfoDetail.jsf?setId=" + setId + "&flag=2&fk=" + perid;
            } else {
                document.rs.location.href = "/employee/info/PersonInfoDetailList.jsf?setId=" + setId + "&flag=2&fk=" + perid;
            }
        }

        with (window) onload = onresize = function() {
            var mainHeight = document.body.offsetHeight - 39;
            var treeHeight = mainHeight-200
            document.getElementById("tree").style.height = "" + treeHeight + "px";
            document.getElementById("list").style.height = "" + 200 + "px";
            document.getElementById("rs").style.height = "" + mainHeight + "px";
        }
    </script>
<%
    String pid = CommonFuns.filterNull((String) request.getAttribute("pid"));
%>


<h:form id="form1">
    <h:inputHidden value="#{emp_ManyPersonBB.pageInit}"/>
<c:verbatim>
    <input type=hidden name="stype" value="1">
    <input type=hidden name="personid" value="<%=pid%>">
    <input type=hidden name="setid" value="A001">
    <table width="98%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td  height="10"></td>
    </tr>
    <tr>
        <td  valign="center" class="td_title"><img src="/images/tips.gif" alt=""><strong><span id="name">
        
  <%=LanguageSupport.getResource("RYGL-2370","多人信息维护") %>
        
         </span></strong>
        </td>
    </tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table03">
    <tr>
        <td width="180" align="center" valign="top" id=showTree>
            <table width="100%" border=0 cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <iframe name="tree" frameborder="0" framespacing="0" width="100%" height="500"
                                scrolling="auto" src="<%=url%>"></iframe>
                    </td>
                </tr>
                <tr><td>
                    <iframe name="list" frameborder="0" framespacing="0" width="100%" height="100"
                            scrolling="auto" src="/employee/info/PersonList.jsf"></iframe>
                </td></tr>
            </table>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
        <td align="right" valign="top">
                    <iframe name="rs" frameborder="0" framespacing="0" width="100%"  scrolling="yes" ></iframe>
        </td>
    </tr>
   </table>
</c:verbatim>    
</h:form>
