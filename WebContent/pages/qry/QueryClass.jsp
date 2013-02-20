<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.qry.pojo.bo.QueryClassBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String setType = request.getParameter("setType");
    String qsType = request.getParameter("qsType");
    String operFlag=request.getParameter("operFlag");
    if  (operFlag==null){
        operFlag="1";
    }

    if (setType == null || "".equals(setType))
        setType = "A";
    if (qsType == null || "".equals(qsType))
        qsType = "Q";
    User user = (User) session.getAttribute(Constants.USER_INFO);
    if (user == null)
        user = new User();

    String publicTreeRoot = qsType + setType + Constants.DEFAULT_QUERY_PUBLIC_SUFFIX; 
    String privateTreeRoot = qsType + setType + user.getUserId();

    String typeName = ("S".equals(qsType) ? "统计" : "查询");
    String classID=CommonFuns.filterNull(request.getParameter("classID"));
%>
<h:form id="form1">
    <h:inputHidden value="#{qry_queryClassBB.showTree}"/>
<c:verbatim>
    <script src="/js/tree.js" language="JavaScript"></script>
    <div id="Layer1" style="position:absolute; width:200; z-index:1;  visibility: hidden;">
    <table width="70" border="0" cellpadding="0" cellspacing="1" bgcolor="#8E8E8F">
        <tr onclick="hideLayers()">
            <td bgcolor="#F6F6F6">
                <table width="100%" border="0" cellspacing="5" cellpadding="0">
                    <tr>
                        <td width="20"><img src="../../images/icon001.gif" width="20" height="20"></td>
                        <td><a class="td_middle" onclick="forAdd()">新建</a></td>
                    </tr>
                    <tr>
                        <td><img src="../../images/icon002.gif" width="20" height="20"></td>
                        <td><a class="td_middle" onclick="forEdit()">修改</a></td>
                    </tr>
                    <tr>
                        <td><img src="../../images/icon003.gif" width="20" height="20"></td>
                        <td><a class="td_middle" onclick="forDel()">删除</a></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

<div id=Layer2 style="position:absolute; width:4px; height:4px; z-index:3; visibility:hidden ">
    <select style="width:8"></select>
</div>

<div style="display:'none';">
        <input type="text" name="classId" value="">
        <input type="text" name="className" value="">
        <input type="text" name="setType" value="<%=CommonFuns.filterNull(request.getParameter("setType"))%>">
        <input type="text" name="rootId" value="">
        <input type="text" name="qsType" value="<%=CommonFuns.filterNull(request.getParameter("qsType"))%>">
        <input type="text" name="unitType" value="<%=CommonFuns.filterNull(request.getParameter("unitType"))%>">
</c:verbatim>
        <h:commandButton id="forDel" value="删除" styleClass="button01" action="#{qry_queryClassBB.deleteQueryClass}"/>
        <h:commandButton id="forAdd" value="新建" styleClass="button01" action="#{qry_queryClassBB.createQueryClass}"/>
        <h:commandButton id="forEdit" value="修改" styleClass="button01" action="#{qry_queryClassBB.updateQueryClass}"/>
<c:verbatim>
</div>
</c:verbatim>

<c:verbatim>
<script type="text/javascript">
//定义树的图片对象
var flag = false;
var images = getTreeImage();

