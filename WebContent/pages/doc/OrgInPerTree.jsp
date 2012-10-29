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

        //����XMLHttpRequest����
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
        }

        //չʾ��Ҫ���õ��¼�
        function showTree(pid,rightFlag,rootId) {
            superId = pid;
            if(rightFlag == null) rightFlag = "";
            if(rootId == null) rootId = "";
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.open("GET", "../ajax/OrgInPer.jsp?superId=" + superId + "&rightFlag=" + rightFlag + "&rootId=" + rootId, true);
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
                        name +="(�ѳ���)";
                    }
                }else{
                    if(cancel == "1"){
                        continue;
                    }
                }
                //��̬����

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

    //��������ͼƬ����
    var images = getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, tt);
    showTree("-1","1","");//���ĸ��ڵ�
    //�������Ľڵ����չ����
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