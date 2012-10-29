<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	User user=(User)session.getAttribute(Constants.USER_INFO);
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.all('form1:superId').value=orgId;
            var showMode=document.all('form1:showMode').value;
            var planId=document.all('form1:planId').value;
            document.main.location.href = "/xys/eva/PlanMgrPostList.jsf?flag=1&superId="+orgId
                    +"&showMode="+showMode+"&planId="+planId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            document.getElementById("tree").style.height = "" + mainHeight + "px";
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
        function forChange() {
            var orgId=document.all('form1:superId').value;
            var planId=document.all('form1:planId').value;
            if (document.getElementById("form1:showMode").value == "2") {
            	document.main.location.href = "/xys/eva/PlanMgrPostList.jsf?showMode=2&flag=1&superId="+orgId+"&planId="+planId;;
            } else {
            	document.main.location.href = "/xys/eva/PlanMgrPostList.jsf?showMode=1&flag=1&superId="+orgId+"&planId="+planId;;
            }
        }
        function showProcessBar() {
       	    x = document.body.clientWidth / 2 - 150;
       	    y = document.body.clientHeight / 2;
       	    document.all('processbar').style.top = y;
       	    document.all('processbar').style.left = x;
       	    document.all('processbar').style.display = "";
       	 }
    </script>

<x:saveState value="#{xys_PlanPostMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="initIndex" value="#{xys_PlanPostMgrBB.initIndex}"/>
    <h:inputHidden id="superId" value="#{xys_PlanPostMgrBB.superId}"/>
    <h:inputHidden id="planId" value="#{xys_PlanPostMgrBB.planId}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 绩效管理 ->考核岗位设置 &nbsp;&nbsp;&nbsp;&nbsp;
                  浏览方式：
                 </c:verbatim>
                 <h:selectOneMenu id="showMode" value="#{xys_PlanPostMgrBB.showMode}" onchange="forChange()">
                       <c:selectItem itemLabel="考核岗位" itemValue="1"/>
                       <c:selectItem itemLabel="排除岗位" itemValue="2"/>
                 </h:selectOneMenu>
                 <c:verbatim>
           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
           </td>

           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                            <iframe name="main" frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/xys/eva/PlanMgrPostList.jsf"></iframe>
            </td>
        </tr>
    </table>
    </c:verbatim>
    <marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
</h:form>
