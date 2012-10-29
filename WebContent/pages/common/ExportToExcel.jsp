<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ page contentType="application/x-msdownload;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants,
                 com.hr319wg.sys.pojo.vo.TableVO,
                 com.hr319wg.util.FileUtil,
                 java.io.File" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.api.ActivePageAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%
	response.setContentType("application/x-msdownload;charset=UTF-8");
	response.setHeader("Content-Disposition","Disposition; filename=result.xls");
%>
<%
	String path = request.getRealPath("/");
	path+="file\\tmp\\";
    String url = (String) request.getAttribute("FileURL");
    if (url != null && url.trim().length() > 0) {
        response.sendRedirect(url);
    } else {
        String sessionKey = request.getParameter("sessionKey");
        if (null == sessionKey || "".equals(sessionKey))
            sessionKey = Constants.OBJECT;
        TableVO tvo = (TableVO) request.getAttribute(sessionKey);

        if (tvo == null) {
            tvo = (TableVO) session.getAttribute(sessionKey);
        }
        // 得到对应的语句
        String activeSql = (String) session.getAttribute("activeSql");
        try {
            if (request.getParameter("sessionKey")!=null && tvo != null){
                String linkDept=(String)session.getAttribute("linkDept");

                String fileName = "";
                if ("1".equals(linkDept)){
                   FileUtil.exportFile(path, tvo, true,true);
                   out.clear();
	               out = pageContext.pushBody();  
	               FileInputStream in = new FileInputStream(path+"result.xls");
	               OutputStream os = response.getOutputStream();
	               byte[] b = new byte[1024];    
	               int i = 0;    
	               while((i = in.read(b)) > 0)    
	               {    
	               	os.write(b, 0, i);    
	               }    
	               os.flush();
                }
                else{
                   FileUtil.exportFile(path, tvo, true);
                   out.clear();
	               out = pageContext.pushBody();  
	               FileInputStream in = new FileInputStream(path+"result.xls");
	               OutputStream os = response.getOutputStream();
	               byte[] b = new byte[1024];    
	               int i = 0;    
	               while((i = in.read(b)) > 0)    
	               {    
	               		os.write(b, 0, i);    
	               }    
	               os.flush();
                }
            }
            else if (tvo != null && activeSql != null) {
                //tvo中进行了分页处理,不是全部数据
                TableVO newtvo = new TableVO();
                CellVO[] head = new CellVO[tvo.getHeader().length];
                for (int j = 0; j < head.length; j++) {
                    head[j]=new CellVO();
                    CommonFuns.copyProperties(head[j], tvo.getHeader()[j]);
                }
                newtvo.setHeader(head);
                ActivePageAPI api = (ActivePageAPI) SysContext.getBean("sys_activePageApi");
                api.querySql(newtvo, activeSql, null, 0, 0, false);
                String linkDept=(String)session.getAttribute("linkDept");

                String fileName = "";
                if ("1".equals(linkDept)){
                   FileUtil.exportFile(path, newtvo, true,true);
                   out.clear();
	               out = pageContext.pushBody();  
	               FileInputStream in = new FileInputStream(path+"result.xls");
	               OutputStream os = response.getOutputStream();
	               byte[] b = new byte[1024];    
	               int i = 0;    
	               while((i = in.read(b)) > 0)    
	               {    
	               	os.write(b, 0, i);    
	               }    
	               os.flush();
                }
                else{
                   FileUtil.exportFile(path, newtvo, true);
                   out.clear();
	               out = pageContext.pushBody();  
	               FileInputStream in = new FileInputStream(path+"result.xls");
	               OutputStream os = response.getOutputStream();
	               byte[] b = new byte[1024];    
	               int i = 0;    
	               while((i = in.read(b)) > 0)    
	               {    
	               	os.write(b, 0, i);    
	               }    
	               os.flush();
                }
            } else {
                out.println("导出数据前请先查询");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
%>