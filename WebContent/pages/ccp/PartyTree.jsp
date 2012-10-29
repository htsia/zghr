<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));
    String partyType = CommonFuns.filterNull(request.getParameter("paType"));
    String init = CommonFuns.filterNull(request.getParameter("init"));
%>
<html>
<head>
    <title></title>
    <script src="../../js/tree.js" language="JavaScript"></script>
    <script src="<%=request.getContextPath()%>/js/Appclient.js" language="JavaScript"></script>
    <script language="javascript">
        var xmlHttp;
        var superId = "";
        var pType = '<%=partyType%>'
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
        function showTree(pid, rightFlag, rootId, partyType, init) {
            if (rightFlag == null) rightFlag = "";
            if (rootId == null) rootId = "";
            if (partyType == null) partyType = "";
            if (init  == null) init = "";
            superId = pid;
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("GET", "/pages/ajax/Party.jsp?superId=" + superId + "&rightFlag=" + rightFlag + "&rootId=" + rootId + "&paType=" + partyType+ "&init=" + init, true);
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
            //            alert(results);
            //            alert(xmlHttp.responseText);
            var superorg = null;
            var orgs = null;
            var key = "";
            var name = "";
            var icon = "";
            var id = "";
            var childnum = "";
            var treeid = "";

            var trees = results.getElementsByTagName("party");
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
                icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
                childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;

                //��̬����
                var nNode = tree.add(toNode, 'last', name, "n" + key, id, '', icon, '', '');
                if (nNode.parent.first.label.innerText == 'loading...')nNode.parent.first.remove();
                if (childnum != '0') {
                    nNode.add('loading...');
                    nNode.expand(false);
                }
            }
            try {
                //չ�����ڵ�
                rootNodes = tree.root.children;
                for (i = 0; i < rootNodes.length; i++) {
                    if (rootNodes[i].first.label.innerText == "loading...") {
                        rootNodes[i].expand(true);
                        break;
                    }
                }
            } catch(err) {

            }

        }
    </script>
</head>

<body topmargin="0" leftmargin="0">
<div id="tt"></div>
<script language="javascript">

    //��������ͼƬ����
    var images = getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, tt);
    showTree("-1", '<%=rightFlag%>', '<%=rootId%>', '<%=partyType%>','<%=init%>');//���ĸ��ڵ�
    //�������Ľڵ����չ����
    tree.onexpand = function(srcNode)
    {
        if (srcNode.first.label.innerText == "loading...")
        {
            showTree(srcNode.key2, '', '', pType);
        }
        return true;
    }
    tree.onclick = function(srcNode) {
        parent.refreshList(srcNode.key2);
    }


</script>

</body>
</html>