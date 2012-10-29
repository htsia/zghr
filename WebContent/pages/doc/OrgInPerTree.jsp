<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.cache.SysCache"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    SysCache.loadOrgMap();
   String cancelFlag = request.getParameter("cancel");
%>
<html>
<head><title></title>
    <script src="../../js/tree.js" language="JavaScript"></script>
    <script src="../../js/Appclient.js" language="JavaScript"></script>
    <script language="javascript">
        var xmlHttp;
        var superId = "";
        var cancelFlag = "<%=CommonFuns.filterNull(cancelFlag)%>";

        //创建XMLHttpRequest对象
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
        }

        //展示树要调用的事件
        function showTree(pid,rightFlag,rootId) {
            superId = pid;
            if(rightFlag == null) rightFlag = "";
            if(rootId == null) rootId = "";
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("GET", "../ajax/OrgInPer.jsp?superId=" + superId + "&rightFlag=" + rightFlag + "&rootId=" + rootId, true);
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
            //            alert(results);
            //            alert(xmlHttp.responseText);
            var superorg = null;
            var orgs = null;
            var key = "";
            var name = "";
            var icon = "";
            var id = "";
            var childnum = "";
            var cancel = "";
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

            for (var i = 0; i < trees.length; i++) {
                orgs = trees[i];
                key = orgs.getElementsByTagName("key")[0].firstChild.nodeValue;
                name = orgs.getElementsByTagName("name")[0].firstChild.nodeValue;
                id = orgs.getElementsByTagName("id")[0].firstChild.nodeValue;
                cancel = orgs.getElementsByTagName("cancel")[0].firstChild.nodeValue;
                icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
                childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;
                if(cancelFlag == "1"){
                    if(cancel == "1"){
                        name +="(已撤销)";
                    }
                }else{
                    if(cancel == "1"){
                        continue;
                    }
                }
                //动态画树

                var nNode = tree.add(toNode, 'last', name, "n" + key, id, '', icon, '', '');
                if (nNode.parent.first.label.innerText == 'loading...')nNode.parent.first.remove();
                if (childnum != 0) {
                    nNode.add('loading...');
                    nNode.expand(false);
                }
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
    showTree("-1","1","");//树的根节点
    //定义树的节点的扩展方法
    tree.onexpand = function(srcNode)
    {
        if (srcNode.first.label.innerText == "loading...")
        {
            showTree(srcNode.key2);
        }
        return true;
    }

    tree.onclick = function(srcNode){
        parent.refreshList(srcNode.key2);
    }


</script>

</body>
</html>