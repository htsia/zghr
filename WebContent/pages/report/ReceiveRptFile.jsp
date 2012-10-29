<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<title>接收表样</title>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function checkSubmit() {
        	
            var filename = document.all("form1:excelFile").value;
            if (filename.substr(filename.length - 3).toLowerCase() == 'xml') {
            	 showProcessBar("block");
                 return true;
            } else {
                alert("请选择XML文件！");
                return false;
            }
        }

        function showProcessBar() {
            x = 8;
            y = (document.body.clientHeight) / 2;
            if (y==0) y=200;
            document.all('processbar').style.top = y;
            document.all('processbar').style.left = x;
            document.all('processbar').style.display = "block";
           }
    </script>
  
<x:saveState value="#{Rpt_DefineListBB}"/>
 
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="435"
     scrollamount="5" scrolldelay="10"  
     bgcolor="#ECF2FF">
<table cellspacing="1" cellpadding="0" align="center">
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


<h:form id="form1" enctype="multipart/form-data">
   <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" align="center" >
        <h:outputText value="选择需要导入的XML表样文件(不包含中文路径)："/>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="95%"   columnClasses="td_form01,td_form02">
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{Rpt_DefineListBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="开始接收" onclick="return checkSubmit();"  action="#{Rpt_DefineListBB.receiveRpt}"
                             />
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
</h:form>
