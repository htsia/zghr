<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<html>
<head><title></title></head>
<script language="javascript">
        var xmlHttp;
        var superId = "";

        //����XMLHttpRequest����
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
        }

        //ͳ�Ʊ���
        function DoProcess(Rptcode,UnitID,Command,oid,Parameter) {
            document.all("TextResult").value="��ʼ������,���Ե�...";
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
            document.all("TextResult").value+="\r�����������������";
            showProcessBar("block");
        }

        //XMLHttpRequest״̬�ı�ʱҪִ�еĺ���
        function handleStateChange() {
            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                    //������xml�ļ��õ��Ľ��
                    parseResults();
                }
            }
        }

        //������xml�ļ��õ��Ľ�� ����̬����
        function parseResults() {
            var results = xmlHttp.responseXML;
            var root = results.documentElement;
            try{
               var info = root.getElementsByTagName('info');
               var str=info[0].firstChild.data;
               document.all("TextResult").value+="\r�������������½����";
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
        <td align="right"><input Class="button01" type="button" onclick="window.close();" value="�ر�">
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
    // 0 (δ��ʼ��) �����ѽ�����������δ��ʼ������δ����open�� ����
    // 1 (��ʼ��) �����ѽ�������δ����send����
    // 2 (��������) send�����ѵ��ã����ǵ�ǰ��״̬��httpͷδ֪
    // 3 (���ݴ�����) �ѽ��ղ������ݣ���Ϊ��Ӧ��httpͷ��ȫ����ʱͨ��responseBody��responseText��ȡ�������ݻ���ִ���
    // 4 (���) ���ݽ������,��ʱ����ͨ��ͨ��responseBody��responseText��ȡ�����Ļ�Ӧ����
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