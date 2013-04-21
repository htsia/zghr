<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO"%>

<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String dict_num = request.getParameter("dict_num");     // ���뼯
    if (dict_num == null) return;
    if (dict_num.length()==7) {// �������ָ����
        InfoItemBO bo=SysCacheTool.findInfoItem("",dict_num);
        if (bo!=null){
            dict_num=bo.getItemCodeSet();
        }
    }
    String curCode = request.getParameter("curCode");      //  ��ǰ����ֵ���Ա���ʾʱ��ʾ��ѡ��
    String rootCode=request.getParameter("rootCode");
    String trees = "";

    if (curCode != null && !"".equals(curCode)) {
        String[] codeArrray = curCode.split(",");
        for (int i = 0; i < codeArrray.length; i++) {
            CodeItemBO code = SysCacheTool.findCodeItem(dict_num, codeArrray[i]);
            if (code != null)
                trees += ",'" + code.getTreeId() + "'";
        }
        trees = trees.substring(1);
    }

    String value = request.getParameter("value");         // ��������
    if (value == null || "".equals(value)) {
        trees = "";
    }
%>
<html>
<head><title>��ѡ����</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
<script src="<%=request.getContextPath()%>/js/tree_check.js" language="JavaScript"></script>

<script language="javascript">
    var xmlHttp;
    var setId = '<%=dict_num%>';
    var rootid='<%=rootCode%>';
    var superId = "";
    var treeIds = <%
                     String s="";
                     if ("".equals(trees)){
                        s="null";
                     }
                     else {
                       s="[''," + trees + "]";
                     }
                     out.print(s);
                   %>
    var targetTreeId = "";
    var pos = 1;
    var flag = true;

    //����XMLHttpRequest����
    function expandTreeNode(nNode) {
        if (treeIds==null) return;
        pos++;
        if (pos < treeIds.length) {
            targetTreeId = treeIds[pos];
            for (i = 1; i <= targetTreeId.length / 4; i++) {
                myNode = tree.nodes["n" + targetTreeId.substr(0, i * 4)];
                try {
                    if (!myNode.expanded) {
                        myNode.expand(true);
                        break;
                    } else {
                        if (myNode.getKey() == 'n' + targetTreeId) {
                            myNode.checkBox.checked = true;
                            expandTreeNode(null)
                        }
                    }
                } catch(e) {
                }
            }
        }
    }

    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }

    //չʾ��Ҫ���õ��¼�
    function showTree(pid,rootid) {
        flag = false;
        superId = pid;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        if (rootid==""){
           xmlHttp.open("GET", "/pages/ajax/Code.jsp?superId=" + superId, true);
        }
        else {
          xmlHttp.open("GET", "/pages/ajax/Code.jsp?superId=" + superId+"&rootId="+rootid, true);
        }
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

            //��̬����
            var nNode
            if (childnum == "0") {
                nNode = tree.addChkNode(toNode, 'last', name, "n" + key, id, '', icon, '', '', false, true);
            } else {
                nNode = tree.addChkNode(toNode, 'last', name, "n" + key, id, '', icon, '', '', false, false);
            }

            if (nNode.parent.first.label.innerText == 'loading...') nNode.parent.first.remove();
            if (childnum != 0) {
                nNode.add('loading...');
                nNode.expand(false);
            }

            if (targetTreeId != null && targetTreeId.substr(0, (nNode.getKey().length - 1)) == nNode.getKey().substr(1)) {
                expandNode = nNode;
            }
        }

        //do expand��λѡ�д���
        flag = true;
        if (expandNode != null) {
            if (expandNode.getKey().substr(1).length < targetTreeId.length) {
                expandNode.expand(true);
            }
        }
        if (tree.nodes['n' + targetTreeId] != null) {
            try {
                tree.nodes['n' + targetTreeId].focus();
            } catch(e) {
            }
            if (!tree.nodes['n' + targetTreeId].hasChild)
                tree.nodes['n' + targetTreeId].checkBox.checked = true;
            //�ݹ�
            expandTreeNode(null);
        }
    }
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0">
   <tr><td class="td_title" align="left">
    <input type="button" class="button01" value="ȷ��" onclick="doSel()" >
    <input type="button" class="button01" value="ȫ��ѡ" onclick="doClear()" >
    <input type="button" class="button01" value="ȫѡ" onclick="doAll()" >

    <tr><td>
        <div id="tt"></div>
    </td></tr>
</table>


<script language="javascript">
    var flag = false;
    //��������ͼƬ����
    var images = getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, tt);
    if (treeIds != null)      // ��ѡ�����
        targetTreeId = treeIds[pos];
    showTree(setId,rootid);//���ĸ��ڵ�

    //�������Ľڵ����չ����
    tree.onexpand = function(srcNode){
        //debugger;
        if (srcNode.first.label.innerText == "loading...")
        {
            if (flag) {
                showTree(srcNode.key2,'');
            } else{
                try{
                    event.returnValue = false;
                }catch(e){
                }
           }
        }
        return true;
    }

    tree.onclick = function(srcNode) {
    }

    function doSel() {
        var ids = "";
        var names = "";
        count = tree.nodes.length;
        for (i = 0; i < count; i++) {
            if (tree.nodes[i].label.innerText != 'loading...' && !tree.nodes[i].hasChild && tree.nodes[i].checkBox.checked) {
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
    function doAll(){
        // check��Ϊfalse
        for (i = 0; i < tree.nodes.length; i++) {
            if (tree.nodes[i].label.innerText != 'loading...') {
                try {
                    tree.nodes[i].checkBox.checked = true;
                } catch(e) {
                }
            }
        }
        // ����������ѡ��ֵ
        treeIds=null;
        targetTreeId=null;

    }
    function doClear() {
        // check��Ϊfalse
        for (i = 0; i < tree.nodes.length; i++) {
            if (tree.nodes[i].label.innerText != 'loading...') {
                try {
                    tree.nodes[i].checkBox.checked = false;
                } catch(e) {
                }
            }
        }
        // ����������ѡ��ֵ
        treeIds=null;
        targetTreeId=null;
    }
</script>

</body>
</html>