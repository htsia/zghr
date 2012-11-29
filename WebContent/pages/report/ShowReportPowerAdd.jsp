<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String rootId = Constants.TOPLEVEL;
    if (request.getParameter("rootId")!=null && !"".equals(request.getParameter("rootId"))){
        rootId=request.getParameter("rootId");
    }
%>
<html>
<head><title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
    <script src="<%=request.getContextPath()%>/js/tree_check.js" language="JavaScript"></script>
    
    <script language="javascript">
        var xmlHttp;
        var superId = "";
        var rootId="<%=rootId%>";

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
            xmlHttp.open("GET", "../ajax/ReportPowerAddType.jsp?superId=" + pid, true);
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
            if (superId == rootId) {
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
                var nNode = tree.addChkNode(toNode, 'last', name, "n" + key, id, '', icon, '', '', false, true);
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
 <table>
   <tr><td align="left">
    <input type="button" value="ѡ��" onclick="doSel()" class="button01">
    <input type="button" value="���" onclick="doClear()" class="button01">
   </tr>
   <tr><td>
       <div id="tt"></div>
   </td></tr>
</table>
<script language="javascript">
    //��������ͼƬ����
    var images = getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, tt);
    showTree("<%=rootId%>");//���ĸ��ڵ�
    //�������Ľڵ����չ����
    tree.onexpand = function(srcNode) {
        if (srcNode.first.label.innerText == "loading..."){
            showTree(srcNode.key2, "1", "");
        }
        return true;
    }

    //tree.onclick = function(srcNode) {
        //parent.refreshList(srcNode.key2);
    //}

    function doSel() {
        var ids = "";
        var names = "";
        count = tree.nodes.length;
        for (i = 0; i < count; i++) {
            if (tree.nodes[i].label.innerText != 'loading...' && tree.nodes[i].checkBox.checked) {
                ids += "," + tree.nodes[i].key2;
                names += "," + tree.nodes[i].label.innerText;
            }
        }
        if (count > 0) {
            ret = ids.substr(1) + "|" + names.substr(1);

            window.returnValue = ret;
            window.close();
        } else {
            window.returnValue = null;
            window.close()
        }
    }
    function doClear() {
         try{
            count = tree.nodes.length;
            for (i = 0; i < count; i++) {
                if (tree.nodes[i].label.innerText != 'loading...')
                    tree.nodes[i].checkBox.checked = false;
            }
          }catch(e){

         }
    }
</script>

</body>
</html>
