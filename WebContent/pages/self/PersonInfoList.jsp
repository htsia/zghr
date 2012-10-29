<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   <script type="text/javascript">
       function refreshList(orgId) {
          document.main.location.href = "/self/PersonInfoListChild.jsf?superId=" + orgId+"&filter=";
       }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
   </script>
  <h:form id="form1">
      <c:verbatim>
      <table width="99%" align="center">
          <tr>
          <td class=td_title height=1 colspan=3>
              <img src="/images/tips.gif" >自助查询 ->  员工介绍
              <%
                  if ("0".equals(Constants.EMP_PERSON_BROWUNIT)){
                      out.println("<font color='red'>只有选择部门时才能浏览员工</font>");
                  }
              %>
              </c:verbatim>
                 <h:inputHidden id="superId"></h:inputHidden>
              <c:verbatim>
          </td>
          </tr>

          <tr>
              <td id="showTree" width=250px>
                  <iframe name="tree" frameborder="0"  scrolling="auto" width="100%"  src="/pages/common/ShowOrgTree.jsp?rightFlag=1"></iframe>
              </td>
              <td width="10" class="ctrlbar" valign="middle">
                  <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
              </td>

              <td id="">
                  <iframe name="main" frameborder="0"  scrolling="auto" width="100%"  src=""></iframe>
              </td>
          </tr>
      </table>
     </c:verbatim>
</h:form>
