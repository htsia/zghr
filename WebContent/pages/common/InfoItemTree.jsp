<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.sys.api.UserAPI"%>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%
    String onlyMulti = CommonFuns.filterNull(request.getParameter("onlyMulti"));   // 仅有多记录子集
    String setType = request.getParameter("setType");
    String typeId = "";

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

    Hashtable htParent = new Hashtable(); // 具有指标集合的代码项
    try {
        SysAPI sysapi = (SysAPI) SysContext.getBean("sys_SysAPI");
        UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");

        types = SysCacheTool.queryCodeItemBySetId("2001");
        SysCacheTool.sortCodeItemByTreeID(types);   // 按treeid排序

        //根据类别取代码集.
        sets = sysapi.queryInfoSetByBigType(setType);
        if (sets != null) {
            for (int i = 0; i < sets.length; i++) {
                if (0 == pmsapi.checkInfoSet((User) session.getAttribute(Constants.USER_INFO), sets[i].getSetId())) {
                    if ("1".equals(sets[i].getSetStatus())) {  // 启用
                        list.add(sets[i]);
                    }
                }
            }
        }
        if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                InfoSetBO set = (InfoSetBO) list.get(i);
                CodeItemBO cb = SysCacheTool.findCodeItem("2001", set.getSet_sType());
                if (cb != null && "0".equals(cb.getItemStatus())) {
                    list.remove(i);
                    i--;
                    continue;  // 代码类禁用了
                }
                if (htParent.get(set.getSet_sType()) == null) htParent.put(set.getSet_sType(), set);
                if (htParent.get(cb.getItemSuper()) == null) htParent.put(cb.getItemSuper(), set);
            }
        }
    } catch (Exception e) {
%>
<script type="text/javascript">alert("<%=e.getMessage()%>")</script>
<%
    }
%>
<html>
<head>
<title>
</title>
</head>

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
          if (htParent.get(citem.getItemId())==null)  continue; // 没有这个类别 则不显示
            if("-1".equals(citem.getItemSuper())){
                String str = "T" + citem.getItemId() + " = tree.add(root,'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','database','','');";
                out.println(str);
            }else{
                String str = "T" + citem.getItemId() + " = tree.add(T" + citem.getItemSuper() +",'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','database','','');";
                out.println(str);
            }
       }
   }

   //画指标集
   if(list != null && list.size() >0){
      for(int i=0;i<list.size();i++){
          InfoSetBO set = (InfoSetBO)list.get(i);
          if ("true".equals(onlyMulti)){
             if (InfoSetBO.RS_TYPE_SINGLE.equals(set.getSet_rsType())) continue;  // 过滤单子集
          }
          String rootNode = "root";
          if(set.getSet_sType() != null || !"".equals(set.getSet_sType())){
                rootNode = "T" + set.getSet_sType();
          }
          String str =set.getSetId() + " = tree.add(" + rootNode + ",'last','" + set.getSetName() + "','" + set.getSetId() + "','"+set.getSet_rsType()+"','','book_open','','');";
          out.println(str);
     }
  }

%>

    tree.expandAll(false);
    //展开根节点
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
//   //document.oncontextmenu=function(e){return false;}
</script>
</body>
</html>