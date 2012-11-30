<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String orgId=(String)request.getParameter("fk");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=GBK"/>
    <title>
        <%
            response.setHeader("Pragma","No-cache");
            response.setHeader("Cache-Control","no-cache");
            response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
            response.setContentType("text/html;charset=GBK");
        %>
    </title>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript" language="javascript" src="/js/check.js"></script>
    <script type="text/javascript" language="javascript">
    function Navigate(id){
        document.all("JGGL_L").src="/images/maininterface/corner_left.jpg";
        document.all("JGGL_R").src="/images/maininterface/corner_right.jpg";
        document.all("JGGL_TD").className="maintabinactive";

        document.all("RYGL_L").src="/images/maininterface/corner_left.jpg";
        document.all("RYGL_R").src="/images/maininterface/corner_right.jpg";
        document.all("RYGL_TD").className="maintabinactive";

        document.all("GWGL_L").src="/images/maininterface/corner_left.jpg";
        document.all("GWGL_R").src="/images/maininterface/corner_right.jpg";
        document.all("GWGL_TD").className="maintabinactive";

        document.all(id+"_L").src="/images/maininterface/corner_s_left.jpg";
        document.all(id+"_R").src="/images/maininterface/corner_s_right.jpg";
        document.all(id+ "_TD").className="maintabactive";

        if (id=='JGGL'){
            document.main.location.href="/doc/OrgBasicInfo2.jsf?fk="+document.all('orgId').value;
        }
        else if (id=='RYGL'){
           document.main.location.href = "/lead/info/PersonInfoQuery.jsf?OperID=0461&flag=1&superId=" + document.all('orgId').value;
        }
        else if (id=='GWGL'){
           document.main.location.href = "/lead/postMapShow.jsf?superId=" + document.all('orgId').value;
        }

    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 40;
        $("iframe[name=main]").height(mainHeight);
    }

</script>
</head>
<body>
<input type="hidden" id="orgId" value='<%=orgId%>'>
<table border="0" width="100%"  cellpadding="0" cellspacing="0"  >
    <tr height=20 bgcolor="#2693B4">
        <td width=2></td>

        <td width=1></td>
        <td  width=11>
            <img id="JGGL_L" align="texttop" src="/images/maininterface/corner_s_left.jpg"/>
        </td>
        <td id="JGGL_TD" class=maintabactive width=65>
           <a onclick="Navigate('JGGL')"><img src="/images/maininterface/menu/position.gif"   style="border:0;vertical-align:middle"><font color="<%=Constants.TAB_FONT_COLOR%>">机构情况</font></a>
        <td  width=11>
            <img id="JGGL_R" align="texttop" src="/images/maininterface/corner_s_right.jpg"/>
        <td>

        <td width=1></td>
        <td  width=11>
            <img id="GWGL_L" align="texttop" src="/images/maininterface/corner_left.jpg"/>
        </td>
        <td id="GWGL_TD" class=maintabinactive width=65>
           <a onclick="Navigate('GWGL')"><img src="/images/maininterface/menu/sort.gif"   style="border:0;vertical-align:middle"><font color="<%=Constants.TAB_FONT_COLOR%>">岗位情况</font></a>
        <td  width=11>
            <img id="GWGL_R" align="texttop" src="/images/maininterface/corner_right.jpg"/>
        <td>

        <td width=1></td>
        <td  width=11>
            <img id="RYGL_L" align="texttop" src="/images/maininterface/corner_left.jpg"/>
        </td>
        <td id="RYGL_TD" class=maintabinactive width=65>
           <a onclick="Navigate('RYGL')"><img src="/images/maininterface/menu/user.gif"   style="border:0;vertical-align:middle"><font color="<%=Constants.TAB_FONT_COLOR%>">人员情况</font></a>
        <td  width=11>
            <img id="RYGL_R" align="texttop" src="/images/maininterface/corner_right.jpg"/>
        <td>
        <td>
            &nbsp;
        </td>
    </tr>
</table>
<table border="0" width="100%"  cellpadding="0" cellspacing="0">
    <tr>
        <td >
            <iframe name="main" height="100%"  frameborder="0"  scrolling="auto" width="100%" src='/doc/OrgBasicInfo2.jsf?fk=<%=orgId%>'></iframe>
        </td>
    </tr>
</table>
</body>
</html>

