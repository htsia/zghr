<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    User user=(User)session.getAttribute(Constants.USER_INFO);
    boolean businessUser = user.isBusinessUser();
    String processUnit =  user.getprocessUnit();
    String planId = request.getParameter("planId");
    String showMode = request.getParameter("showMode");
%>

    <script type="text/javascript">
        function refreshList(orgId) {
            document.all('form1:superId').value=orgId;
            var planId=document.all('form1:planId').value;
            document.main.location.href = "/xys/eva/caclEvaObjSelf.jsf?superId="+orgId
                    +"&planId="+planId;
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 40;
            $("iframe[name=tree]").height(mainHeight);
            $("iframe[name=main]").height(mainHeight);
        }
        function showProcessBar() {
       	    x = document.body.clientWidth / 2 - 150;
       	    y = document.body.clientHeight / 2;
       	    document.all('processbar').style.top = y;
       	    document.all('processbar').style.left = x;
       	    document.all('processbar').style.display = "";
       	 }
        function exportobj(){
        	window.open("/pages/xys/eva/EvaObjExport.jsp?planId="+document.all("form1:planId").value);
        }
        function uploadGrade(){
            var planId=document.all('form1:planId').value;
            window.showModalDialog("/xys/eva/EvaGradeUpLoad.jsf?planId="+planId, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{xys_evaPlanCaclBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="initIndex" value="#{xys_evaPlanCaclBB.initEvaObjIndex}"/>
    <h:inputHidden id="superId" value="#{xys_evaPlanCaclBB.superId}"/>
    <h:inputHidden id="planId" value="#{xys_evaPlanCaclBB.planId}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                         绩效管理 -> 结果查询
           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<%if("0".equals(processUnit) || ("-1".equals(processUnit) &&  businessUser))
        		//权限为本单位的, 或是全部机构且为业务用户的,显示树
        		{%>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
           </td>
           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>
			<%} %>
            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src='/xys/eva/caclEvaObjSelf.jsf?act=init&planId=<%=planId%>&showMode=<%=showMode%>'></iframe>
            </td>
        </tr>
    </table>
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
    </c:verbatim>
</h:form>
