<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    
    <script type="text/javascript">
         function doCheck(){
             if (document.all('form1:excelFile').value=="" && document.all('form1:filenme').value==""){
                 alert("请上传文件或录入文件名称!");
                 return false;
             }
             if (document.all('form1:excelFile').value!="" && document.all('form1:filenme').value!=""){
                 alert("上传文件或录入文件名称只能选一种方式！");
                 return false;
             }
            showProcessBar();
            return true;
        }
         function showProcessBar() {
            x = document.body.clientWidth / 2 - 150;
            y = document.body.clientHeight / 2;
            document.all('processbar').style.top = y;
            document.all('processbar').style.left = x;
            document.all('processbar').style.display = "";
         }

    </script>

<x:saveState value="#{eLearn_courcebb}"/>
<h:form id="form1" enctype="multipart/form-data">
        <h:inputHidden id="pageInit" value="#{eLearn_courcebb.initFile}"/>
<c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td class="td_form01">类别</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputHidden value="#{eLearn_courcebb.superID}" />
                    <h:inputText readonly="true" value="#{eLearn_courcebb.dicName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">方式1、上传课件</td>
                <td class="td_form02" align="left">
</c:verbatim>
                    <x:inputFileUpload id="excelFile"   styleClass="input" value="#{eLearn_courcebb.excelFile}"  storage="file" size="25" />
<c:verbatim>
                </td>
            </tr>

            <tr>
               <td class="td_form01">方式2、课件文件已在服务器上</td>
               <td>
</c:verbatim>
               <h:inputText id="filenme" value="#{eLearn_courcebb.fileName}"></h:inputText>
<c:verbatim>
            </td>
            </tr>
            <tr><td colspan="2" height=8></td></tr>
            <tr>
               <td colspan="2">
                   <strong>说明:</strong>
                   <ul>
                       <li>文件必须是zip压缩文件。</li>
                       <li>方式2中，课件文件必须放在/file/eLearn下，只需录入名字即可输入的名字区分大小写。</li>
                   </ul>
               </td>
            </tr>
        </table>

    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="发布" onclick="return doCheck();" action="#{eLearn_courcebb.SaveFile}" styleClass="button01" />
                <h:commandButton value="返回"  type="button" onclick="window.close()" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
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