<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>  
    <script type="text/javascript">        
        function checkSubmit() {           
            var filename = form1.all("form1:excelFile").value;
            var obj = form1.rsItem;
            if (filename.substr(filename.length - 3) == 'TXT') {
                    return true;
            }else if(filename.substr(filename.length - 3) == 'txt'){
          	  return true;
            }else if(filename.substr(filename.length - 3) == 'CSV'){
          	  return true;
            }else if(filename.substr(filename.length - 3) == 'csv'){
            	  return true;
             }else if(filename.substr(filename.length - 3) == 'XLS'){
            	  return true;
             } else if(filename.substr(filename.length - 3) == 'xls'){
            	  return true;
             } else {
                alert("请选择TXT,CSV,XLS文件！");
                return false;
            }
        }
    </script>

<x:saveState value="#{att_DataUploadBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{att_DataUploadBB.initBySet}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 导入考勤打卡数据"/>
        </h:panelGroup>
    </h:panelGrid>
     <c:verbatim><br></c:verbatim>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form01,td_form01">
        <h:panelGroup>
            <h:outputText value="选择需要应用的文件导入规则:"/>
            <h:selectOneMenu id="mType" onchange="submit()" value="#{att_DataUploadBB.atttype}"
                             valueChangeListener="#{att_DataUploadBB.changeStatus}">
                <c:selectItems value="#{att_DataUploadBB.lists}"/>
            </h:selectOneMenu>
        </h:panelGroup>
    </h:panelGrid>





    <h:panelGrid columns="2" align="center" width="95%" styleClass="table03" columnClasses="td_form01,td_form02">
        <h:outputText value="上传导入文件:"/>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{att_DataUploadBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="上传" action="#{att_DataUploadBB.uploadFile}" onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
