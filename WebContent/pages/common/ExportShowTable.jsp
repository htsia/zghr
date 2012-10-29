<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants,
                 com.hr319wg.sys.pojo.vo.TableVO,
                 com.hr319wg.util.FileUtil,
                 java.io.File" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
        TableVO   tvo=(TableVO) session.getAttribute("ShowTable");

        if (tvo != null) {
            String path = application.getRealPath("/")  + File.separator + "file" + File.separator + "tmp";
            String fileName = FileUtil.exportFile(path, tvo, true);
            String url = request.getContextPath() + "/file/tmp/" + fileName;
            response.sendRedirect(url);
        } else {
            out.println("导出数据前请先查询");
        }
%>