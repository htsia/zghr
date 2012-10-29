<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forphoto() {
            var path = document.all("form1:myFileId").value;
            var index = path.lastIndexOf(".");
            var imgtype = path.substring(index + 1);
            imgtype = imgtype.toLowerCase();
            var flag = false;
            if (imgtype == "gif") {
                flag = true;
            } else if (imgtype == "jpg") {
                flag = true;
            }
            if (flag) {
                document.all("form1:upload").click();
                return true;
            } else {
                alert("请选择gif 或jpg 类型文件！");
            }
            return false;
        }
    </script>
<x:saveState value="#{UpPhBB}"></x:saveState>
<h:form id="form1" enctype="multipart/form-data">

    <c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" valign=middle align=left>
        <tr>
            <td width="20%" nowrap>
     </c:verbatim>
                 <x:inputFileUpload id="myFileId"
			      value="#{UpPhBB.myFile}"
			      storage="file"
			      required="true"  styleClass="input" onchange="forphoto();" style="width:150px"/>
                 <h:commandButton value="上传" id="upload"  action="#{UpPhBB.uploadToFile}"  style="display:none" />
                 <h:inputHidden id="url" value="#{UpPhBB.url}"></h:inputHidden>
 <c:verbatim>
            </td>
        </tr>
    </table>
 </c:verbatim>
</h:form>

<script type="text/javascript">
   if (document.getElementById('form1:url').value!="" && document.getElementById('form1:url').value!=null){
       if (window.parent.document.getElementById('picture')!=null){
          window.parent.document.getElementById('picture').value=document.getElementById('form1:url').value;
       }
   }
</script>
