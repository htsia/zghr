<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forphoto() {
            var path = document.all("form1:myFileId").value;
            var index = path.lastIndexOf(".");
            var imgtype = path.substring(index + 1);

            imgtype = imgtype.toLowerCase();
            if (imgtype == "zip") {
            } else {
                alert("��ѡ��zip �����ļ���");
                return false;
            }
            if (document.all('form1:mode').value==""){
                alert("��ѡ��������ʽ��");
                return false;
            }
            return true;
        }
    </script>

<h:form id="form1" enctype="multipart/form-data">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
         <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-0300","��Ա���� ")%> ->
              <%=LanguageSupport.getResource("RYGL-0328","����������Ƭ")%>  
            </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
 <f:verbatim>
    <table width="80%" border="0" cellspacing="0" cellpadding="0"  align=center>
        <tr><td height="15"></td></tr>
        <tr>
            <td>
                <%=LanguageSupport.getResource("RYGL-2117","1�������Ƭ�ļ�(JPG��ʽ)���涨��ʽ��������28-0054.JGP")%> <br>
                <%=LanguageSupport.getResource("RYGL-2118","2����������Ƭѹ����һ���ļ��У���ʽΪzip�ļ�����photo.zip")%> <br>
                <%=LanguageSupport.getResource("RYGL-2119","3���ϴ����ļ�")%> <br>
                <%=LanguageSupport.getResource("RYGL-2120","4��Ȼ��㱣�浽���ݿ⼴��")%><br>
            </td>
        </tr>

        <tr><td height="15"> <%=LanguageSupport.getResource("RYGL-2121","5��ѡ��������ʽ")%>��
 </f:verbatim>
           <h:selectOneRadio id="mode" value="#{UpPhBB.mode}">
               <c:selectItems value="#{UpPhBB.modeList}"></c:selectItems>
           </h:selectOneRadio>
<f:verbatim>
        </td></tr>

        <tr>
            <td>
 </f:verbatim>
                 <x:inputFileUpload id="myFileId"
			      value="#{UpPhBB.myziPFile}"
			      storage="file"
			      required="true"  styleClass="input"  style="width:300px"/>
                <h:commandButton value="�ϴ�" id="upload"  styleClass="button01" onclick="return forphoto();" action="#{UpPhBB.batchupload}"   />
 <f:verbatim>
            </td>
        </tr>
    </table>
 </f:verbatim>
</h:form>
