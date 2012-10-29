<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.emp.pojo.vo.IntroLetter" %>
<%@ page import="com.hr319wg.emp.util.PersonTool" %>
<%@ page import="com.hr319wg.sys.cache.SysCache"%>
<%@ page import="com.hr319wg.emp.ucc.IEmpChangeUCC" %>

<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
    try {
        String id = request.getParameter("id");
        IEmpChangeUCC ucc = (IEmpChangeUCC) SysContext.getBean("emp_changeucc");

        if (id != null && !"".equals(id.trim())) {
            IntroLetter il = ucc.findIntroLetter(id);
            Hashtable ht = PersonTool.introLetter(il);
            String path = getServletConfig().getServletContext().getRealPath("/");
            String file = PersonTool.filefillCardForIntroLetter(id, ht, path, "");
            SysCache.setPerson(id, SysCache.OPER_UPDATE);
            response.sendRedirect(file);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head>
    <title></title>
</head>

<body>
</body>
</html>