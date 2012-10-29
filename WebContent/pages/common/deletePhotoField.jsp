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
<h:form id="form1" >
    <h:inputHidden value="#{common_UpPhBB.deleteInit}"></h:inputHidden>
    <h:inputHidden value="#{common_UpPhBB.field}"></h:inputHidden>
    <h:inputHidden value="#{common_UpPhBB.pk}"></h:inputHidden>
    <c:verbatim>
    <table width="98%" height="98%" border="0" cellspacing="0" cellpadding="0"  align="center">
        <tr>
            <td nowrap height="20" >
            </td>
        </tr>
        
        <tr>
            <td nowrap height="20" >
                 您准备删除以下信息，如确定无误请按删除按钮：<br><br>
     </c:verbatim>
                 <h:outputText value="#{common_UpPhBB.deleteDes}"></h:outputText>
    <c:verbatim>
             </td>
        </tr>
        <tr>
            <td align="right">
     </c:verbatim>
                 <h:commandButton value="删除" id="upload"  action="#{common_UpPhBB.deletePhoto}"  styleClass="button01"/>
                 <h:commandButton value="取消" onclick="window.close();"  styleClass="button01"/>
     <c:verbatim>
            </td>
        </tr>
    </table>
 </c:verbatim>
</h:form>

