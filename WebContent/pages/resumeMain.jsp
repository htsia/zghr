<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.recruit.ucc.IOutterRecruitUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ include file="./include/taglib.jsp" %>
<c:verbatim>
<script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
<base target="_self">
</c:verbatim>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User) session.getAttribute(Constants.USER_INFO);
%>
    <script language="javascript">
        function modifyResumePassword(){
            window.showModalDialog("/recruit/resumePasswordEdit.jsf", null, "dialogWidth:300px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
         }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.clientHeight - 95;
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<%@ include file="./include/menu.jsp" %>
<%
    IOutterRecruitUCC tl = (IOutterRecruitUCC) SysContext.getBean("recruit_outterucc");
    menu = tl.getResumeMenu();

    url = request.getParameter("url");
    if (url == null || "".equals(url)) {
        url = "/recruit/companyMessage.jsf";
    }
%>

<h:form id="form1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan=2>
                <table  border="0" cellspacing="0" cellpadding="0" width="100%">
                   <tr>
                    <td width=260 height=62 background="../images/maininterface/logo.jpg"></td>
                    <td width=279 align="left" height=62 background="../images/maininterface/toptitle.gif"></td>
                    <td background="../images/maininterface/toptitle_extend.gif" align="right">
                        <%=user.getName()%>，您好！ 欢迎登录外部招聘主界面&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
                    </td>
                   </tr>
                </table>
            </td>
        </tr>

        <tr>
            <td width="85%" height="22" bgcolor="#2074C5">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                   <tr>
                     <td width="10"   nowrap></td>
                     <td bgcolor="#2074C5" width="<%if(menu!=null) if(menu.getMenus()!=null) out.print(menu.getMenus().size()*25);%>">
                         <script type="text/javascript" language="JavaScript1.2">
                               <%
                                  if(menu != null){
                                       subMenuCount=0;
                                       LoadChildMenu(menu,"",out,true);
                                       out.println("showMenu();");
                                  }
                               %>
                           </script>
                      </td>
                   </tr>
               </table>
            </td>
            <td bgcolor=red height="22" align="left">
                &nbsp;<img src="../images/maininterface/icon_h.gif" width="13" height="13"><a href="#" onclick="modifyResumePassword()">修改密码</a>
                <img src="../images/common/exit.gif"  alt="退出"><a href="/recruit/ResumeLogin.jsf" class="a01"><font color=white>退出</font></a></td>
        </tr>

        <tr><td colspan=2>
            <iframe name="main" frameborder="0"  scrolling="auto" width="100%"
                    src="<%=url%>"></iframe>
        </td></tr>
    </table>

</h:form>



