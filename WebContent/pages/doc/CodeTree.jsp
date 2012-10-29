<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeSetBO" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String dict_num = request.getParameter("dict_num");
    if (dict_num == null) return;
    String curCode = request.getParameter("curCode");
    String value = request.getParameter("value");
    String flagSel = request.getParameter("flag");
    CodeItemBO code = SysCacheTool.findCodeItem(dict_num, curCode);
    String sel = "1"; //ֻ����Ҷ
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
<head><title></title>
<script src="../../js/tree.js" language="JavaScript"></script>
<script src="../../js/Appclient.js" language="JavaScript"></script>
<script language="javascript">
    var xmlHttp;
    var superId = "";
    var setId = '<%=dict_num%>';
    var targetTreeId = '<%=treeId%>'
    var flagSel = "<%=flagSel%>";
    var sel = "<%=sel%>";
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
    function showTree(pid, rootId) {
        flag = false;
        superId = pid;
        if (rootId == null) rootId = "";
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", "../ajax/PostCodeTree.jsp?superId=" + superId + "&rootId=" + rootId, true);
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
        var icon = "";
        var id = "";
        var childnum = "";
        var treeid = "";

        var trees = results.getElementsByTagName("code");
        var supertree = results.getElementsByTagName("supertree");
        var posts = results.getElementsByTagName("post");
        
        if (superId == setId) {
            var toNode = tree.root;
        } else {
            superorg = supertree[0];
            treeid = superorg.getElementsByTagName("treeid")[0].firstChild.nodeValue;
            var toNode = tree.nodes["n" + treeid];
        }
        var expandNode = null;
        //���ȡ�����¼��ڵ���ɾ�������loading�ڵ�
    	if (trees.length == 0 && toNode.first.label.innerText == 'loading...' && posts.length == 0)
        	toNode.first.remove();
        
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
         //���������ڵ������λ�ڵ�
	    
	    for(i=0;i<posts.length;i++){
	        person = posts[i];
	        personId = person.getElementsByTagName("id")[0].firstChild.nodeValue;
	        name = person.getElementsByTagName("name")[0].firstChild.nodeValue;
	        icon = 'post';
	        var personNode = tree.add(toNode, 'last', name, "p" + personId, personId, 'post', icon, '', '');
	        if (personNode.parent.first.label.innerText == 'loading...')personNode.parent.first.remove();
	        
	        if (targetTreeId.substr(0, (personNode.getKey().length - 1)) == personNode.getKey().substr(1)) {
         	   expandNode = personNode;
	        }
	    }
        
        //do expand��λѡ�л���
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
    //��������ͼƬ����
    var images = getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, tt);
    showTree(setId, '<%=CommonFuns.filterNull(request.getParameter("rootId"))%>');//���ĸ��ڵ�
    //�������Ľڵ����չ����
    tree.onexpand = function(srcNode)
    {
        if (srcNode.first.label.innerText == "loading...")
        {
            if (flag) {
                showTree(srcNode.key2);
            } else
                event.returnValue = false;
        }

        return true;
    }
    tree.onclick = function(srcNode) {
        if(srcNode.alt == 'post')
        	parent.refreshList(srcNode.key2);
    }


</script>

</body>
</html>