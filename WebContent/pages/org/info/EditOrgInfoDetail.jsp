<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String flag = (String) request.getAttribute("flag");
    String setId = CommonFuns.filterNull(request.getParameter("setId"));
    String fk = CommonFuns.filterNull(request.getParameter("fk"));
    String pk = CommonFuns.filterNull(request.getParameter("pk"));
    String type = CommonFuns.filterNull(request.getParameter("type"));
    String isEdit = "true";
    if("1".equals(type)){
         isEdit = "false";
    }
%>

<script type="text/javascript">
    var setId = "<%=setId%>";
    var fk = "<%=fk%>";
    var pk = "<%=pk%>";
    var info = "";
    var xmlHttp;
    //����XMLHttpRequest����
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }

    //У��Ҫ���õ��¼�
    function doPost() {
        var queryString = createQueryString();
        createXMLHttpRequest();
        xmlHttp.open("POST", "/pages/ajax/Check.jsp", false);
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
        xmlHttp.send(queryString);


    }
    //����������
    function createQueryString() {
        var queryString = "";
        var name = "";
        var svalue = "";
        for (i = 0; i < document.forms(0).length; i++) {
            obj = document.forms(0).elements[i];
            name = obj.name;
            if (obj.dict == "yes") {
                svalue = obj.code;
            } else {
                svalue = obj.value;
            }
            queryString += name + "=" + svalue + "&";
        }

        queryString += "setId = " + setId;
        return queryString;

    }
    //XMLHttpRequest״̬�ı�ʱҪִ�еĺ���
    function handleStateChange() {
        if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
                //������xml�ļ��õ��Ľ��,��̬����
                parseResults();
            }
        }
    }

    //������xml�ļ��õ��Ľ��
    function parseResults() {
        var results = xmlHttp.responseXML;
        //alert(xmlHttp.responseText);
        var orgs = null;
        var trees = results.getElementsByTagName("message");
        for (var i = 0; i < trees.length; i++) {
            orgs = trees[i];
            info = orgs.getElementsByTagName("info")[0].firstChild.nodeValue;
        }
    }
    //У��
    function ajaxCheck(form) {
        doPost();
        if (info != null && info != "" && info != "no") {
            alert(info);
            return false;
        } else {
            return forsubmit(form)
        }
    }
    var flag = "<%=flag%>";
    function forsave(form) {
        if (ajaxCheck(form)) {
                document.all("form1:saveOne").click();
        }
        return true;
    }

    function forBack() {
        window.close();
    }
</script>

<x:saveState value="#{org_orgEditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{org_orgEditBB.pageInit}"></h:inputHidden>
    <h:inputHidden value="#{org_orgEditBB.setId}"></h:inputHidden>
    <h:inputHidden value="#{org_orgEditBB.fk}"></h:inputHidden>
    <h:inputHidden value="#{org_orgEditBB.pk}"></h:inputHidden>
    <h:commandLink id="saveOne" action="#{org_orgEditBB.saveInputView}" style="display:none"/>
    <c:verbatim>
    <table height=98% width=98% align="center">
     <tr><td height=6 align=right>
    </c:verbatim>
         <h:selectOneMenu id="mb" value="#{org_orgEditBB.mb}">
             <c:selectItems value="#{org_orgEditBB.mbList}"></c:selectItems>
         </h:selectOneMenu>

         <h:commandButton value="��ʼ¼��" action="#{org_orgEditBB.changeView}" styleClass="button01"></h:commandButton>
<c:verbatim>
     </td></tr>
     <tr><td >
        <jsp:include page="/pages/common/activepage/ActiveDetail.jsp">
            <jsp:param name="isEdit" value="<%=isEdit%>"/>
        </jsp:include>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
