<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>非法软件授权</title>
</head>

<body>
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
                <script type="text/javascript">
                    document.write("<td  height='100%' width='100%'  ><img src='/images/maininterface/login_backgroud.jpg' width=100% height=100% style='position:absolute;top:0;left:0;z-index:-1'></td>");
                </script>
           </tr>
        </table>

  <script  language="javascript">
        if(window.opener != null){
            window.opener.location = "/pages/overtime.jsp";
            this.close();
        }
        var p = window.parent;
        var cur = this;
        //找到最上级页面
        while(p != cur)
        {
           p = p.parent;
           cur = p;
        }
        if(p != this)     p.location = "overtime.jsp"
    </script>

        <script type="text/javascript">
            var logintop=document.body.clientHeight/2;
            var contentStr="<table   style='POSITION: absolute; top:"+logintop+"px;' width='100%' cellspacing=0 cellpadding=0 border=0>";
            document.write(contentStr);
        </script>
          <tr><td align="center">
                <font color="red" size="6">
                    您正在使用的软件没有合法授权！</font><font color="red" size="4">(授权方式：<%if ("true".equals(Constants.showLimit)) out.println("网上授权");else out.println("加密狗");%>)</font><br>

          </td></tr>
        <script type="text/javascript">
            document.write("</table>");
        </script>

</body>
</html>
