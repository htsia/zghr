<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    //����personId���������ڲ��ŵ�treeId ��treeId='',���Զ�չ����
    String personId = request.getParameter("personId");
    String treeId = "";
    if (!"".equals(CommonFuns.filterNull(personId))) {
        PersonBO person = SysCacheTool.findPersonById(personId);
        if (person != null) {
            OrgBO org = SysCacheTool.findOrgById(person.getDeptId());
            if (org != null)
                treeId = org.getTreeId();
        }
    }
%>
<html>
<head><title></title>
<script src="../../js/tree.js" type="text/javascript"></script>
<script src="../../js/Appclient.js" type="text/javascript"></script>
<script type="text/javascript">
var xmlHttp;
var superId = "";
var targetTreeId = '<%=treeId%>'       //ʹ��treeIdչ��������
var targetPersonId = '<%=personId%>'       //���ն�λ����ԱId
var flag = true;
//����XMLHttpRequest����
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

    } else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}

//չʾ��Ҫ���õ��¼�
function showTree(pid, rightFlag, rootId) {
    flag = false;
    if (rightFlag == null) rightFlag = "";
    if (rootId == null) rootId = "";
    superId = pid;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.open("GET", "/pages/ajax/PersonTree.jsp?superId=" + superId + "&rightFlag=1&rootId=" + rootId + "&filterSQL=<%=CommonFuns.filterNull(request.getParameter("filterSQL"))%>", true);
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
    var superorg = null;
    var orgs = null;
    var key = "";
    var name = "";
    var sex = "";
    var icon = "";
    var id = "";
    var childnum = "";
    var treeid = "";

    //��xml��org��䵽����
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
    //���ȡ�����¼��ڵ���ɾ�������loading�ڵ�
    if (trees.length == 0 && toNode.first.label.innerText == 'loading...' && persons.length == 0)
        toNode.first.remove();

    //���������ڵ�������Ա�ڵ�
    for (i = 0; i < persons.length; i++) {
        person = persons[i];
        personId = person.getElementsByTagName("id")[0].firstChild.nodeValue;
        name = person.getElementsByTagName("name")[0].firstChild.nodeValue;
        sex = person.getElementsByTagName("sex")[0].firstChild.nodeValue;
        icon = 'per';
        if (sex=="01001"){
            icon='male';
        }
        else if (sex=='01002'){
            icon='female';
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

        //��̬����
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

    //do expand��λѡ�л���
    flag = true;
    if (expandNode != null) {
        if (expandNode.getKey().substr(1).length < targetTreeId.length) {
            expandNode.expand(true);
        }
    }
    try {
        if (targetPersonId != '') {                    //��λ��Ա
            try {
                tree.nodes['p' + targetPersonId].focus();
            } catch(e) {
            }

            tree.nodes['p' + targetPersonId].label.style.color = "white";
            tree.nodes['p' + targetPersonId].label.style.backgroundColor = "#3179CE";
            targetPersonId = '';
            targetTreeId = '';
        }

    } catch(e) {
    }
    if (tree.nodes['n' + targetTreeId] != null) {
        try {
            tree.nodes['n' + targetTreeId].focus();
        } catch(e) {
        }

        tree.nodes['n' + targetTreeId].expand(true);
        //��ĩһ��չ��
    }


    //չ�����ڵ�
    rootNodes = tree.root.children;
    for (i = 0; i < rootNodes.length; i++) {
        if (rootNodes[i].first.label.innerText == "loading...") {
            rootNodes[i].expand(true);
            break;
        }
    }

}

</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div id="tt"></div>
<script type="text/javascript">
    flag = false;
    //��������ͼƬ����
    var images = getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, tt);
    showTree("-1", '<%=CommonFuns.filterNull(request.getParameter("rightFlag"))%>', '<%=CommonFuns.filterNull(request.getParameter("rootId"))%>');//���ĸ��ڵ�
    //�������Ľڵ����չ����
    tree.onexpand = function(srcNode) {
        if (srcNode.first.label.innerText == "loading...") {
            if (flag) {
                showTree(srcNode.key2, '', '');
            } else {
                try {
                    event.returnValue = false;
                } catch(err) {

                }
            }
        }
        return true;
    }
    tree.onclick = function(srcNode) {
        if (srcNode.alt == 'person'){
            parent.refreshList(srcNode.key2);
        }else{
            try{
            parent.refreshListOrg(srcNode.key2);
                }catch(err){
                
            }
        }
    }
</script>
</body>
</html>