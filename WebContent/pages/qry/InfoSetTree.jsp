<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ include file="../include/taglib.jsp" %>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
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
    InfoSetBO[] sets = null;
    ArrayList list = new ArrayList();

    try {
        types = SysCacheTool.queryCodeItemBySetId("2001"); //update
        SysAPI sysapi = (SysAPI) SysContext.getBean("sys_SysAPI");
        UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");
        //根据类别取代码集.
        //todo 需要加上权限过滤
        sets = sysapi.queryInfoSetByBigType(setType);
        if (sets != null) {
            for (int i = 0; i < sets.length; i++) {
                if (0 == pmsapi.checkInfoSet((User) session.getAttribute(Constants.USER_INFO), sets[i].getSetId())) {
                    list.add(sets[i]);
                }
            }
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

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%">
  <tr><td class="td_title" align="left"><input type="button" value="取消选择" class="button01" onclick="window.returnValue = '|';window.close();"></td></tr>

  <tr>
      <td>
         <div id="dt"></div>
      </td>
  </tr>
 </table>


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
    if(list != null && list.size() >0){
    for(int i=0;i<list.size();i++){
       InfoSetBO set = (InfoSetBO)list.get(i);
        String rootNode = "root";
        if(set.getSet_sType() != null || !"".equals(set.getSet_sType()))
            rootNode = "T" + set.getSet_sType();
        String str =set.getSetId() + " = tree.add(" + rootNode + ",'last','" + set.getSetName() + "','" + set.getSetId() + "','"+set.getSet_rsType()+"','','fold','','');";
        out.println(str);
        }
    }

    %>

    tree.expandAll(false);
    //展开根节点
    try {
        rootNodes = root.children;
        for (i = 0; i < rootNodes.length; i++) {
            rootNodes[i].expand(true);

        }
    } catch(e) {

    }
    tree.onclick = function(srcNode) {

        if (!srcNode.hasChild) {
            if (srcNode.key2 == "2") {
                window.returnValue = srcNode.getKey() + "|" + srcNode.label.innerText;
                window.close();
            } else {
                alert("请选择多记录子集!");
            }
        }

    }


</script>
</body>
</html>