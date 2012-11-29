<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.bo.RoleInfoBO" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user == null) {
        response.sendRedirect("/pages/overtime.htm");
    }
    String treeId = user.getOrgId();
    String root = "-1";
    if (!RoleInfoBO.ORGTYPE_ALL.equals(user.getprocessUnit()) ){
        root=user.getOrgId();
    }
%>
<html>
<head>
     <title>
    </title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    
    <script language="javascript">
        var xmlHttp;
        var superId = "";
        var targetTreeId = '<%=treeId%>'

        //展示树要调用的事件
        function showTree(pid) {
            superId = pid;
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("GET", "/pages/ajax/LeadUnit.jsp?superId=" + superId, true);
            xmlHttp.send(null);
        }

        //创建XMLHttpRequest对象
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
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

        //解析从xml文件得到的结果 ，动态画树
        function parseResults() {
            var results = xmlHttp.responseXML;
            var superorg = null;
            var orgs = null;
            var key = "";
            var name = "";
            var icon = "";
            var id = "";
            var childnum = "";
            var treeid = "";

            var trees = results.getElementsByTagName("org");
            var supertree = results.getElementsByTagName("supertree");

            if (superId == "-1") {
                var toNode = tree.root;
            } else {
                superorg = supertree[0];
                treeid = superorg.getElementsByTagName("treeid")[0].firstChild.nodeValue;
                var toNode = tree.nodes["n" + treeid];
            }

            var expandNode = null;
            for (var i = 0; i < trees.length; i++) {
                orgs = trees[i];
                key = orgs.getElementsByTagName("key")[0].firstChild.nodeValue;
                name = orgs.getElementsByTagName("name")[0].firstChild.nodeValue;
                id = orgs.getElementsByTagName("id")[0].firstChild.nodeValue;
                treeId = orgs.getElementsByTagName("treeId")[0].firstChild.nodeValue;
                icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
                childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;
                len = treeId.length;
                //动态画树
                var nNode = tree.add(toNode, 'last', name, "n" + key, id, '', icon, '', '');
                if (nNode.parent.first.label.innerText == 'loading...')
                    nNode.parent.first.remove();
                if (childnum != 0) {
                    nNode.add('loading...');
                    nNode.expand(false);
                }
                if (targetTreeId.substr(0, (nNode.getKey().length - 1)) == nNode.getKey().substr(1)) {
                    expandNode = nNode;
                }
            }
            //do expand定位选中机构
            flag = true;
            if (expandNode != null) {
                if (expandNode.getKey().substr(1).length < targetTreeId.length) {
                    expandNode.expand(true);
                }
            }
            if (tree.nodes['n' + targetTreeId] != null) {
                try{
                tree.nodes['n' + targetTreeId].focus();
                }catch(e){}
                tree.nodes['n' + targetTreeId].label.style.color = "white";
                tree.nodes['n' + targetTreeId].label.style.backgroundColor = "#3179CE";
                targetTreeId = '';
            }
        }
    </script>
</head>

<body> 
<div id="tt"></div>
<script language="javascript">
    //定义树的图片对象
    var images = getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);

    showTree("<%=root%>");//树的根节点

    //定义树的节点的扩展方法
    tree.onexpand = function(srcNode) {
        if (srcNode.first.label.innerText == "loading...") {
            showTree(srcNode.key2);
        }
        return true;
    }
    tree.onclick = function(srcNode) {
        if (tree.nodes['n' + targetTreeId] != null && tree.nodes['n' + targetTreeId] != srcNode) {
            tree.nodes['n' + targetTreeId].label.style.color = "black";
            tree.nodes['n' + targetTreeId].label.style.background = "";
        }
        window.returnValue = srcNode.key2 + "," + srcNode.label.innerText;
        window.close();
    }
</script>
</body>
</html>
