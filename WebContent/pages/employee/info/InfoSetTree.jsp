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
<%@ include file="../../include/taglib.jsp" %>

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

        //�������ȡ���뼯.
        sets = sysapi.queryInfoSetByBigType(setType);
        if(sets != null){
            for(int i=0;i<sets.length;i++){
                 if(0==pmsapi.checkInfoSet((User) session.getAttribute(Constants.USER_INFO),sets[i].getSetId())){
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

<body bgcolor="#FFFFFF"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<div id="dt"></div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
 <script src="<%=request.getContextPath()%>/js/Appclient.js" type="text/javascript"></script>
<script language="javascript">
var setId = "";
var flag = true;
//��������ͼƬ����
var images = new getTreeImage();
//��ʼ����
var tree = new newtree(images, 16, dt);
root = tree.root;
<%
   //�����
   if(types != null && types.size()>0){
       for(int i=0;i<types.size();i++){
          CodeItemBO citem = (CodeItemBO) types.get(i);
          if ("0".equals(citem.getItemStatus()))  // ����
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
       }
   }

   //��ָ�꼯
   if(list != null && list.size() >0){
      for(int i=0;i<list.size();i++){
          InfoSetBO set = (InfoSetBO)list.get(i);
          if("0".equals(set.getSetStatus())){  // ����
            continue;
          }
          String rootNode = "root";
          if(set.getSet_sType() != null || !"".equals(set.getSet_sType())){
                CodeItemBO cb=SysCacheTool.findCodeItem("2001",set.getSet_sType());
                if (cb!=null && "0".equals(cb.getItemStatus())) continue;  // �����������
                rootNode = "T" + set.getSet_sType();
          }
          String str =set.getSetId() + " = tree.add(" + rootNode + ",'last','" + set.getSetName() + "','" + set.getSetId() + "','"+set.getSet_rsType()+"','','fold','','');";
          out.println(str);
     }
  }

%>

   tree.expandAll(false);
    //չ�����ڵ�
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