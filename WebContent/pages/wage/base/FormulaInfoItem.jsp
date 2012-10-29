<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.common.Constants" %>

<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String setType = "A";
    String typeId = "0001";
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
    xmlHttp.open("GET", "/pages/ajax/WageInfoItem.jsp?setId=" + setId, true);
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
            if (orgs.getElementsByTagName("codeSetId")[0].firstChild!=null){
              codeSetId = orgs.getElementsByTagName("codeSetId")[0].firstChild.nodeValue;
            }
            else{
              codeSetId="";  
            }
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
    String str = "T000 = tree.add(root,'last','员工信息', 'T000','','','fold','','');";
    out.println(str);

//画指标集
if(infoSet != null && infoSet.size() >0){
    Iterator  iterator=infoSet.iterator();
    while(iterator.hasNext()){
        String rootNode = "root";
        InfoSetBO setBO=(InfoSetBO)iterator.next();
        // 非薪资计算集合
        if (Constants.WAGE_INFOSETS.indexOf(","+setBO.getSetId()+",")<0) continue;
        // 禁用不显示
        if (!"1".equals(setBO.getSetStatus())) continue;
        rootNode = "T000";
        str =setBO.getSetId() + " = tree.add(" + rootNode + ",'last','" + setBO.getSetName() + "','" + setBO.getSetId() + "','','','database','','');";
        out.println(str);
        str = setBO.getSetId() + "loading = tree.add(" + setBO.getSetId() + ",'last','loading...');";
         out.println(str);
        str = setBO.getSetId() + ".expand(false);";
        out.println(str);

        if (setBO.getSetId().equals("A815")){   // 增加一个表示上月的数据
            str =setBO.getSetId() + "PREV = tree.add(" + rootNode + ",'last','" + setBO.getSetName() + "(上月数据)','" + setBO.getSetId()+"PREV" + "','','','database','','');";
            out.println(str);
            str = setBO.getSetId() + "PREVloading = tree.add(" + setBO.getSetId() + "PREV,'last','loading...');";
             out.println(str);
            str = setBO.getSetId() + "PREV.expand(false);";
            out.println(str);
         }
         if (setBO.getSetId().equals("A796")){   //  这里挂接岗位C018
            InfoSetBO post=SysCacheTool.findInfoSet("C018");
            if (post!=null){
                str =post.getSetId() + " = tree.add(" + rootNode + ",'last','" + post.getSetName() + "','" + post.getSetId() + "','','','database','','');";
                out.println(str);
                str = post.getSetId() + "loading = tree.add(" + post.getSetId() + ",'last','loading...');";
                out.println(str);
                str = post.getSetId() + ".expand(false);";
                out.println(str);
            }
         }
     }
}

%>
tree.expandAll(false);

tree.onclick = function(srcNode) {
    key=srcNode.key2;
    alt=srcNode.alt;
    //setId+"."+itemId | setName+"."+name |   datatype | codeSetId
    window.returnValue=key+"|"+alt;
    window.close();
}
//tree.ondblclick = function(srcNode) {
//    alert(srcNode.text)
//    alert(srcNode.key)
//    alert(srcNode.key2)
//    //window.returnValue = srcNode.key2 + "," +;
//   // window.close();
//}
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