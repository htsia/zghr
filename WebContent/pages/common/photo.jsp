<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%
    String id = request.getParameter("id");
    String height = request.getParameter("height");
    String width = request.getParameter("width");
    String heightStr="";
    if (height!=null && !"".equals(height)){
        heightStr="height='"+height+"'";
    }
    String widthStr="";
    if (width!=null && !"".equals(width)){
        widthStr="width='"+width+"'";
    }

%>
<img  <%=heightStr%> <%=widthStr%> src="<%
    try {

        if (id!=null && !"".equals(id)){
            AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");
            String basepath=application.getRealPath("/");
            if (!aucc.checkAttachFileExist(basepath, id)){
                aucc.getFileContentToFile(basepath,id);
            }
            String img="/file/tmp/"+id+".JPG";
            out.print(img);
        }else{
            out.print("/images/blank.gif");        
        }
    } catch (Exception e) {
       out.print("/images/blank.gif");
    }
    %>" alt="">

