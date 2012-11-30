<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    // 接收pk fk   P_PERSONID 多种形式
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String pk = request.getParameter("pk");
    if (pk == null || "".equals(pk)) {
        pk =  request.getParameter("fk");
    }

    String backFlag = request.getParameter("backFlag");
    String partyFlag = request.getParameter("partyFlag");
    if (pk == null || "".equals(pk)) {
        pk = CommonFuns.filterNull((String) request.getAttribute("P_PERSONID"));
    }
    String pFlag = CommonFuns.filterNull((String) request.getAttribute("P_FLAG"));

    String type = CommonFuns.filterNull(request.getParameter("type"));
    String url = "/pages/common/InfoItemTree.jsp?setType=A";          // 全部信息
    if("1".equals(backFlag)){
          url = "/pages/employee/info/BackInfoTree.jsp?setType=A";   //  后备信息
    }
    if("1".equals(partyFlag)){
          url = "/ccp/PartyItemTree.jsf?setType=A";   //  后备信息
    }

    PersonBO pb = SysCacheTool.findPersonById(pk);
%>

    <script type="text/javascript">
        var fk = "<%=pk%>";
        var type = "<%=type%>";
        function refreshList(setId, rsType) {
            if (rsType == "1") {
                document.rs.location.href = "/employee/info/PersonInfoDetail.jsf?setId=" + setId + "&flag=2&fk=" + fk + "&type=" + type;
            } else {
                document.rs.location.href = "/employee/info/PersonInfoDetailList.jsf?setId=" + setId + "&flag=2&fk=" + fk + "&type=" + type;
            }
        }

        function forPrint() {
            var rel = document.all("perFlagId").value;
            windowOpen("/pages/employee/DocPrint.jsf?id=" + rel , "", "status=no,toolbar=no,menubar=yes,location=no", "900", "600", "no");
        }
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            doShowPersonTable(document.all("form1:ReportID").value,'<%=pb.getPersonId()%>');
            return false;
        }

        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 50;
            $("iframe[name=tree]").height(mainHeight);
            document.getElementById("rs").style.height = "" + mainHeight + "px";
            document.getElementById("mainTable").style.height = "" + mainHeight + "px";
        }
    </script>


<h:form id="form1">
<c:verbatim>
<input type="hidden" name="perFlagId" value="<%=pk%>"/>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td  height="10"></td>
    </tr>
    <tr>
        <td  valign="center" class="td_title"><img src="/images/tips.gif" alt="">
            <%
                String s1 =  LanguageSupport.getResource("RYGL-2049", "人员姓名") ;
          	    String s2 =  LanguageSupport.getResource("RYGL-2369", "人员唯一标识") ;
           	    String s3 =  LanguageSupport.getResource("RYGL-2122", "人员编号") ;
                out.print(s1+":"+pb.getName()+"&nbsp;&nbsp;");
                out.print(s2+":"+pb.getPersonId()+"&nbsp;&nbsp;");
                out.print(s3+":"+CommonFuns.filterNull(pb.getPersonCode()));
            %>
        </td>

        <td align="right" class="td_title" >
</c:verbatim>
            <h:outputText escape="false" value="#{emp_personListBB.weaveWarn}"></h:outputText>
            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{emp_personListBB.regTableList}"/>
            </h:selectOneMenu>
            <h:commandButton styleClass="button01" type="button" value="显示登记表" onclick="OpenRpt();"></h:commandButton>
<c:verbatim>
        </td>
    </tr>
</table>

<table width="100%" id="mainTable" border="0" height="100%" cellpadding="0" cellspacing="0" class="table03">
    <tr>
        <td width="180" align="center" valign="top" id=showTree>
            <iframe name="tree" height="400"  frameborder="0"  height="100%"  width="100%" scrolling="auto" src="<%=url%>"></iframe>
        </td>

        <td width="10" class="ctrlbar" valign="middle">
            <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
        </td>

        <td align="left" valign="top">
              <iframe name="rs" frameborder="0" height="100%" width="99%" scrolling="auto" src="/employee/info/PersonInfoDetail.jsf?setId=A001&flag=2&fk=<%=pk%>&type=<%=type%>"></iframe>
        </td>
   </tr>
 </table>
</c:verbatim>
</h:form>
