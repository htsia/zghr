<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeSetBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String dict_num = request.getParameter("dict_num");   // 字典
    if (dict_num == null) return;
    if (dict_num.length() == 7) {// 传入的是指标项
        InfoItemBO bo = SysCacheTool.findInfoItem("", dict_num);
        if (bo != null) {
            dict_num = bo.getItemCodeSet();
        }
    }

    String curCode = request.getParameter("curCode");
    String value = request.getParameter("value");
    String flagSel = request.getParameter("flag");

    CodeItemBO code = SysCacheTool.findCodeItem(dict_num, curCode);
    String sel = "1"; //只允许叶
    CodeSetBO bo = SysCacheTool.findCodeSet(dict_num);
    if (bo != null) {
        sel = bo.getSetLayer();
    }
    String treeId = "";
    if (code != null) {
        treeId = CommonFuns.filterNull(code.getTreeId());
    }
    if (value == null || "".equals(value)) {
        treeId = "";
    }
%>
<html>
<head><title>选择代码</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script src="/js/tree.js" language="JavaScript"></script>
<script src="/js/Appclient.js" language="JavaScript"></script>

<script language="javascript">
    var xmlHttp;
    var superId = "";
    var setId = '<%=dict_num%>';
    var targetTreeId = '<%=treeId%>'
    var flagSel = "<%=flagSel%>";
    var sel = "<%=sel%>";
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
        xmlHttp.open("GET", "/pages/ajax/Code.jsp?superId=" + superId + "&rootId=" + rootId, true);
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

<body topmargin="5">
<table width="100%">
  <tr><td class="td_title" align="left"><input type="button" value="取消选择" class="button01" onclick="window.returnValue = ',';window.close();"></td></tr>

  <tr>
      <td>
         <div id="tt"></div>
      </td>
  </tr>
 </table>
<script language="javascript">
    var flag = false;
    //定义树的图片对象
    var images = getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);
    showTree(setId, '<%=CommonFuns.filterNull(request.getParameter("rootId"))%>');//树的根节点
    //定义树的节点的扩展方法
    tree.onexpand = function(srcNode){
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
        var value=srcNode.label.innerText;  // 滤掉编码
        //if (value.indexOf('(')>=0)  value=value.substr(0,srcNode.label.innerText.indexOf('('));
        if (flagSel == "1") {
            window.returnValue = srcNode.key2 + "," + value;
            window.close();
        } else  if (flagSel == "0") {
            if (!srcNode.hasChild) {
                window.returnValue = srcNode.key2 + "," + value;
                window.close();
            }
        } else {
            if (sel == "1") {
                if (!srcNode.hasChild) {
                    window.returnValue = srcNode.key2 + "," + value;
                    window.close();
                }
            } else {
                window.returnValue = srcNode.key2 + "," + value;
                window.close();
            }
        }
    }
</script>

</body>
</html>