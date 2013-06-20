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
            var planId=document.all('form1:planId').value;
            document.main.location.href = "/xys/eva/StudentGradeList.jsf?superId="+orgId+"&planId="+planId;
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
        function uploadKeySet(){
            var planId=document.all('form1:planId').value;
            window.showModalDialog("/xys/eva/StudentGradeUpLoad.jsf?planId="+planId, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
        function downLoad(){
            window.open("/pages/xys/file/student_grade_import.xls");
        }
    </script>

<x:saveState value="#{regStrudentGradeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="initIndex" value="#{regStrudentGradeBB.initIndex}"/>
    <h:inputHidden id="superId" value="#{regStrudentGradeBB.superId}"/>
    <h:inputHidden id="planId" value="#{regStrudentGradeBB.planId}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 绩效管理 ->录入其他评价 &nbsp;&nbsp;&nbsp;&nbsp;
            </td>
            <td class="td_title" align="right">
                 </c:verbatim>
                     <h:commandButton styleClass="button01" type="button" value="下载导入模版" onclick="downLoad();"/>
                 <c:verbatim>
                 &nbsp;&nbsp;
                 </c:verbatim>
                     <h:commandButton styleClass="button01" type="button" value="导入其他评价" onclick="uploadKeySet();"/>
                 <c:verbatim>
           </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td id="showTree" width="210">
                        <iframe name="tree" height="400"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                src="/pages/common/ShowOrgTree.jsp"></iframe>
           </td>

           <td width="10" class="ctrlbar" valign="middle">
                        <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar()"></td>

            <td align="center" valign="top">
                            <iframe name="main" height="100%"  frameborder="0" framespacing="0" scrolling="auto" width="100%"
                                   src="/xys/eva/StudentGradeList.jsf"></iframe>
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
