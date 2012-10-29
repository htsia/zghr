<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.sys.api.UserAPI"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>

<%
    String setType = request.getParameter("setType");
    String dataType = request.getParameter("dataType");

    String typeId = "";
    //update
    if ("A".equalsIgnoreCase(setType))
        typeId = "0001";
    else if ("B".equalsIgnoreCase(setType))
        typeId = "0002";
    else if ("C".equalsIgnoreCase(setType))
        typeId = "0003";
    else if ("D".equalsIgnoreCase(setType))
        typeId = "0004";

    ArrayList types = new ArrayList();
    InfoSetBO[] sets = null;
    ArrayList items = new ArrayList();
    ArrayList list = new ArrayList();
    try {
        types = SysCacheTool.queryCodeItemBySetId("2001"); //update
        SysAPI sysapi = (SysAPI) SysContext.getBean("sys_SysAPI");
        UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");
        //根据类别取代码集.
        sets = sysapi.queryInfoSetByBigType(setType);
        for(int i=0;i<sets.length;i++){
            if(0==pmsapi.checkInfoSet((User) session.getAttribute(Constants.USER_INFO),sets[i].getSetId()))
                list.add(sets[i]);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<html>
<head><title>
</title></head>

<body leftmargin="0" topmargin="0">

<div id="dt"></div>
<script type="text/javascript" src="../../js/tree.js"></script>
<script type="text/javascript" src="../../js/Appclient.js"></script>
<script language="javascript">
function checkSpecItem(setId){
    if( setId == 'A001730' || setId == 'A001753'|| setId == 'A001750' || setId == 'B001730' || setId == 'C001730')
        return false;
    else
        return true;
}

var xmlHttp;
var setId = "";
var dataType= '<%=CommonFuns.filterNull(dataType)%>';
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
    xmlHttp.open("GET", "../ajax/InfoItem.jsp?orderByName=true&onlyWageItem=true&rightFlag=Y&setId=" + setId, true);
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
            property = orgs.getElementsByTagName("property")[0].firstChild.nodeValue;
            key = orgs.getElementsByTagName("key")[0].firstChild.nodeValue;
            name = orgs.getElementsByTagName("name")[0].firstChild.nodeValue;
            id = orgs.getElementsByTagName("id")[0].firstChild.nodeValue;
            icon = orgs.getElementsByTagName("icon")[0].firstChild.nodeValue;
            datatype = orgs.getElementsByTagName("datatype")[0].firstChild.nodeValue;
            code = orgs.getElementsByTagName("code")[0].firstChild==null?"":orgs.getElementsByTagName("code")[0].firstChild.nodeValue;
            childnum = orgs.getElementsByTagName("childnum")[0].firstChild.nodeValue;
            //动态画树
            if("1" == property && checkSpecItem(key) && key != "B001003" )//系统隐含控制字段 checkSpecItem如果是A001730 753等字段 返回false
                continue;

            if(dataType == '' || dataType.indexOf(datatype) != -1){
                var nNode = tree.add(toNode, 'last', name, key, id, "'" + datatype + "|" + code + "'", icon, '', '');
            }
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
var img = getTreeImage();
//初始化树
var tree = new newtree(img, 16, dt);
root = tree.root;
    <%

    //画类别
    //画指标集
    Map m = new HashMap();
    if(sets != null && sets.length >0){
    for(int i=0;i<sets.length;i++){
        InfoSetBO s = sets[i];
        String type = "root";
        if(s.getSet_sType() != null && !"".equals(s.getSet_sType()))
            type = s.getSet_sType();
        List alist = (List) m.get(type);
        if(alist == null)
            alist = new ArrayList();
        alist.add(s);
        m.put(type,alist);
        }
    }

    if(types != null && types.size()>0){
        for(int i=0;i<types.size();i++){
            CodeItemBO citem = (CodeItemBO) types.get(i);

            if ("0".equals(citem.getItemStatus()))  // 禁用
             continue;

            if(!citem.getTreeId().startsWith(typeId))
                continue;

            if("-1".equals(citem.getItemSuper())){
                String str = "T" + citem.getItemId() + " = tree.add(root,'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','fold','','');";
                out.println(str);
            }else{
                String str = "T" + citem.getItemId() + " = tree.add(T" + citem.getItemSuper() +",'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','fold','','');";
                out.println(str);
            }

            //如果不是A类 画指标
            if(!"A".equals(setType)){
                List alist = (List) m.get(citem.getItemId());
                if(alist != null){
                    for(int j=0;j<alist.size();j++){
                        InfoSetBO s = (InfoSetBO) alist.get(j);
                        if("B710".equals(s.getSetId())) continue;
                        if(!InfoSetBO.STATUS_OPEN.equals(s.getSetStatus())) continue;
                          if(s.getSet_sType() != null || !"".equals(s.getSet_sType())){
                                CodeItemBO cb=SysCacheTool.findCodeItem("2001",s.getSet_sType());
                                if (cb!=null && "0".equals(cb.getItemStatus())) continue;  // 代码类禁用了
                          }

                        String rootNode = "T" + s.getSet_sType();
                        String str =s.getSetId() + " = tree.add(" + rootNode + ",'last','" + s.getSetName() + "','" + s.getSetId() + "','"+s.getSet_rsType()+"','','fold','','');";
                        out.println(str);
                        str = s.getSetId() + "loading = tree.add(" + s.getSetId() + ",'last','loading...');";
                        out.println(str);
                        str = s.getSetId() + ".expand(false);";
                        out.println(str);
                    }
                }
            }
        }

        //如果是A类画指标集
        if("A".equals(setType)){
            if(sets != null && sets.length >0){
            for(int i=0;i<sets.length;i++){
                  InfoSetBO s = sets[i];
                  if(!InfoSetBO.STATUS_OPEN.equals(s.getSetStatus())) continue;
                  if(s.getSet_sType() != null || !"".equals(s.getSet_sType())){
                        CodeItemBO cb=SysCacheTool.findCodeItem("2001",s.getSet_sType());
                        if (cb!=null && "0".equals(cb.getItemStatus())) continue;  // 代码类禁用了
                  }

                String type = "root";
                if(s.getSet_sType() != null && !"".equals(s.getSet_sType()))
                    type = "T" + s.getSet_sType();

                String str =s.getSetId() + " = tree.add(" + type + ",'last','" + s.getSetName() + "','" + s.getSetId() + "','"+s.getSet_rsType()+"','','fold','','');";
                out.println(str);
                str = s.getSetId() + "loading = tree.add(" + s.getSetId() + ",'last','loading...');";
                out.println(str);
                str = s.getSetId() + ".expand(false);";
                out.println(str);
                }
            }
        }
    }
    %>

    tree.expandAll(false);
    tree.root.first.expand(true);

tree.onclick = function(srcNode) {
    window.returnValue=srcNode.label.innerText+"|"+srcNode.key2;
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