<%@page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String cancelFlag=CommonFuns.filterNull(request.getParameter("cancelFlag"));
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
    
    String secDeptTreeId=null;
    String secDeptId = CommonFuns.filterNull(request.getParameter("secDeptId"));
    if(secDeptId!=null && !"".equals(secDeptId) && !"null".equals(secDeptId)){
	    OrgBO org = SysCacheTool.findOrgById(secDeptId.substring(4));
	    secDeptTreeId=org.getTreeId();
    }
    if(rightFlag == null || "".equals(rightFlag.trim())){
         rightFlag = "1";
    }
%>
<html>
<head><title></title>
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    <script src="<%=request.getContextPath()%>/js/Appclient.js" language="JavaScript"></script>
    <script language="javascript">
        var xmlHttp;
        var superId = "";

        //����XMLHttpRequest����
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
        }

        //չʾ��Ҫ���õ��¼�
        function showTree(pid, rightFlag, rootId,secDeptTreeId) {
            superId = pid;
            if (rightFlag == null) rightFlag = "";
            if (rootId == null) rootId = "";
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;
            
            xmlHttp.open("GET", "../ajax/Org.jsp?cancelFlag=<%=cancelFlag%>&showGroup=<%=Constants.TREE_SHOW_GROUP%>&superId=" + superId + "&rightFlag=" + rightFlag + "&rootId=" + rootId+"&secDeptTreeId="+secDeptTreeId, true);
            xmlHttp.send(null);
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

        //������xml�ļ��õ��Ľ�� ����̬����
        function parseResults() {
            var results = xmlHttp.responseXML;
            //            alert(results);
            //            alert(xmlHttp.responseText);
            var superorg = null;
            var orgs = null;
            var key = "";
            var name = "";
            var icon = "";
            var id = "";
            var childnum = "";
            var treeid = "";
            var cancel = "";

            var trees = results.getElementsByTagName("org");
            var supertree = results.getElementsByTagName("supertree");
            if (superId == "-1") {
                var toNode = tree.root;
            } else {
                superorg = supertree[0];
                treeid = superorg.getElementsByTagName("treeid")[0].firstChild.nodeValue;
                var toNode = tree.nodes["n" + treeid];
            }

            for (var i = 0; i < trees.length; i++) {
                orgs = trees[i];
                key = orgs.getElementsByTagName("key")[0].firstChild.nodeValue;
                name = orgs.getElementsByTagName("name")[0].firstChild.nodeValue;
                id = orgs.getElementsByTagName("id")[0].firstChild.nodeValue;
                cancel = orgs.getElementsByTagName("cancel")[0].firstChild.nodeValue;
                icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
                childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;

                if (cancel == "1") {
                    name+="(�ѳ���)";
                }
                //��̬����
                var nNode = tree.add(toNode, 'last', name, "n" + key, id, '', icon, '', '');
                if (nNode.parent.first.label.innerText == 'loading...')nNode.parent.first.remove();
                if (childnum != 0) {
                    nNode.add('loading...');
                    nNode.expand(false);
                }
            }

            //չ�����ڵ�
            try {
                rootNodes = tree.root.children;
                for (i = 0; i < rootNodes.length; i++) {
                    if (rootNodes[i].first.label.innerText == "loading...") {
                        rootNodes[i].expand(true);
                        break;
                    }
                }
            } catch(e) {

            }
        }
        //document.oncontextmenu=function(e){return false;}
    </script>
</head>

<body topmargin="0" leftmargin="0" BGCOLOR=<%=Constants.BGCOLOR%>>
<div id="tt"></div>
<script language="javascript">
    //��������ͼƬ����
    var images = getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, tt);
    showTree("-1", "<%=rightFlag%>", "<%=rootId%>","<%=secDeptTreeId%>");//���ĸ��ڵ�
    //�������Ľڵ����չ����
    tree.onexpand = function(srcNode) {
        if (srcNode.first.label.innerText == "loading..."){
            showTree(srcNode.key2, "<%=rightFlag%>", "","<%=secDeptTreeId%>");
        }
        return true;
    }

    tree.onclick = function(srcNode) {
        parent.refreshList(srcNode.key2);
    }
</script>

</body>
</html>