<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<html>
<head><title></title></head>
<script language="javascript">
        var xmlHttp;
        var superId = "";

        //创建XMLHttpRequest对象
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
        }

        //统计报表
        function DoProcess(Rptcode,UnitID,Command,oid,Parameter) {
            document.all("TextResult").value="开始处理报表,请稍等...";
            xmlHttp.onreadystatechange = handleStateChange;
            var url="";
            if (oid!=null && oid!=undefined && oid!=""){
              url="/pages/ajax/Report.jsp?Oids="+oid+"&Command="+Command+"&UnitID="+UnitID+"&RptCode=" +Rptcode+"&Parameter="+Parameter;
            }
            else{
               url="/pages/ajax/Report.jsp?Command="+Command+"&UnitID="+UnitID+"&RptCode=" +Rptcode+"&Parameter="+Parameter;
            }
            //alert(url);
            xmlHttp.open("GET",url , true);
            xmlHttp.send(null);
            document.all("TextResult").value+="\r正在向服务器发请求";
            showProcessBar("block");
        }

        //XMLHttpRequest状态改变时要执行的函数
        function handleStateChange() {
            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                    //解析从xml文件得到的结果
                    parseResults();
                }
            }
        }

        //解析从xml文件得到的结果 ，动态画树
        function parseResults() {
            var results = xmlHttp.responseXML;
            var root = results.documentElement;
            try{
               var info = root.getElementsByTagName('info');
               var str=info[0].firstChild.data;
               document.all("TextResult").value+="\r服务器返回如下结果：";
               document.all("TextResult").value=document.all("TextResult").value+"\r"+str;
               showProcessBar("none");
            }
            catch(exception){}
        }
       function showProcessBar(show) {
        x = 20;
        y = document.body.clientHeight / 2;
        if (y==0) y=200;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = show;
       }
    </script>
<body>
<table width=680>
    <tr>
        <td><TEXTAREA id="TextResult" name="Textarea1" rows="33" cols="115"></TEXTAREA></td>
    </tr>

    <tr>
        <td align="right"><input Class="button01" type="button" onclick="window.close();" value="关闭">
        </td>
    </tr>
</table>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="650"
     scrollamount="5" scrolldelay="10"
     bgcolor="#ECF2FF">
<table cellspacing="1" cellpadding="0">
<tr height=8>
    <td bgcolor=#3399FF width=8></td>
    <td></td>
    <td bgcolor=#3399FF width=8></td>
    <td></td>
    <td bgcolor=#3399FF width=8></td>
    <td></td>
    <td bgcolor=#3399FF width=8></td>
    <td></td>
</tr>
</table>
</marquee>
<script language="javascript">
<%
    // xmlHttp.readyState
    // 0 (未初始化) 对象已建立，但是尚未初始化（尚未调用open方 法）
    // 1 (初始化) 对象已建立，尚未调用send方法
    // 2 (发送数据) send方法已调用，但是当前的状态及http头未知
    // 3 (数据传送中) 已接收部分数据，因为响应及http头不全，这时通过responseBody和responseText获取部分数据会出现错误，
    // 4 (完成) 数据接收完毕,此时可以通过通过responseBody和responseText获取完整的回应数据
   String RptCode=request.getParameter("ReportList");
   String UnitID=request.getParameter("UnitID");
   String Command=request.getParameter("Command");
   String Oids=request.getParameter("Oids");
   String Parameter=request.getParameter("Parameter");
   out.println("createXMLHttpRequest();");
   out.println("DoProcess('"+RptCode+"','"+UnitID+"','"+Command+"','"+Oids+"','"+Parameter+"');");
%>
</script>
</body>
</html>