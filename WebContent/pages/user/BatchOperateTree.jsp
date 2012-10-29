<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <script language="javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/tree_check.js"></script>
</head>
<body>

<table width="100%" border="0" align="center" cellpadding="10" cellspacing="1" bordercolor="#999999">
        <tr>
            <td bgcolor="#FFFFFF">
                <div id="dt"></div>
                <script language="JavaScript">
                    //定义树的图片对象
                    var flag = false;
                    var images = getTreeImage();

                      //初始化树
                    var tree = new newtree(images, 16, dt);
                    var root = tree.root;
                    var operRoot = tree.add(root, "last", "权限列表", "0000", "0000", "", "folder", "", "");

                    <%
                         List list = (List) session.getAttribute("SYS_OPERATE");
                         if(list!=null && list.size()!=0){
                              for(int i=0;i<list.size();i++){
                                  OperateBO item =(OperateBO) list.get(i);
                                  StringBuffer sf = new StringBuffer();
                                  sf.append("var t")
                                  .append(item.getOperateId()).append("=tree.add(");
                                  String superId =item.getSuperId();
                                  if("-1".equals(superId)){
                                      sf.append("operRoot,'last','")
                                      .append(item.getOperateName())
                                      .append("','")
                                      .append(item.getOperateId())
                                      .append("','")
                                      .append(item.getOperateId())
                                      .append("','','folder','','');");
                                  }
                                  else{
                                      sf.append("t").append(superId);
                                      sf.append(",'last','")
                                      .append(item.getOperateName())
                                        .append("','")
                                      .append(item.getOperateId())
                                      .append("','")
                                      .append(item.getOperateId())
                                      .append("','','folder','',''")
                                      .append(");");
                                  }
                                  out.println(sf.toString());
                              }
                          }
                    %>

                    tree.expandAll(false);
                    tree.onclick = function(srcNode) {
                        parent.refreshList(srcNode.key2);
                    }

                </script>
            </td>
        </tr>
</table>

</body>
</html>
