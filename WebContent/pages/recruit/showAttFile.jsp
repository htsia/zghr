<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.ucc.IAttachmentUCC" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%@ page import="com.hr319wg.util.FileUtil" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileOutputStream" %>
<%
    try {
        String attachmentId = request.getParameter("attachmentId");
        String type = request.getParameter("type");
        IAttachmentUCC ucc=(AttachmentUCC)SysContext.getBean("common_attachmentUCC");
       	String filename=application.getRealPath("/")+File.separator + "file" + File.separator
		+ "recruit"+File.separator+attachmentId+"."+type;
        if(FileUtil.fileExists(filename)){
        	response.sendRedirect("/file/recruit/"+attachmentId+"."+type);
        }else{
        	File file=new File(filename);
        	FileOutputStream outt=new FileOutputStream(file);
        	outt.write(ucc.getFileContent(attachmentId));
        	outt.flush();
        	outt.close();
        	response.sendRedirect("/file/recruit/"+attachmentId+"."+type);
        }
    } catch (Exception e) {
    	e.printStackTrace();
        out.println("\n ÏÂÔØÊ§°Ü:"+e.getMessage());
    }
%>
