<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String pk = request.getParameter("pk");
    String setID = request.getParameter("setID");
    String itemID = request.getParameter("itemID");
    
%>
<script type="text/javascript">
	function fordel(){
		if(confirm('确定删除吗')){
			document.getElementById("form1:del").click();
		}
	}
	function forupload(){
		var file=document.getElementById("form1:myFileId").value;
		if(file!=''){
			document.getElementById("form1:upload").click();			
		}
	}
</script>
<<x:saveState value="#{uploadFileBB}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden id="fileName" value="#{uploadFileBB.pageInit}"/>
	<h:inputHidden value="#{uploadFileBB.pk}"/>
	<h:inputHidden value="#{uploadFileBB.setID}"/>
	<h:inputHidden value="#{uploadFileBB.itemID}"/>
	<h:inputHidden value="#{uploadFileBB.operID}"/>
    <c:verbatim>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" valign=middle align=left>
        <tr>
            <td width="20%" nowrap align="left">
     </c:verbatim>
				<h:outputLink target="_blank" rendered="#{uploadFileBB.filepath!=''}" value="/#{uploadFileBB.filepath}">
					<h:outputText value="查看附件"/>
				</h:outputLink>
				<h:outputText value="  "/>
				<h:outputLink rendered="#{uploadFileBB.filepath!=''}" value="javascript:void(-1);" onclick="return fordel();">
					<h:outputText value="删除"/>
				</h:outputLink>
                 <x:inputFileUpload id="myFileId"
			      value="#{uploadFileBB.myFile}"
			      storage="file" styleClass="input" style="width:150px" onchange="forupload();" rendered="#{uploadFileBB.filepath==''}"/>
                 <h:commandButton value="上传" id="upload" action="#{uploadFileBB.upload}" style="display:none;"/>
                 <h:commandButton id="del" action="#{uploadFileBB.delete}" style="display:none;"/>
 <c:verbatim>
            </td>
        </tr>
    </table>
 </c:verbatim>
</h:form>
