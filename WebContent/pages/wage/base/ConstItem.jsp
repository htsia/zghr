<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageConstBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.wage.ucc.IWageConstUCC" %>
<%@ page import="java.util.ArrayList" %>
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
        String setId = request.getParameter("setId");
        List li=null;
        try{
            IWageConstUCC wageconstucc=(IWageConstUCC)SysContext.getBean("wage_ConstUccImpl");
            if (setId==null || setId.equals("")){
                li=wageconstucc.queryAll(WageConstBO.CONST_PUBLIC);
            }
             else{
                 li=wageconstucc.queryAll(setId);
            }
        }
        catch(Exception e)
        {
           li=new ArrayList();
        }
        for(int i=0;i<li.size();i++){
            WageConstBO wc=(WageConstBO)li.get(i);
            //(toNode,relation,text,key,key2,alt,ico,exeCategory,exeArg)
            String str= "tree.add(root,'last','" + wc.getConstName() + "', '" + wc.getConstID() + "','"+wc.getConstID()+"','"+wc.getConstName()+"','file','','');";
            out.println(str);
        }
%>
    tree.expandAll(false);

    tree.onclick = function(srcNode) {
        key=srcNode.key2;
        text=srcNode.alt;
        debugger;
        window.returnValue=key+"|"+text;
        window.close();
    }
</script>
</body>
</html>