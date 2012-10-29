<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List"%>

<%@ include file="../../include/taglib.jsp" %>

<%
    String setType = "A";
    String typeId = "0001";
    ArrayList types = SysCacheTool.queryCodeItemBySetId("2001");
    List infoSet = SysCacheTool.queryAllInfoSet();
%>
<html>
<head>
    <title>选择指标项</title>
</head>

<body>
<div id="dt"></div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
<script language="javascript">
var xmlHttp;
var setId = "";

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
function showTree(pid) {
    flag = false;
    setId = pid;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.open("GET", "/pages/ajax/WageBaseItem.jsp?setId=" + setId, true);
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

    var trees = results.getElementsByTagName("item");
    var supertree = results.getElementsByTagName("supertree");

    superNode = supertree[0];
    toSetId = superNode.getElementsByTagName("setid")[0].firstChild.nodeValue;

    var toNode = tree.nodes[toSetId];

    var expandNode = null;
    if (trees.length > 0) {
        for (var i = 0; i < trees.length; i++) {
            orgs = trees[i];
            itemId = orgs.getElementsByTagName("itemId")[0].firstChild.nodeValue;
            name = orgs.getElementsByTagName("name")[0].firstChild.nodeValue;
            setId = orgs.getElementsByTagName("setId")[0].firstChild.nodeValue;
            setName = orgs.getElementsByTagName("setName")[0].firstChild.nodeValue;
            datatype = orgs.getElementsByTagName("datatype")[0].firstChild.nodeValue;
            codeSetId = orgs.getElementsByTagName("codeSetId")[0].firstChild.nodeValue;
            icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
            childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;

            key=itemId;
            key2=setId+"."+itemId+"|"+setName+"."+name;
            alt=datatype+"|"+codeSetId;
            //动态画树
            var nNode = tree.add(toNode, 'last', name, key, key2, alt, icon, '', '');
        }
    }

    if (toNode.first.label.innerText == 'loading...')toNode.first.remove();
    if (childnum != 0) {
        nNode.add('loading...');
        nNode.expand(false);
    }
    //do expand定位选中机构
    flag = true;
}


var flag = true;
//定义树的图片对象
var images = new getTreeImage();

//初始化树
var tree = new newtree(images, 16, dt);
root = tree.root;
<%
//画类别
if(types != null && types.size()>0){
    int count=types.size();
    out.println(count);
    for(int i=0;i<count;i++){
        CodeItemBO citem = (CodeItemBO) types.get(i);
        //过滤掉非人员信息
        if(!citem.getTreeId().startsWith(typeId))
            continue;

        if("-1".equals(citem.getItemSuper())){
            String str = "T" + citem.getItemId() + " = tree.add(root,'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','database','','');";
            out.println(str);
        }else{
            String str = "T" + citem.getItemId() + " = tree.add(T" + citem.getItemSuper() +",'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','database','','');";
            out.println(str);
        }
    }
}

//画指标集
if(infoSet != null && infoSet.size() >0){
    Iterator  iterator=infoSet.iterator();
    while(iterator.hasNext()){
        String rootNode = "root";
        InfoSetBO setBO=(InfoSetBO)iterator.next();
        if(!setType.equals(setBO.getSet_bType())) continue;
        if(setBO.getSet_sType() != null || !"".equals(setBO.getSet_sType()))
            rootNode = "T" + setBO.getSet_sType();
        String str =setBO.getSetId() + " = tree.add(" + rootNode + ",'last','" + setBO.getSetName() + "','" + setBO.getSetId() + "','','','set','','');";
        out.println(str);
        str = setBO.getSetId() + "loading = tree.add(" + setBO.getSetId() + ",'last','loading...');";
         out.println(str);
        str = setBO.getSetId() + ".expand(false);";
        out.println(str);
     }
}

%>
tree.expandAll(false);

tree.onclick = function(srcNode) {
    key=srcNode.key2;
    alt=srcNode.alt;
    window.returnValue=key+"|"+alt;
    window.close();
}

tree.onexpand = function(srcNode) {
    if (srcNode.first.label.innerText == "loading...") {
        if (flag) {
            showTree(srcNode.getKey());
        } else
            event.returnValue = false;
    }
    return true;
}
</script>
</body>
</html>