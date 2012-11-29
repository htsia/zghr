<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.oa319wg.user.pojo.vo.OAUser" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.oa319wg.user.pojo.bo.OAOperateBO" %>
<%@ page import="com.hr319wg.user.util.MenuObj" %>

<%@ include file="./include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    OAUser user = (OAUser) session.getAttribute(Constants.OA_USER_INFO);
    String SecondMainUrl = "/pages/function.jsp";
    Hashtable hashMenus = user.getOperMenus();
%>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        function refreshModule(moduleID){
            if (document.all('OA_XXZX')!=null){
                document.all('OA_XXZX').className="tab";
            }
            if (document.all('OA_BGZM')!=null){
                document.all('OA_BGZM').className="tab";
            }
            if (document.all('OA_GWLZ')!=null){
                document.all('OA_GWLZ').className="tab";
            }
            if (document.all('OA_GGSW')!=null){
                document.all('OA_GGSW').className="tab";
            }
            if (document.all('OA_DAGL')!=null){
                document.all('OA_DAGL').className="tab";
            }
            if (document.all('OA_CRM')!=null){
                document.all('OA_CRM').className="tab";
            }
            if (document.all('OA_HR')!=null){
                document.all('OA_HR').className="tab";
            }
            if (document.all('OA_XTGL')!=null){
                document.all('OA_XTGL').className="tab";
            }

            document.all(moduleID).className="activetab" ;
            document.tree.location.href="/pages/OA/ShowOperateTree.jsp?ModuleID="+moduleID;
        }

        function refreshFun(url){
            $("iframe[name=main]").attr("src",url);
        }
        with (window) onload = onresize = function(){
            var mainHeight = document.body.clientHeight - 150;
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>

<h:form id="form1">
   <c:verbatim>
   <table width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor=<%=Constants.BGCOLOR%>>
   <tr><td valign="top">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan=2>
                    <table  border="0" cellspacing="0" cellpadding="0" width="100%">
                       <tr>
                        <td width=260 height=62 background="/images/maininterface/logo.jpg"></td>
                        <td width=279 align="left" height=62 background="../images/maininterface/toptitle.gif"></td>
                        <td background="../images/maininterface/toptitle_extend.gif" align="right">
                            <%=user.getName()%>，您好！ 欢迎登录<% out.println(Constants.OA_SYSTEM_NAME);%><br><a href="/system/QueryOwnLog.jsf" target="_blank">上次登录：<%=CommonFuns.filterNull(user.getLastLoginTime())%>这是您今天第<%=CommonFuns.filterNull(user.getTodayTimes())%>次登录本系统</a>
                        </td>
                       </tr>
                    </table>
                </td>
            </tr>

           <tr>
               <td width="78%" height="22" bgcolor="#2074C5">
               </td>
               <td bgcolor=red height="22" align="left">
                   <img src="../images/maininterface/icon_h.gif" width="13" height="13"><a href="javascript:doModifyPassword();">修改密码</a>
                   <img src="../images/common/exit.gif"  alt="退出"><a href="/pages/LogOff.jsp" class="a01"><font color=white>退出</font></a>
                </td>
           </tr>
        </table>
   </td></tr>

    <tr><td valign="top">
    <table  width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
        <tr>
          <td width=200  valign="top" id="showTree">
              <table width="100%" class="table02">
                  <tr>
                      <td height=200 class="td05">
                          <iframe name="tree" height="400"  style="height:100%;width:100%" src="/pages/OA/ShowOperateTree.jsp"></iframe>
                      </td>
                  </tr>
                <%
                    if (hashMenus != null && hashMenus.get(OAOperateBO.OAMODULE_XXZX) != null) {
                        MenuObj menu=(MenuObj)hashMenus.get(OAOperateBO.OAMODULE_XXZX);
                        out.println("<tr><td class='tab' id='"+OAOperateBO.OAMODULE_XXZX+"' onclick='refreshModule(\""+OAOperateBO.OAMODULE_XXZX+"\")'><img src='"+menu.getWebIcon()+"'>"+menu.getName()+"</td></tr>");
                    }

                    if (hashMenus != null && hashMenus.get(OAOperateBO.OAMODULE_BGZM) != null) {
                        MenuObj menu=(MenuObj)hashMenus.get(OAOperateBO.OAMODULE_BGZM);
                        out.println("<tr><td class='tab' id='"+OAOperateBO.OAMODULE_BGZM+"' onclick='refreshModule(\""+OAOperateBO.OAMODULE_BGZM+"\")'><img src='"+menu.getWebIcon()+"'>"+menu.getName()+"</td></tr>");
                    }

                    if (hashMenus != null && hashMenus.get(OAOperateBO.OAMODULE_GWLZ) != null) {
                        MenuObj menu=(MenuObj)hashMenus.get(OAOperateBO.OAMODULE_GWLZ);
                        out.println("<tr><td class='tab' id='"+OAOperateBO.OAMODULE_GWLZ+"' onclick='refreshModule(\""+OAOperateBO.OAMODULE_GWLZ+"\")'><img src='"+menu.getWebIcon()+"'>"+menu.getName()+"</td></tr>");
                    }

                    if (hashMenus != null && hashMenus.get(OAOperateBO.OAMODULE_GGSW) != null) {
                        MenuObj menu=(MenuObj)hashMenus.get(OAOperateBO.OAMODULE_GGSW);
                        out.println("<tr><td class='tab' id='"+OAOperateBO.OAMODULE_GGSW+"' onclick='refreshModule(\""+OAOperateBO.OAMODULE_GGSW+"\")'><img src='"+menu.getWebIcon()+"'>"+menu.getName()+"</td></tr>");
                    }

                    if (hashMenus != null && hashMenus.get(OAOperateBO.OAMODULE_DAGL) != null) {
                        MenuObj menu=(MenuObj)hashMenus.get(OAOperateBO.OAMODULE_DAGL);
                        out.println("<tr><td class='tab' id='"+OAOperateBO.OAMODULE_DAGL+"' onclick='refreshModule(\""+OAOperateBO.OAMODULE_DAGL+"\")'><img src='"+menu.getWebIcon()+"'>"+menu.getName()+"</td></tr>");
                    }

                    if (hashMenus != null && hashMenus.get(OAOperateBO.OAMODULE_CRM) != null) {
                        MenuObj menu=(MenuObj)hashMenus.get(OAOperateBO.OAMODULE_CRM);
                        out.println("<tr><td class='tab' id='"+OAOperateBO.OAMODULE_CRM+"' onclick='refreshModule(\""+OAOperateBO.OAMODULE_CRM+"\")'><img src='"+menu.getWebIcon()+"'>"+menu.getName()+"</td></tr>");
                    }

                    if (hashMenus != null && hashMenus.get(OAOperateBO.OAMODULE_HR) != null) {
                        MenuObj menu=(MenuObj)hashMenus.get(OAOperateBO.OAMODULE_HR);
                        out.println("<tr><td class='tab' id='"+OAOperateBO.OAMODULE_HR+"' onclick='refreshModule(\""+OAOperateBO.OAMODULE_HR+"\")'><img src='"+menu.getWebIcon()+"'>"+menu.getName()+"</td></tr>");
                    }

                    if (hashMenus != null && hashMenus.get(OAOperateBO.OAMODULE_XTGL) != null) {
                        MenuObj menu=(MenuObj)hashMenus.get(OAOperateBO.OAMODULE_XTGL);
                        out.println("<tr><td class='tab' id='"+OAOperateBO.OAMODULE_XTGL+"' onclick='refreshModule(\""+OAOperateBO.OAMODULE_XTGL+"\")'><img src='"+menu.getWebIcon()+"'>"+menu.getName()+"</td></tr>");
                    }
                    
                %>
              </table>
          </td>

          <td width="10" class="ctrlbar" valign="middle">
                <img id=ctrlBnt src="/images/button_1.gif" onclick="ctrlbar();">
          </td>

          <td >
              <iframe name="main" height="100%"  style="width:100%"></iframe>
          </td>
        </tr>
    </table>
    </td></tr>

    <tr><td>
        <table width="100%">
          <%
             if ("1".equals(Constants.MAIN_INCLUDE_FRIENDLINK)){
          %>
            <tr>
               <td  height=25px  align="left" bgcolor='<%=Constants.FRAMECOLOR%>' valign="center" background="../../images/self/extent.jpg">
                    <img src="../../images/self/yhlj.jpg" >
                </td>
            </tr>

            <tr>
                 <td  valign="top" bgcolor='<%=Constants.FRAMECOLOR%>' height="75px" >
                    <jsp:include page="/pages/self/friendLink.jsp"></jsp:include>
                 </td>
             </tr>
          <%
              }
          %>
        <tr>
            <td height=62 background="../images/maininterface/toptitle_extend.gif" align="right">
                <script type="text/javascript">
                    document.write("本系统自动适应分辨率，您现在的分辨率是:"+screen.width+"*"+screen.height+"<br>");
                    document.write("您的浏览器是:"+judgeBrowser());
                </script>
                <br>
                <%
                    out.println(Constants.COMPANY_NAME);
                %>
            </td>
        </tr>
        </table>
    </td>
    </tr>
</table>
    </c:verbatim>
</h:form>
<script language="javascript">
    setDataTableOver("form1:linkList");
</script>


