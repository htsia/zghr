<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.wage.ucc.impl.WagePersonQueryUCC" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.wage.ucc.IWageDeptUCC" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageDeptPowerBO" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageDeptBO" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
%>
<html>
<head><title>
</title></head>
<script type="text/javascript" src="../../js/tree.js"></script>
<script type="text/javascript" src="../../js/Appclient.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<body topmarge="0" leftmarge="0">
<table width="98%" align="center">
  <tr><td class="td_title">
    <input type="button" value="取消选择" class="button01" onclick="window.returnValue = '';window.close();">
  </td></tr>
  <tr><td>
    <div id="dt"></div>
  </td></tr>
</table>
<script type="text/javascript">
    var img = getTreeImage();
    //初始化树
    var tree = new newtree(img, 16, dt);
    root = tree.root;
    <%
       String setID=(String)request.getParameter("setID");
       try{
            WagePersonQueryUCC rc=(WagePersonQueryUCC)SysContext.getBean("wage_PersonQueryUccImpl");
            IWageDeptUCC wagedeptucc=(IWageDeptUCC)SysContext.getBean("wage_deptUCC");


            // 需要处理权限
            List powerList=wagedeptucc.getAllPowerByPerson(user.getUserId(),setID);
            if (powerList!=null && powerList.size()>0){
                for(int i=0;i<powerList.size();i++){
                    WageDeptPowerBO wpo=(WageDeptPowerBO)powerList.get(i);
                    WageDeptBO wdo=wagedeptucc.getDeptBOByID(wpo.getDeptID());
                    String str = "    tree.add(root,'last','" + wdo.getName() + "', 'T" + wdo.getName() + "','','CODE','fold','','');";
                    out.println(str);
                }
            }
            else{
                String dept[]=rc.getDeptList(setID);
                for(int i=0;i<dept.length;i++){
                    String str = "    tree.add(root,'last','" + dept[i] + "', 'T" + dept[i] + "','','CODE','fold','','');";
                    out.println(str);
                }
            }
        }
        catch(Exception e){

        }
    %>
    tree.expandAll(false);
    tree.onclick = function(srcNode) {
            window.returnValue = srcNode.label.innerText;
            window.close();
        }
</script>
</body>
</html>