<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.ucc.IAttachmentUCC" %>
<%
    try {
        String attachmentId = request.getParameter("attachmentId");
        IAttachmentUCC ucc = (com.hr319wg.common.ucc.IAttachmentUCC) SysContext.getBean("common_attachmentUCC");

        String filename = ucc.getFileContentToFile(application.getRealPath("/"),attachmentId,".rtf",false);
        if (!"".equals(filename)){
           response.sendRedirect(filename);
        }
        else{
            out.print("没有发现文件!");
        }
    } catch (Exception e) {
        out.println("\n 下载失败:"+e.getMessage());
    }
%>
