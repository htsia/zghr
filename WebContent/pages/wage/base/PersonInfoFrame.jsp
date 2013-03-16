<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>

<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String str = request.getParameter("idStr");
    String persId = "";
    String height = "500";
    System.out.println("str="+str);
    System.out.println("id="+request.getParameter("id"));
    if (str == null) {
        persId = request.getParameter("id");
        // # 号被换成 ~传递信息
        persId=persId.replaceAll("~","#");
    } else {
        int i = str.indexOf(",");
        if (i < 0) {
            persId = str.trim();
        } else {
            persId = str.substring(0, i);
        }
        height = "400";
    }
    PersonBO person = SysCacheTool.findPersonById(persId);
%>
<html>
<head>
    <title>信息维护</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/Appclient.js"></script>
    <script language="javascript" src="/js/check.js"></script>
    <script language="javascript" src="/js/checkAll.js"></script>

    <script type="text/javascript" language="javascript">
        var rssetId = "A795";
        var rsSetIdType = "1";
        var personId = "<%=persId%>";

        function refreshList(setId, rsType) {
            rssetId = setId;
            rsSetIdType = rsType;
            refreshLocal(rssetId, rsSetIdType, personId)
        }
        function refreshLocal(setId, rsType, id) {
            var arg = "act=init&setId=" + setId + "&persId=" + id.replace("#","~");
            //            alert(setId)
            if ("A815" == setId) {
                document.list.location = "/pages/wage/base/PersonSalaryList.jsf?" + arg;
            } else {
                if (rsType == '2') {
                    document.list.location = "/wage/base/PersonInfoDetailList.jsf?" + arg;
                } else {
                    document.list.location = "/wage/base/PersonInfoDetail.jsf?" + arg;
                }
            }
        }
        function chgPerson(id, name) {
            document.all('showname').innerText = "姓名：" + name;
            personId = id;
            refreshList(rssetId, rsSetIdType, id);
        }
    </script>
</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
    <tr>
         <td height="22" valign="top" class="td_title" align="left" id=showname>
                        <img src="/images/tips.gif" alt="">
                        姓名： <%
                               if (persId.startsWith("#")){
                                   out.println(person.getName()+"(副本)");
                               }
                               else{
                                  out.println(person.getName()); 
                               }
                               %>
         </td>
    </tr>

    <tr>
        <td align="center" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="top" class="explorer" id="showTree" width="230">
                        <table width="100%" border=0 cellpadding="0" cellspacing="0" valign="top">
                            <tr>
                                <td>
                                    <iframe name="tree" height="400"  frameborder="0"  scrolling="yes" width="100%"
                                            height="<%=height%>"
                                            src="/pages/wage/base/PersonWageInfoSetTree.jsp">
                                     </iframe>
                                </td>
                            </tr>
                            <%
                                if (str != null && str.length() > 0) {
                                    String [] personId = str.split(",");
                            %>
                            <tr>
                                <td>
                                    <div id=datatable>
                                        <table width="90%" align="center" border=0 cellpadding="0" cellspacing="0"
                                               valign="top" class="table03">
                                            <%
                                                int len = personId.length;
                                                for (int i = 0; i < len; i++) {
                                                    String name = CodeUtil.interpertCode("PE", personId[i]);
                                            %>
                                            <tr>
                                                <td class="td_top">
                                                    <a href="#"
                                                       onclick="chgPerson('<%=personId[i]%>','<%=name%>')"><%=name%></a>
                                                </td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </table>
                                    </div>
                                </td>

                            </tr>
                            <%
                                }
                            %>
                        </table>
                    </td>

                    <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()">
                    </td>
                    <td align="center" valign="top" class="explorer">
                            <iframe name="list" frameborder="0" framespacing="0" scrolling="yes" width="100%"
                                    height="500"
                                    src="/wage/base/PersonInfoDetail.jsf?act=init&setId=A795&persId=<%=persId.replaceAll("#","~")%>">
                            </iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<script type="text/javascript">
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 34;
        $("iframe[name=tree]").height(mainHeight);
        $("iframe[name=main]").height(mainHeight);
    }
</script>
</body>
</html>