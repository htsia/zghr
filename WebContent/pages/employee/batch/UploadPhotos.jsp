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
                alert("请选择zip 类型文件！");
                return false;
            }
            if (document.all('form1:mode').value==""){
                alert("请选择命名方式！");
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
              <%=LanguageSupport.getResource("RYGL-0300","人员管理 ")%> ->
              <%=LanguageSupport.getResource("RYGL-0328","批量导入照片")%>  
            </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
 <f:verbatim>
    <table width="80%" border="0" cellspacing="0" cellpadding="0"  align=center>
        <tr><td height="15"></td></tr>
        <tr>
            <td>
                <%=LanguageSupport.getResource("RYGL-2117","1、请把照片文件(JPG格式)按规定方式命名，如28-0054.JGP")%> <br>
                <%=LanguageSupport.getResource("RYGL-2118","2、把所有照片压缩到一个文件中，格式为zip文件。如photo.zip")%> <br>
                <%=LanguageSupport.getResource("RYGL-2119","3、上传该文件")%> <br>
                <%=LanguageSupport.getResource("RYGL-2120","4、然后点保存到数据库即可")%><br>
            </td>
        </tr>

        <tr><td height="15"> <%=LanguageSupport.getResource("RYGL-2121","5、选择命名方式")%>：
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
                <h:commandButton value="上传" id="upload"  styleClass="button01" onclick="return forphoto();" action="#{UpPhBB.batchupload}"   />
 <f:verbatim>
            </td>
        </tr>
    </table>
 </f:verbatim>
</h:form>
