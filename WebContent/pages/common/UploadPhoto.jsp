<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String id = request.getParameter("imageId");
    String pk = request.getParameter("pk");
    String itemid = request.getParameter("imageItemId");
    InfoItemBO itembo = SysCacheTool.findInfoItem("",itemid);
    String str = "";
    if (id != null && !"".equals(id)) {
        str = "<a href='/pages/common/photo.jsp?height="+CommonFuns.filterNull(itembo.getItemMax())+"&width="+CommonFuns.filterNull(itembo.getItemMin())+"&id=" + id + "' target='_blank'>查看</a>";
        str += "&nbsp;<a onmouseover='style.cursor = \"hand\";' onclick='deletePhotoField(\"" + pk + "\",\"" + itemid + "\")'>删除</a>";
    }
%>
    <script type="text/javascript">
        function deletePhotoField(pk,itemID){
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;
            retval = window.showModalDialog("/common/deletePhotoField.jsf?pk="+pk+"&itemID="+itemID, "", "dialogWidth:300px; dialogHeight:150px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:0");
            if (retval=="ok"){
                if (document.all("imageItemId").value=="A001780"){
                    parent.document.all.seryFilterDiv.style.display = "none";
                    parent.document.all.showZP.src = "";
                }
                else if (document.all("imageItemId").value=="A001786"){
                    parent.document.all.seryFilterDiv2.style.display = "none";
                    parent.document.all.showSFZ.src = "";
                }
                else if (document.all("imageItemId").value=="B001082"){
                    parent.document.all.seryFilterDiv.style.display = "none";
                    parent.document.all.showZP.src = "";
                }
                // 刷新父窗口
                if (parent.document.all("form1:refreshDataButton")!=null){
                    parent.document.all("form1:refreshDataButton").click();
                }

            }
        }
        function forphoto() {
            var path = document.all("form1:myFileId").value;
            var index = path.lastIndexOf(".");
            var imgtype = path.substring(index + 1);
            imgtype = imgtype.toLowerCase();
            var d = new Date();
			var filename11 = d.getTime()+"."+imgtype;
            path="/file/phototemp/"+filename11;
            var flag = false;
            if (imgtype == "gif") {
                flag = true;
            } else if (imgtype == "jpg") {
                flag = true;
            }
            if (flag) {
            	document.all("form1:fileName").value=filename11;
                parent.photoID=document.all("imageItemId").value;
                parent.photoSrc=path;
                document.all("form1:upload").click();
                return false;
            } else {
                alert("请选择gif 或jpg 类型文件！");
            }
            return false;
        }
    </script>

<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="fileName" value="#{UpPhBB.fileName}"/>
    <c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" valign=middle align=left>
        <tr>
            <td width="20%" nowrap align="left">
                 <input type="hidden" name="imageItemId" value="<%=CommonFuns.filterNull(request.getParameter("imageItemId"))%>">
                 <input type="hidden" name="imageId" value="<%=CommonFuns.filterNull(request.getParameter("imageId"))%>">
     </c:verbatim>
                 <x:inputFileUpload id="myFileId"
			      value="#{UpPhBB.myFile}"
			      storage="file"
			      required="true"  styleClass="input" onchange="forphoto();" style="width:150px"/>
    <c:verbatim>
                 <%=str%>
    </c:verbatim>
                 <h:commandButton value="上传" id="upload"  action="#{UpPhBB.upload}"  style="display:none" />
 <c:verbatim>
            </td>
        </tr>
    </table>
 </c:verbatim>
</h:form>
    <script type="text/javascript">
<%
    if (session.getAttribute(itemid)!=null){
        out.println("parent.setLoadPhoto();");
    }
%>
    </script>
