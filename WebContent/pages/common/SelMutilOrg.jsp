<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String dict_num = request.getParameter("dict_num");
    if (dict_num == null) return;
    String curCode = request.getParameter("curCode");
    String codes = "";
    String trees = "";

    if (curCode != null && !"".equals(curCode)) {
        String[] codeArrray = curCode.split(",");
        for (int i = 0; i < codeArrray.length; i++) {
            OrgBO org = SysCacheTool.findOrgById(codeArrray[i]);
            if (org != null)
                trees += ",'" + org.getTreeId() + "'";
        }
        trees = trees.substring(1);
    }

    String value = request.getParameter("value");
    if (value == null || "".equals(value)) {
        trees = null;
    }
%>
<html>
<head><title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
<script src="<%=request.getContextPath()%>/js/tree_check.js" language="JavaScript"></script>
<script src="<%=request.getContextPath()%>/js/Appclient.js" language="JavaScript"></script>
<script language="javascript">
var xmlHttp;
var superId = "";
var treeIds = <%=("".equals(trees) ? "null" : "[''," + trees + "]")%>
var targetTreeId = "";
var pos = 1;
var flag = true;
//创建XMLHttpRequest对象
function expandTreeNode(nNode) {
    pos++;
    if (pos < treeIds.length) {
        targetTreeId = treeIds[pos];
        for (i = 1; i <= targetTreeId.length / 3; i++) {
            myNode = tree.nodes["n" + targetTreeId.substr(0, i * 3)];
            try {
                if (!myNode.expanded) {
                    myNode.expand(true);
                    break;
                } else {
                    if (myNode.getKey() == 'n' + targetTreeId) {
                        myNode.checkBox.checked = true;
                        expandTreeNode(null)
                    }
                }
            } catch(e) {
            }
        }
    }
}
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

    } else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}

//展示树要调用的事件
function showTree(pid, rightFlag, rootId) {
    flag = false;
    if (rightFlag == null) rightFlag = "";
    if (rootId == null) rootId = "";
    superId = pid;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.open("GET", "/pages/ajax/Org.jsp?superId=" + superId + "&rightFlag=" + rightFlag + "&rootId=" + rootId, true);
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
    var expandNode = null;
    for (var i = 0; i < trees.length; i++) {
        orgs = trees[i];
        key = orgs.getElementsByTagName("key")[0].firstChild.nodeValue;
        name = orgs.getElementsByTagName("name")[0].firstChild.nodeValue;
        id = orgs.getElementsByTagName("id")[0].firstChild.nodeValue;
        cancel = orgs.getElementsByTagName("cancel")[0].firstChild.nodeValue;
        icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
        childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;
        if (cancel == "1") {
            continue;
        }
        //动态画树
        var nNode = tree.addChkNode(toNode, 'last', name, "n" + key, id, '', icon, '', '', false, true);
        if (nNode.parent.first.label.innerText == 'loading...')nNode.parent.first.remove();
        if (childnum != 0) {
            nNode.add('loading...');
            nNode.expand(false);
        }

        if (targetTreeId != null && targetTreeId.substr(0, (nNode.getKey().length - 1)) == nNode.getKey().substr(1)) {
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
        try {
            tree.nodes['n' + targetTreeId].focus();
        } catch(e) {
        }
        tree.nodes['n' + targetTreeId].checkBox.checked = true;
        //递归
        expandTreeNode(null);
    }
    rootNodes = tree.root.children;
    for (i = 0; i < rootNodes.length; i++) {
        if (rootNodes[i].first!=null && rootNodes[i].first.label.innerText == "loading...") {
            rootNodes[i].expand(true);
            break;
        }
    }
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table>
   <tr><td align="left">
        <input type="button" value="选择" onclick="doSel()" class="button01">
        <input type="button" value="清除" onclick="doClear()" class="button01">
   </td></tr>

  <tr><td>
    <div id="tt"></div>
 </td></tr>
</table>
<script language="javascript">
    var flag = false;
    //定义树的图片对象
    var images = getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);
    if (treeIds != null)
        targetTreeId = treeIds[pos];
    showTree("-1", '<%=CommonFuns.filterNull(request.getParameter("rightFlag"))%>', '<%=CommonFuns.filterNull(request.getParameter("rootId"))%>');//树的根节点

    //定义树的节点的扩展方法
    tree.onexpand = function(srcNode)
    {
        if (srcNode.first.label.innerText == "loading...")
        {
            if (flag) {
                showTree(srcNode.key2);
            } else
                try{
                    event.returnValue = false;
                }catch(e){
                }
        }

        return true;
    }
    tree.onclick = function(srcNode) {

    }

    function doSel() {
        var ids = "";
        var names = "";
        count = tree.nodes.length;
        for (i = 0; i < count; i++) {
            if (tree.nodes[i].label.innerText != 'loading...' && tree.nodes[i].checkBox.checked) {
                ids += "," + tree.nodes[i].key2;
                names += "," + tree.nodes[i].label.innerText;
            }
        }
        if (count > 0) {
            ret = ids.substr(1) + "|" + names.substr(1);

            window.returnValue = ret;
            window.close();
        } else {
            window.returnValue = null;
            window.close()
        }
    }
    function doClear() {
         try{
            count = tree.nodes.length;
            for (i = 0; i < count; i++) {
                if (tree.nodes[i].label.innerText != 'loading...')
                    tree.nodes[i].checkBox.checked = false;
            }
          }catch(e){

         }
    }
</script>

</body>
</html>