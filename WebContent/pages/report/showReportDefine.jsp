<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String rootId = Constants.TOPLEVEL;
%>
<html>
<head><title></title>
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    
    <script language="javascript">
        var xmlHttp;
        var superId = "";

        //����XMLHttpRequest����
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
        }

        //չʾ��Ҫ���õ��¼�
        function showTree(pid) {
            superId=pid;
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("GET", "../ajax/ReportDefineType.jsp?superId=" + pid, true);
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
            var cancel = "";

            var trees = results.getElementsByTagName("itemKeySet");
            if (superId == "-1") {
                var toNode = tree.root;
            } else {
                var toNode = tree.nodes["n" + superId];
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
                if (nNode.parent.first.label.innerText == 'loading...') nNode.parent.first.remove();
                if (childnum != 0) {
                    nNode.add('loading...');
                    nNode.expand(false);
                }
            }

            //չ�����ڵ�
            try {
                rootNodes = tree.root.children;
                for (i = 0; i < rootNodes.length; i++) {
                    if (rootNodes[i].first.label.innerText == "loading...") {
                        rootNodes[i].expand(true);
                        break;
                    }
                }
            } catch(e) {

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
    showTree("-1");//���ĸ��ڵ�
    //�������Ľڵ����չ����
    tree.onexpand = function(srcNode) {
        if (srcNode.first.label.innerText == "loading..."){
            showTree(srcNode.key2, "1", "");
        }
        return true;
    }

    tree.onclick = function(srcNode) {
        parent.refreshList(srcNode.key2);
    }
</script>

</body>
</html>