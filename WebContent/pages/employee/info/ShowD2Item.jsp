<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.emp.ucc.ID2AnaUCC" %>
<%@ page import="com.hr319wg.emp.pojo.bo.D2AnaBO" %>
<%@ include file="../../include/taglib.jsp" %>
<%
   response.setHeader("progma", "no-cache");
   response.setHeader("Cache-Control", "no-cache");
   response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head><title>
</title></head>

<body>

<div id="dt"></div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
<script language="javascript">

    var flag = true;
    //定义树的图片对象
    var images = new getTreeImage();

    //初始化树
    var tree = new newtree(images, 16, dt);
    root = tree.root;
<%
        User user = (User) (session.getAttribute(Constants.USER_INFO));
        String setId = request.getParameter("setId");

        String moduleID=null;
      	if(request.getSession().getAttribute("ModuleID")!=null){
        	moduleID=(String)request.getSession().getAttribute("ModuleID");
        }else{
        	moduleID=null;
        }

      	List list=null;
        try{
            ID2AnaUCC ucc=(ID2AnaUCC)SysContext.getBean("emp_D2AnaUCC");
            list=ucc.getItemList();
        }
        catch(Exception e)
        {
           list=new ArrayList();
        }
        for(int i=0;i<list.size();i++){
            D2AnaBO wc=(D2AnaBO)list.get(i);
            String str= "tree.add(root,'last','" + wc.getAndName() + "', '" + wc.getAnaID() + "','"+wc.getAnaID()+"','"+wc.getAndName()+"','file','','');";
            out.println(str);
        }
%>
    tree.expandAll(false);

    tree.onclick = function(srcNode) {
        key=srcNode.key2;
        parent.refreshList(key);
    }
</script>
</body>
</html>