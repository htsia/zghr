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
                 alert("���ϴ��ļ���¼���ļ�����!");
                 return false;
             }
             if (document.all('form1:excelFile').value!="" && document.all('form1:filenme').value!=""){
                 alert("�ϴ��ļ���¼���ļ�����ֻ��ѡһ�ַ�ʽ��");
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
                <td class="td_form01">���</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputHidden value="#{eLearn_courcebb.superID}" />
                    <h:inputText readonly="true" value="#{eLearn_courcebb.dicName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">��ʽ1���ϴ��μ�</td>
                <td class="td_form02" align="left">
</c:verbatim>
                    <x:inputFileUpload id="excelFile"   styleClass="input" value="#{eLearn_courcebb.excelFile}"  storage="file" size="25" />
<c:verbatim>
                </td>
            </tr>

            <tr>
               <td class="td_form01">��ʽ2���μ��ļ����ڷ�������</td>
               <td>
</c:verbatim>
               <h:inputText id="filenme" value="#{eLearn_courcebb.fileName}"></h:inputText>
<c:verbatim>
            </td>
            </tr>
            <tr><td colspan="2" height=8></td></tr>
            <tr>
               <td colspan="2">
                   <strong>˵��:</strong>
                   <ul>
                       <li>�ļ�������zipѹ���ļ���</li>
                       <li>��ʽ2�У��μ��ļ��������/file/eLearn�£�ֻ��¼�����ּ���������������ִ�Сд��</li>
                   </ul>
               </td>
            </tr>
        </table>

    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="����" onclick="return doCheck();" action="#{eLearn_courcebb.SaveFile}" styleClass="button01" />
                <h:commandButton value="����"  type="button" onclick="window.close()" styleClass="button01" />
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