//初始化树
var tree = new newtree(images, 16)
var root = tree.root;
<%
   if (!"".equals(classID)){
      out.println(publicTreeRoot+"=tree.add(root, 'list', '领导查询','QALEAD','QALEAD','PUBLIC','find');");
   }
   else{
%>
<%=publicTreeRoot%> = tree.add(root, "list", "公共<%=typeName%>", "<%=publicTreeRoot%>", "<%=publicTreeRoot%>", "PRIVATE", "find");
<%
    QueryClassBO[] bos = (QueryClassBO[]) request.getAttribute("classPublic");
    if(bos != null && bos.length > 0){
        for(int i=0;i<bos.length;i++){
            QueryClassBO bo = bos[i];
            String sc = bo.getClassId() + " = tree.add(" + bo.getSuperId() + ", 'last', '" + bo.getName() + "', '" + bo.getClassId() + "', '" + bo.getRootId() +"', 'PRIVATE', 'find');";
            out.println(sc);
        }
}
%>
<%=privateTreeRoot%> = tree.add(root, "list", "私有<%=typeName%>", "<%=privateTreeRoot%>", "<%=privateTreeRoot%>", "PRIVATE", "find");
<%
    bos = (QueryClassBO[]) request.getAttribute("classPrivate");
    if(bos != null && bos.length > 0){
        for(int i=0;i<bos.length;i++){
            QueryClassBO bo = bos[i];
            String sc = bo.getClassId() + " = tree.add(" + bo.getSuperId() + ", 'last', '" + bo.getName() + "', '" + bo.getClassId() + "', '" + bo.getRootId() +"', 'PRIVATE', 'find');";
            out.println(sc);
        }
    }
  }
%>

tree.onclick = function(node) {
    if("Q" == "<%=qsType%>")
        window.parent.rs.location = "/qry/QueryList.jsf?operFlag=<%=operFlag%>&qsType=<%=qsType%>&setType=<%=setType%>&unitType=<%=CommonFuns.filterNull(request.getParameter("unitType"))%>&classId=" + node.getKey() + "&publicFlag=" + node.alt;
    else
        window.parent.rs.location = "/qry/StaticList.jsf?operFlag=<%=operFlag%>&qsType=<%=qsType%>&setType=<%=setType%>&unitType=<%=CommonFuns.filterNull(request.getParameter("unitType"))%>&classId=" + node.getKey()+ "&publicFlag=" + node.alt;
}
tree.ondblclick = function(node) {
}

//disable right click
function showHideLayers(id, rootId, className) {
    Layer1.style.left = x - 2;
    Layer1.style.top = y - 2;
    Layer1.style.visibility = "";
    HiddenPop()
    document.all("rootId").value = rootId;
    document.all("className").value = className;
    document.all("classId").value = id;

}
function hideLayers() {
    var obj = document.all.Layer1;
    obj.style.visibility = 'hidden';
}
//new script
function moveMouse() {
    Layer2.style.left = event.clientX - 2;
    Layer2.style.top = event.clientY - 5;
    Layer2.style.display = 'none';
}

function clickMenu(id, rootId, name) {
    if (event.button == 2) {
        x = event.clientX;
        y = event.clientY;
        Layer2.style.visibility = "";
        window.setTimeout("showHideLayers('" + id + "','" + rootId + "','" + name + "');", 200);
    } else {
        HiddenPop();
        Layer1.style.visibility = 'hidden';
    }
}

function HiddenPop() {
    Layer2.style.visibility = 'hidden';
}

function disableRight() {
    if (event.button == 2) {
        Layer2.style.visibility = "";
        Layer2.style.display= "";
        window.setTimeout("Layer2.style.visibility='hidden';", 200);
    }
    else{
        Layer2.style.visibility = 'hidden';
        Layer1.style.visibility = 'hidden';
    }
}

document.onmousemove = moveMouse;
document.onmouseup = disableRight;
tree.onmouseup = function(srcNode) {
    clickMenu(srcNode.getKey(), srcNode.key2, srcNode.label.innerText);
}


function forAdd() {
    var name = window.prompt('请输入类别名', '');
    if (name == "") {
        forAdd();
    } else if (name == null) {
        return false;
    } else {
        document.all("className").value = name;
        document.all("form1:forAdd").click();
        return true;
    }
}
function forEdit() {
    var name = window.prompt('请输入新类别名', form1.className.value);
    if (name != null) {
        form1.className.value = name;
        document.all("form1:forEdit").click();
        return true;
    }
    return false;
}
function forDel() {
    if (form1.rootId.value == form1.classId.value) {
        alert("不能删除根节点！")
        return false;
    }
    if (confirm("确认删除?")) {
        document.all("form1:forDel").click();
        return true;
    }
    return false;
}
</script>
</c:verbatim>
</h:form>