<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.lead.ucc.IResMaintenanceUCC" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.lead.pojo.bo.LeadResourceBO" %>
<%@ include file="/pages/include/taglib.jsp" %>

<html>
<head><title>
</title></head>
<script type="text/javascript" src="../../../js/tree.js"></script>
<script type="text/javascript" src="../../../js/Appclient.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<body topmarge="0" leftmarge="0">
    <div id="dt"></div>

    <script type="text/javascript">
        var img = getTreeImage();
        //³õÊ¼»¯Ê÷
        var tree = new newtree(img, 16, dt);
        root = tree.root;
        <%
           try{
               IResMaintenanceUCC rc=(IResMaintenanceUCC)SysContext.getBean("lead_iresmaintenanceUCC");
               List list=rc.findAllGridRes();
               for(int i=0;i<list.size();i++){
                    LeadResourceBO lb=(LeadResourceBO)list.get(i);
                    if ("1".equals(lb.getIsuse())){
                        String str = "    tree.add(root,'last','" + lb.getShowName() + "', '" + lb.getShowCode() + "','','"+lb.getResId()+"','fold','','');";
                        out.println(str);
                    }
               }
           }
           catch(Exception e){

           }
        %>
        tree.expandAll(false);
        tree.onclick = function(srcNode) {
            parent.refreshList(srcNode.alt);
        }

    </script>
 </body>
</html>