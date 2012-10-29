<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
    String dict_num = request.getParameter("dict_num");
    if (dict_num == null) return;
    String curCode = request.getParameter("curCode");
    String value = request.getParameter("value");
    CodeItemBO code = SysCacheTool.findCodeItem(dict_num, curCode);
    String treeId = "";
    if (code != null) {
        treeId = CommonFuns.filterNull(code.getTreeId());
    }
    if (value == null || "".equals(value)) {
        treeId = "";
    }
%>
<html>
<head><title></title>
<script src="../../../js/tree.js" language="JavaScript"></script>
<script language="javascript">
    var xmlHttp;
    var superId = "";
    var setId = '<%=dict_num%>';
    var targetTreeId = '<%=treeId%>'
    var flag = true;
    //创建XMLHttpRequest对象
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }

    //展示树要调用的事件
    function showTree(pid, rootId) {
        flag = false;
        superId = pid;
        if (rootId == null) rootId = "";
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", "../../ajax/Code.jsp?superId=" + superId + "&rootId=" + rootId, true);
        xmlHttp.send(null);


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

        var trees = results.getElementsByTagName("code");
        var supertree = results.getElementsByTagName("supertree");
        if (superId == setId) {
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
            icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
            childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;

            //动态画树
            var nNode = tree.add(toNode, 'last', name, "n" + key, id, '', icon, '', '');
            if (nNode.parent.first.label.innerText == 'loading...')nNode.parent.first.remove();
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
    var flag = false;
    //定义树的图片对象
    var images = new getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);
    showTree(setId, '<%=CommonFuns.filterNull(request.getParameter("rootId"))%>');//树的根节点
    //定义树的节点的扩展方法
    tree.onexpand = function(srcNode) {
        if (srcNode.first.label.innerText == "loading...")
        {
            if (flag) {
                showTree(srcNode.key2);
            } else {
                event.returnValue = false;
            }
            return true;
        }
    }
    tree.onclick = function(srcNode) {
        parent.refreshList(srcNode.key2);
    }
</script>

</body>
</html>