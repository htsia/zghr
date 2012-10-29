<%@ page import="com.hr319wg.sys.api.UserAPI" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%
    String typeId = request.getParameter("typeId");
    String personId = com.hr319wg.util.CommonFuns.filterNull(request.getParameter("postid"));
    String setId = request.getParameter("setId");

    if (setId == null || "".equals(setId))
        setId = (String) session.getAttribute("doc_C_setId");

    if (typeId == null || "".equals(typeId))
        typeId = (String) session.getAttribute("doc_C_typeId");

    if (null == setId)
        setId = "C001";

    session.setAttribute("doc_C_setId", setId);
    session.setAttribute("doc_C_typeId", typeId);

    if (typeId == null || "".equals(typeId))
        typeId = "2001030000";//2001020,2001030
    String[] typeIds = typeId.split(",");
    typeId = "";
    SysAPI sysapi = (SysAPI) SysContext.getBean("sys_SysAPI");
    InfoSetBO[] sets = sysapi.queryInfoSetByBigType("C");//B  /D
    UserAPI pmsapi = (UserAPI) SysContext.getBean("user_pmsAPI");

    for (int i = 0; i < typeIds.length; i++) {
        List list = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, "2001", typeIds[i]);
        typeId += typeIds[i] + ",";
        int count = list.size();
        out.println("<table border='0' width='100%' class='table'><tr>");
        if (!list.isEmpty()) {
            for (int n = 0; n < count; n++) {
                CodeItemBO bo = (CodeItemBO) list.get(n);
                String id = typeId + bo.getItemId();
                if (i < typeIds.length - 1) {
                    if (bo.getItemId().equals(typeIds[i + 1])) {
                        out.println("<td class='td_sec2'>");
                    } else {
                        out.println("<td class='td_sec1'>");
                    }
                } else {
                    out.println("<td class='td_sec1'>");
                }//end

                out.println("<a href='PostIndex.jsf?flag=2&postid=" + personId + "&fk=" + personId + "&typeId=" + id + "'>");
                String name = bo.getItemName();
                if (name.length() > 8)
                    name = name.substring(0, 4) + "<BR>" + name.substring(4, name.length());
                out.println(name);
                out.println("</a></td>");
            }
        }

        for (int j = 0; j < sets.length; j++) {
            if (Constants.SYS_SAVE_ABILITY_SET.indexOf(sets[j].getSetId()) != -1 || 1 == pmsapi.checkInfoSet((User) session.getAttribute(Constants.USER_INFO), sets[j].getSetId())) {
                continue;
            } else if (!InfoSetBO.STATUS_OPEN.equals(sets[j].getSetStatus())) {
                continue;
            }

            if (sets[j].getSet_sType().equals(typeIds[i])) {
                if (sets[j].getSetId().equals(setId))
                    out.println("<td class='td_sec2'>");
                else
                    out.println("<td class='td_sec1'>");
                String id = "";
                if (typeId.endsWith(","))
                    id = typeId.substring(0, typeId.length() - 1);
                out.println("<a href='PostIndex.jsf?flag=2&postid=" + personId + "&fk=" + personId + "&typeId=" + id + "&setId=" + sets[j].getSetId() + "'>");
                out.println(sets[j].getSetName());
                out.println("</a></td>");
            }
        }

        out.println("</tr>");
        out.println("</table>");
    }

%>
