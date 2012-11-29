<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.lead.pojo.bo.LeadOrgBO" %>

<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user == null) {
        response.sendRedirect("/pages/overtime.jsp");
    }
    String paramUnitId = request.getParameter("unitId");
    PersonBO person = SysCacheTool.findPersonById(user.getUserId());
    LeadOrgBO unit = SysCacheTool.findLeadUnit(person.getOrgId());
    String treeId = "";
    String filterTreeId = "";
    boolean flag = false;
    if (user.ischo() && User.AllUNIT.equals(user.getprocessUnit())) {
        treeId = "001";
        filterTreeId = treeId;
    } else {
        if (unit==null) return;   
        treeId = unit.getTreeId();
        filterTreeId = treeId;
    }

    String target = treeId;
    if (paramUnitId != null && !"".equals(paramUnitId)) {
        LeadOrgBO paramunit = SysCacheTool.findLeadUnit(paramUnitId);
        if (paramunit!=null)   target = paramunit.getTreeId();
    }
    String canClick = "1";
    if (treeId.length() > 6)
        canClick = "0";
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    <script language="javascript">
        var xmlHttp;
        var superId = "";
        var filterTreeId = "<%=filterTreeId%>"
        var flag = '<%=flag%>';
        var targetTreeId = '<%=target%>'

        //展示树要调用的事件
        function showTree(pid) {
            superId = pid;
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("GET", "/pages/ajax/LeadUnit.jsp?superId=" + superId + "&filter=" + filterTreeId, true);
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
                var nNode = tree.add(toNode, 'last', name, "n" + key, id, childnum, icon, '', '');
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
                tree.nodes['n' + targetTreeId].focus();
                tree.nodes['n' + targetTreeId].label.style.color = "white";
                tree.nodes['n' + targetTreeId].label.style.backgroundColor = "#3179CE";
            }
        }
    </script>
</head>

<body>
<div id="tt"></div>
<script language="javascript">
    <%
        if ("1".equals(request.getParameter("inLead"))){
           out.println("    inLead=1;");
        }
    %>
    
    //定义树的图片对象
    var images = new getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);

    showTree("-1");//树的根节点

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
        var cc = "<%=canClick%>";
        if (cc == 0) {
            if (srcNode.parent != tree.root) {
                parent.refreshList(srcNode.key2, srcNode.alt);
            }
        } else
            parent.refreshList(srcNode.key2, srcNode.alt);
    }
</script>
</body>
</html>