<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    String url = request.getParameter("filename");
    if (url==null || "".equals(url)){
        url = (String)session.getAttribute("e_path");
    }
    if(url!=null&&!url.equals("")){
      // response.reset();
	   String newurl=java.net.URLEncoder.encode(url,"utf-8").replaceAll("%2F","/");
       //response.setHeader("Content-Disposition", "attachment; filename=" + new String(url.getBytes("GBK"),"ISO8859_1"));
       response.sendRedirect(newurl);
    } else {
        out.println("导出文件出错");
    }
%>
