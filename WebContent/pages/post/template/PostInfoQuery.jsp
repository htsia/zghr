<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String setId = "C001";
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/post/info/PostEditInfo.jsf?pk=" + id + "&type=" + type, "aa", "status=no,toolbar=no,menubar=no,location=no", "900", "600", "no");
        }

        function forAdd(form, flag, type) {
            windowOpen("/post/template/PostTempAdd.jsf", "", "status=no,toolbar=no,menubar=no,location=no", "900", "600", "no");
        }

        function forExport() {
            windowOpen("/pages/common/ExportToExcel.jsf", "", "status=no,toolbar=no,menubar=no,location=no", "900", "600", "no");
        }
        function forDel() {
            if (checkMutilSelect(document.forms(0).chk)) {
                if (confirm('确认删除？删除后岗位模板将不能恢复！')) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择要删除处理的岗位模板");
                return false;
            }
        }
        function forAdQry(){
            doAdvanceQuery("C","ORG","111","Y","","C001.C001730 = '00901'","Y","<%=Constants.DEFAULT_QUERY_POST%>","Y","1");
            forsubmit(document.forms(0));
         }
    </script>
</head>

<body>
<x:saveState value="#{post_postTemplateListBB}"/>
<h:form id="form1">
    <h:inputHidden id="tempList" value="#{post_postTemplateListBB.tempList}"/>
    <h:inputHidden id="postId" value="#{post_postTemplateListBB.postId}"/>   
    <input type="hidden" name="sessionFlag" value="2">
    <input type="hidden" name="setId" value=<%=setId%>>
    <h:panelGrid width="100%" columns="2" border="0" cellspacing="0" cellpadding="0" align="center" styleClass="td_page">
        <h:panelGroup>
            <f:verbatim>
                <%=LanguageSupport.getResource("JGGL-1094"," 模板名称")%>:
            </f:verbatim>
            <h:inputText id="postName" value="#{post_postTemplateListBB.postName}" size="10"/>
            <h:outputText value=" "/>
             <f:verbatim>
                <%=LanguageSupport.getResource("JGGL-1079"," 岗位分类")%>:
            </f:verbatim>
            <h:inputText id="postType" value="#{post_postTemplateListBB.postType}" dict_num="0900" code="" dict="yes"
                         size="20"/>
            <h:commandButton value=" " type="button" styleClass="button_select"
                             onclick="PopUpCodeDlgOneControl('form1:postType')"/>
            <h:outputText value=" "/>
            <h:commandButton value="查询" styleClass="button01" onclick="return forsubmit(document.forms(0))" action="#{post_postTemplateListBB.queryPostTemplate}"/>
            <h:outputText value=" "/>
            <h:commandButton value="高级查询" type="button" styleClass="button01" onclick="javascript:return forAdQry();"/>
        </h:panelGroup>
        <h:panelGroup>
            <h:commandButton value="新增" type="button" styleClass="button01" onclick="forAdd(document.forms(0),'1')"/>
            <h:outputText value=" "/>
            <h:commandButton value="删除" styleClass="button01" onclick="return forDel()"
                             action="#{post_postTemplateListBB.deletePostTemplates}"/>
            <h:outputText value=" "/>
            <h:commandButton value="导出到Excel" type="button" styleClass="button01" onclick="forExport()"/>
        </h:panelGroup>
    </h:panelGrid>
    <f:verbatim><br></f:verbatim>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="true"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
        <jsp:param name="isRow" value="true"/>
        <jsp:param name="rowFuncName" value="forView"/>
        <jsp:param name="isPage" value="true"/>
    </jsp:include>
</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</body>
</html>