<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
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
	    xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
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
	
	    queryString += "setId = C001";
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
	        return forsubmit(form);
	    }
	}
	function forsave(form) {
	    if (ajaxCheck(form)) {
	    	document.all("form1:saveOne").click();
	    }
	    return true;
	}
</script>
<x:saveState value="#{post_PostAddBB}"/>
<h:inputHidden value="#{post_PostAddBB.pageInit}"/>
<h:form id="form1">
	<f:verbatim>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">岗位维护 -> 新增岗位</td>
        </tr>
    </table>
    </f:verbatim>
    <h:commandLink id="saveOne" action="#{post_PostAddBB.saveOne}" style="display:none"/>
    <c:verbatim>
        <jsp:include page="/pages/common/activepage/ActiveDetail.jsp">
            <jsp:param name="isEdit" value="true"/>
        </jsp:include>
    </c:verbatim>
</h:form>