<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>

<%
    response.setContentType("text/xml;charset=GBK");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    Map map = new HashMap();
    if ("TOMCAT".equals(CommonFuns.getAppType())) {
        map = CommonFuns.getParaMapFromURL(request.getQueryString(),"");
    } else {
        map = request.getParameterMap();
    }
    if (map.size() > 0) {
        out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
        out.println("<interpret>");
        Iterator it = map.keySet().iterator();
        while (it.hasNext()) {
            String fieldName = (String) it.next();
            String values = "";
            if ("TOMCAT".equals(CommonFuns.getAppType())) {
                values=CommonFuns.getParaFromURL(request.getQueryString(),fieldName);
            }
            else{
                values=request.getParameter(fieldName);
            }
            String codeSetId = values.substring(0, values.indexOf("|"));
            String code = values.substring(values.indexOf("|") + 1);
            String name = "";
            if (code != null && code.indexOf(",") != -1) {
                String[] codes = code.split(",");
                String tmp = "";
                if (codes != null && codes.length > 0) {
                    for (int i = 0; i < codes.length; i++) {
                        tmp += CodeUtil.interpertCode(codeSetId, codes[i]) + ",";
                    }
                    name = tmp.substring(0, tmp.length() - 1);
                }
            } else {
                //从缓存中取数据生成xml
                name = CodeUtil.interpertCode(codeSetId, code);
            }
            out.println("    <interpretitem>");
            out.println("        <formfield>" + fieldName + "</formfield>");
            out.println("        <codename>" + name + "</codename>");
            out.println("        <codeitemid>" + code + "</codeitemid>");
            out.println("    </interpretitem>");
        }
        out.println("</interpret>");
    }
%>
