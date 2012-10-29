<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
    <script type="text/javascript">
        function forphoto() {
            var path = document.all("form1:myFileId").value;
            var index = path.lastIndexOf(".");
            var imgtype = path.substring(index + 1);
            imgtype = imgtype.toLowerCase();
            index = path.lastIndexOf("\\");
            var filename=path.substring(index + 1);
            path="/file/phototemp/"+filename;

            var flag = false;
            if (imgtype == "gif") {
                flag = true;
            } else if (imgtype == "jpg") {
                flag = true;
            }
            if (flag) {
                return true;
            } else {
                alert("请选择gif 或jpg 类型文件！");
            }
            return false;
        }
    </script>
<x:saveState value="#{common_UpPhBB}"></x:saveState>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{common_UpPhBB.pageInit}"></h:inputHidden>
    <h:inputHidden value="#{common_UpPhBB.field}"></h:inputHidden>
    <h:inputHidden value="#{common_UpPhBB.pk}"></h:inputHidden>
    <c:verbatim>
    <table width="98%" height="98%" border="0" cellspacing="0" cellpadding="0"  align="center">
        <tr>
            <td nowrap height="20" >
     </c:verbatim>
                 <x:inputFileUpload id="myFileId"
			      value="#{common_UpPhBB.myFile}"
			      storage="file"
			      required="true"  styleClass="input" onchange="forphoto();" style="width:400px"/>
                 <h:commandButton value="保存" id="upload"  action="#{common_UpPhBB.upload}"  styleClass="button01" rendered="#{common_UpPhBB.canEdit}"/>
                 <h:commandButton value="取消" onclick="window.close();"  styleClass="button01"/>
 <c:verbatim>
            </td>
        </tr>

     <tr>
         <%
             String img = CommonFuns.filterNull((String)session.getAttribute("imgID"));
             String height= CommonFuns.filterNull((String)session.getAttribute("height"));
             String width= CommonFuns.filterNull((String)session.getAttribute("width"));
         %>
         <td valign="top" width="center">
             <br>
             <jsp:include page="/pages/common/photo.jsp">
                 <jsp:param name="id" value="<%=img%>"/>
                 <jsp:param name="height" value="<%=height%>"/>
                 <jsp:param name="width" value="<%=width%>"/>
             </jsp:include>
         </td>
     </tr>

    </table>
 </c:verbatim>
</h:form>

