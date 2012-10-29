<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.api.UserAPI"%>
<%@ include file="../include/taglib.jsp" %>

<%
    String setType = request.getParameter("setType");
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
    ArrayList list = new ArrayList();
    InfoSetBO[] sets = null;

    try {
        types = SysCacheTool.queryCodeItemBySetId("2001"); //update
        SysAPI sysapi = (SysAPI) SysContext.getBean("sys_SysAPI");
        UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");

        //根据类别取代码集.
        //todo 需要加上权限过滤
        sets = sysapi.queryInfoSetByBigType(setType);
        // sets = pmsapi.filterReadRightSet(sets);
        for(int i=0;i<sets.length;i++){            
                list.add(sets[i]);
        }
    } catch (Exception e) {
%>
<script type="text/javascript">alert("<%=e.getMessage()%>")</script>
<%
    }
%>
<html>
<head><title>
</title></head>

<body bgcolor="#FFFFFF"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<div id="dt"></div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
<script src="<%=request.getContextPath()%>/js/Appclient.js" type="text/javascript"></script>
<script language="javascript">
var setId = "";
var flag = true;
//定义树的图片对象
var images = new getTreeImage();
//初始化树
var tree = new newtree(images, 16, dt);
root = tree.root;
<%
//画类别
if(types != null && types.size()>0){
    for(int i=0;i<types.size();i++){
        CodeItemBO citem = (CodeItemBO) types.get(i);
        //update
        if(!citem.getTreeId().startsWith(typeId))
            continue;
        if (!citem.getItemId().equals("2001010100") && !citem.getItemId().equals("2001010000") && !citem.getItemId().equals("2001010500")  && !citem.getItemId().equals("2001040000"))
            continue;

        if("-1".equals(citem.getItemSuper())){
            String str = "T" + citem.getItemId() + " = tree.add(root,'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','fold','','');";
            out.println(str);
        }else{
            String str = "T" + citem.getItemId() + " = tree.add(T" + citem.getItemSuper() +",'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','fold','','');";
            out.println(str);
        }
    }
}
//画指标集
if(sets != null && sets.length >0){
    for(int i=0;i<list.size();i++){
        String rootNode = "root";
        InfoSetBO set = (InfoSetBO) list.get(i);
        if(set.getSet_sType() != null || !"".equals(set.getSet_sType())){
            if (!set.getSet_sType().equals("2001010100") && !set.getSet_sType().equals("2001010000") && !set.getSet_sType().equals("2001010500") && !set.getSet_sType().equals("2001040000"))
                continue;
        }
         rootNode = "T" + set.getSet_sType();
        if ( set.getSetId().equals("A079") || set.getSetId().equals("A282") || set.getSetId().equals("A703")
            || set.getSetId().equals("A701") || set.getSetId().equals("A245"))
            continue;
       
        String str =set.getSetId() + " = tree.add(" + rootNode + ",'last','" + set.getSetName() + "','" + set.getSetId() + "','"+set.getSet_rsType()+"','','book_open','','');";
        out.println(str);
    }
}
 
%>

tree.expandAll(false);
try {
    rootNodes =root.children;
    for (i = 0; i < rootNodes.length; i++) {
        rootNodes[i].expand(true);
    }
} catch(e) {

}
tree.onclick = function(node) {
   if(node.key2 != null && node.key2 != ""){
        parent.refreshList(node.getKey(),node.key2);
   }else{
       return ;
   }
}

</script>
</body>
</html>