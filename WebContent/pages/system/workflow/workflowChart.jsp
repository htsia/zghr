<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.WFNodeBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>

<div id="parentLayer" style="position:absolute; width:1px; height:1px; z-index:0" >
    <%
        List list = (List) session.getAttribute("FLOWLIST");
        String y = (String) session.getAttribute("StartY");
        User user = (User) session.getAttribute(Constants.USER_INFO);
        if (y == null) y = "80";
        if (list != null) {
            int cellStartx = 40;

            for (int i = 0; i < list.size(); i++) {
                WFNodeBO node = (WFNodeBO) list.get(i);
                int x = cellStartx + 150 * i;
    %>

    <div id="layer1" style="position:absolute; left:<%=x%>px; top:<%=y%>px; width:101px; height:81px; z-index:0; background-color: #E2E4E3; layer-background-color: #E2E4E3; border: 1px none #000000;" >
        <table width="100%" height="81" border="1" cellpadding="2" cellspacing="1" >
          <tr align="center">
              <td height="20" bgcolor="<%if ("0".equals(node.getSeq()) || "999".equals(node.getSeq())){out.print("black");}else{out.print("#0099CC");}%>">
                      <span style="color:#FFFFFF;font-weight:bolder ">
           <%=LanguageSupport.getResource("XTGL-1029","ÐòºÅ",user.getLoginLang())%> :
               <%=node.getSeq()%></span>
              </td>
          </tr>
          <tr >
                <td align="center"  valign="middle"><%=node.getNodeName()%></td>
          </tr>
        </table>
    </div>
    <%
            }
        }
    %>
</div>
<div>
    <%
        if (session.getAttribute("FLOWCHART")!=null){
            out.println("<img src='"+CommonFuns.filterNull((String)session.getAttribute("FLOWCHART"))+"'>");
        }
    %>
</div>
