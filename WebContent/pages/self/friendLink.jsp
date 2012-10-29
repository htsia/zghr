<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.FriendLinkBO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.sys.ucc.IFriendLinkUCC" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>

<table border="0" border=0 width="100%" align="center">
    <%
        int LineCount=Integer.parseInt(Constants.SELF_FRIENTLINK_COUNT);
        // 40 * 140
        try {
            User user = (User) session.getAttribute(Constants.USER_INFO);
            IFriendLinkUCC rc = (IFriendLinkUCC) SysContext.getBean("sys_linkUCC");
            List list = rc.getAllLink(user.getOrgId());
            out.println("<tr valign='center'>");
            int i = 0;
            for (; i < LineCount && i < list.size(); i++) {
                FriendLinkBO bo = (FriendLinkBO) list.get(i);
                out.println("<A onclick=\"window.open('" + bo.getLinkURL() + "','_blank','');\"> <img style='cursor:pointer' height='" + Constants.FRIEND_LINK_HEIGHT + "' width='" + Constants.FRIEND_LINK_WIDTH + "' src='/images/maininterface/friendlink/" + bo.getLinkFile() + "' alt='" + bo.getLinkName() + "'></A>");
            }
            out.println("</tr>");
            if (i < list.size()) {
                out.println("<tr valign='center'>");
                for (; i < 2*LineCount && i < list.size(); i++) {
                    FriendLinkBO bo = (FriendLinkBO) list.get(i);
                    out.println("<A onclick=\"window.open('" + bo.getLinkURL() + "','_blank','');\"> <img style='cursor:pointer' height='" + Constants.FRIEND_LINK_HEIGHT + "' width='" + Constants.FRIEND_LINK_WIDTH + "' src='/images/maininterface/friendlink/" + bo.getLinkFile() + "' alt='" + bo.getLinkName() + "'></A>");
                }
                out.println("</tr>");
            }
        }
        catch (Exception e) {

        }
    %>
</table>