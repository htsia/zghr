<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO"%>
<%@ page import="com.hr319wg.sys.ucc.ICodeItemUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeSetBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.util.Hashtable" %>

<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);

    String dict_num = request.getParameter("dict_num");     // 代码集
    if (dict_num == null) return;
    if (dict_num.length() == 7) {// 传入的是指标项
        InfoItemBO bo = SysCacheTool.findInfoItem("", dict_num);
        if (bo != null) {
            dict_num = bo.getItemCodeSet();
        }
    }
    String curCode = request.getParameter("curCode");      //  当前代码值，以便显示时显示已选中
    String rootCode = request.getParameter("rootCode");     //   根
%>
<html>
<head><title>多选代码</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script src="<%=request.getContextPath()%>/js/tree.js" language="JavaScript"></script>
<script src="<%=request.getContextPath()%>/js/tree_check.js" language="JavaScript"></script>

<script language="javascript">
</script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0">
   <tr><td class="td_title" align="left">
    <input type="button" class="button01" value="确认" onclick="doSel()" >
    <input type="button" class="button01" value="全不选" onclick="doClear()" >
    <input type="button" class="button01" value="全选" onclick="doAll()" >

    <tr><td>
        <div id="tt"></div>
    </td></tr>
</table>


<script language="javascript">
    var flag = false;
    //定义树的图片对象
    var images = getTreeImage();
    //初始化树
    var tree = new newtree(images, 16, tt);
    var root = tree.root;
    <%
       try{
           ICodeItemUCC codeucc=(ICodeItemUCC)(SysContext.getBean("sys_codeItemUccImpl"));
           List list=null;
           if (rootCode!=null && !"".equals(rootCode)){
               list=codeucc.queryCodeItems(dict_num,rootCode.split(","));
           }
           else{
              list=codeucc.queryCodeItems(dict_num,null);
           }
           CodeSetBO  setbo=SysCacheTool.findCodeSet(dict_num);
           String rootID="-1";
           Hashtable code0135=null;
           if ("0135".equals(dict_num)){  // 需要过滤权限
               if (user!=null && user.getPmsQueryCode()!=null && user.getPmsQueryCode().get("0135")!=null){
                  List listItem=(List)user.getPmsQueryCode().get("0135");
                  code0135=new Hashtable();
                  for(int i=0;i<listItem.size();i++){
                     CodeItemBO cib=(CodeItemBO)listItem.get(i);
                     code0135.put(cib.getItemId(),cib);
                  }
               }
           }

           for(int i=0;i<list.size();i++){
               CodeItemBO cb=(CodeItemBO)list.get(i);
               if ("0".equals(cb.getItemStatus())) continue;   //  禁用
               if (i==0){
                   rootID=cb.getItemSuper();
               }
               if (code0135!=null && code0135.get(cb.getItemId())==null){
                   continue;
               }
               String checked="false";
               String enable="false";
               if (curCode!=null && !"".equals(curCode) && curCode.indexOf(cb.getItemId())>=0){
                   checked="true";
               }
               if (CodeSetBO.LAYER_EVERY.equals(setbo.getSetLayer())){
                  enable="true";
               }
               else{
                    ArrayList list1 = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, dict_num, cb.getItemId());
                    if (list1 == null || list1.size() == 0) {
                       enable="true";
                    }
               }
               if (rootID.equals(cb.getItemSuper())){
                   out.println(" var t"+cb.getItemId()+" = tree.addChkNode(root, 'last', '"+cb.getItemNameEx()+"', 'n"+cb.getTreeId()+ "', '"+cb.getItemId()+"', '', 'folder', '', '', "+checked+", "+enable+");");
               }
               else{
                   out.println(" var t"+cb.getItemId()+" = tree.addChkNode(t"+cb.getItemSuper()+", 'last', '"+cb.getItemNameEx()+"', 'n"+cb.getTreeId()+ "', '"+cb.getItemId()+"', '', 'folder', '', '', "+checked+", "+enable+");");
               }
           }
       }
       catch(Exception e){

       }
    %>
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
        // check置为false
        for (i = 0; i < tree.nodes.length; i++) {
            if (tree.nodes[i].label.innerText != 'loading...') {
                try {
                    tree.nodes[i].checkBox.checked = true;
                } catch(e) {
                }
            }
        }
    }
    function doClear() {
        // check置为false
        for (i = 0; i < tree.nodes.length; i++) {
            if (tree.nodes[i].label.innerText != 'loading...') {
                try {
                    tree.nodes[i].checkBox.checked = false;
                } catch(e) {
                }
            }
        }
    }
</script>

</body>
</html>