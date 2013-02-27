<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript" contenteditable="inherit">
       function checkSubmit() {
           var filename = form1.all("form1:excelFile").value;
           if (filename.substr(filename.length - 3).toLowerCase() != 'xls') {
               alert("请选择xls文件");
               return false;
           }
           process();
   		return true;
       }
       function process(){
   		x = document.body.clientWidth / 2 - 150;
   		y = document.body.clientHeight / 2;
   		document.all('processbar').style.top = y;
   		document.all('processbar').style.left = x;
   		document.all('processbar').style.display = "";
       }
    </script>

<x:saveState value="#{attOvertimeApplyBB}"></x:saveState>
<h:form id="form1" enctype="multipart/form-data">
    <h:panelGrid align="right" columns="1">
       <h:panelGroup>
           <x:inputFileUpload id="excelFile" styleClass="input" value="#{attOvertimeApplyBB.excelFile}" storage="file" size="20"/>
           <h:commandButton styleClass="button01" value="加班导入" action="#{attOvertimeApplyBB.uploadFile}"
                             onclick="return checkSubmit();"/>
      </h:panelGroup>
    </h:panelGrid>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>