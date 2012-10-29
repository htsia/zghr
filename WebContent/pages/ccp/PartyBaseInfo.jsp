<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	String flag = (String) request.getAttribute("flag");//
	String setId = CommonFuns.filterNull(request.getParameter("setId"));//

	String fk = CommonFuns.filterNull(request.getParameter("fk"));
	String pk = CommonFuns.filterNull(request.getParameter("pk"));
	String type = CommonFuns.filterNull(request.getParameter("type"));//
	String isEdit = "true";
	if ("1".equals(type)) {
		isEdit = "false";
	}

	String isCheckRight = CommonFuns.filterNull(request
			.getParameter("isCheckRight"));
	if ("".equals(isCheckRight)) {
		isCheckRight = "true";
	}
%>


<script type="text/javascript">
    var setId = "<%=setId%>";
    var fk = "<%=fk%>";
    var pk = "<%=pk%>";
    var info = "";
    var xmlHttp;
    //创建XMLHttpRequest对象
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }

    //校验要调用的事件
    function doPost() {
        var queryString = createQueryString();
        createXMLHttpRequest();
        xmlHttp.open("POST", "/pages/ajax/Check.jsp", false);
        xmlHttp.onreadystatechange = handleStateChange;                                     
        xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
        xmlHttp.send(queryString);
    }

    //创建参数串
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

        queryString += "setId=" + setId;
        //alert(queryString);
        return queryString;
    }

    //XMLHttpRequest状态改变时要执行的函数
    function handleStateChange() {
        if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
                //解析从xml文件得到的结果,动态画树
                parseResults();
            }
        }
    }

    //解析从xml文件得到的结果
    function parseResults() {
        var results = xmlHttp.responseXML;
        var orgs = null;
        var trees = results.getElementsByTagName("message");
        for (var i = 0; i < trees.length; i++) {
            orgs = trees[i];
            info = orgs.getElementsByTagName("info")[0].firstChild.nodeValue;
        }
    }
    //校验
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
            form.save.disabled = true;
            if (flag == "1") {
                document.all("form1:saveManyAdd").click();
            } else if (flag == "6") {
                document.all("form1:saveManyUpdate").click();
            } else {
                document.all("form1:saveOne").click();
            }
        }
        return true;
    }
    function forBack(){
        document.all("form1:back").click();
        return true;
     }

  
</script>

<h:inputHidden value="#{ccp_PartyEditBB.table}" />
<h:form id="form1">
	  <c:verbatim>
    <input type="hidden" name="isCheckRight" value="<%=isCheckRight%>">
    </c:verbatim>
     <h:commandLink  id="saveOne" action="#{ccp_PartyEditBB.saveSingleSetInfo}" style="display:none"/>
	<h:commandButton id="addMany" action="#{ccp_PartyEditBB.addMany}"   style="display:none" />
	<h:commandButton id="updateMany" action="#{org_orgEditBB.updateMany}"	style="display:none" />
	<h:commandButton id="delMany" action="#{ccp_PartyEditBB.delMany}" style="display:none" />
	<h:commandLink   id="back" action="#{org_orgEditBB.back}" 	style="display:none" />
	<c:verbatim>
		<jsp:include page="/pages/common/activepage/ActiveDetail.jsp">
			<jsp:param name="isEdit" value="<%=isEdit%>" />
		</jsp:include>
	</c:verbatim>
</h:form>
