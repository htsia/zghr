<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head><title></title>
<script src="/js/tree.js" type="text/javascript"></script>
<script type="text/javascript">
var xmlHttp;
var superId = "";
var targetTreeId = ''
var targetPersonId = ''
var flag = true;
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

    } else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}

function showTree(pid, rightFlag, rootId) {
    flag = false;
    if (rightFlag == null) rightFlag = "";
    if (rootId == null) rootId = "";
    superId = pid;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.open("GET", "/pages/lead/personview/DeptTreeData.jsp?superId=" + superId + "&rightFlag=1&rootId=" + rootId + "&filterSQL=<%=CommonFuns.filterNull(request.getParameter("filterSQL"))%>", true);
    xmlHttp.send(null);
}

function handleStateChange() {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {
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
    var sex="";
    var icon = "";
    var id = "";
    var childnum = "";
    var treeid = "";

    var trees = results.getElementsByTagName("org");
    var supertree = results.getElementsByTagName("supertree");
    var persons = results.getElementsByTagName("person");

    if (superId == "-1") {
        var toNode = tree.root;
    } else {
        superorg = supertree[0];
        treeid = superorg.getElementsByTagName("treeid")[0].firstChild.nodeValue;
        var toNode = tree.nodes["n" + treeid];
    }
    var expandNode = null;
    if (trees.length == 0 && toNode.first.label.innerText == 'loading...' && persons.length == 0)
        toNode.first.remove();


    for (i = 0; i < persons.length; i++) {
        person = persons[i];
        personId = person.getElementsByTagName("id")[0].firstChild.nodeValue;
        name = person.getElementsByTagName("name")[0].firstChild.nodeValue;
        icon = 'per';
        if (person.getElementsByTagName("sex")!=null && person.getElementsByTagName("sex")[0].firstChild!=null){
            sex = person.getElementsByTagName("sex")[0].firstChild.nodeValue;

            if (sex=="01001"){
                icon='male';
            }
            else if (sex=='01002'){
                icon='female';
            }
        }
        var personNode = tree.add(toNode, 'last', name, "p" + personId, personId, 'person', icon, '', '');

        if (personNode.parent.first.label.innerText == 'loading...')personNode.parent.first.remove();

        if (targetTreeId.substr(0, (personNode.getKey().length - 1)) == personNode.getKey().substr(1)) {

            expandNode = personNode;

        }
    }
    for (var i = 0; i < trees.length; i++) {
        orgs = trees[i];
        key = orgs.getElementsByTagName("key")[0].firstChild.nodeValue;
        name = orgs.getElementsByTagName("name")[0].firstChild.nodeValue;
        id = orgs.getElementsByTagName("id")[0].firstChild.nodeValue;
        icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
        childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;

        name = name.replace("[", "<");
        name = name.replace("]", ">");
        name = name.replace("[", "<");
        name = name.replace("]", ">");

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

    flag = true;
    try{
    rootNodes = tree.root.children;
    for (i = 0; i < rootNodes.length; i++) {
        if (rootNodes[i].first.label.innerText == "loading...") {
            rootNodes[i].expand(true);
            break;
        }

    }    }catch(err){
        
    }
}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div id="tt"></div>
<script type="text/javascript">
    flag = false;

    var images = getTreeImage();

    var tree = new newtree(images, 16, tt);
    showTree("-1", '<%=CommonFuns.filterNull(request.getParameter("rightFlag"))%>', '<%=CommonFuns.filterNull(request.getParameter("rootId"))%>');

    tree.onexpand = function(srcNode) {
        if (srcNode.first.label.innerText == "loading...") {
            if (flag) {
                showTree(srcNode.key2, '', '');
            } else
                event.returnValue = false;
        }
        return true;
    }
    tree.onclick = function(srcNode) {

        if (srcNode.alt == 'person')
            parent.refreshList(srcNode.key2);
    }

</script>

</body>
</html>