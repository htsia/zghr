<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<html>
  <head>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/checkAll.js" ></script>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/check.js" ></script>
     <script type="text/javascript" language="javascript">
        //var sType="2001010100";  //指标集类型

        function refreshList(sType) {
            var paramid = "<%=request.getParameter("paramid")%>";
            var pageflag = "<%=request.getParameter("pageflag")%>";
            var manageFlag ="<%=request.getParameter("manageFlag")%>";
            var param ="/user/CreditDataInfo.jsf?paramid="+paramid+"&stype="+sType+"&pageflag="+pageflag+"&manageFlag"+manageFlag;
           document.list.location = param;
        }
    </script>
  </head>

  <body >
   <table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
     <tr>
       <td width="200" align="center" valign="top" class="explorer" id="showTree">
             <iframe name="tree" scrolling="auto" frameborder="0"  width="100%"  height="100%" src="/system/InfoSetTypeTree.jsf?onlyUse=true" ></iframe>
       </td>

       <td width="10" class="ctrlbar" valign="middle">
           <img id="ctrlBnt" src="<%=request.getContextPath()%>/images/button_1.gif" onclick="ctrlbar()" style="cursor:hand">
       </td>

         <td align="center" valign="top" class="explorer">
                 <iframe name="list" scrolling="auto" frameborder="0"  width="100%" height="100%" src="<%="/user/CreditDataInfo.jsf?paramid="+request.getParameter("paramid")+"&stype=2001010100&pageflag="+request.getParameter("pageflag")+"&manageFlag="+request.getParameter("manageFlag")%>"></iframe>
          </td>
     </tr>
   </table>
  </body>
</html>