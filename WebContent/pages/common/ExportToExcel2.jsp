<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants,
                 com.hr319wg.sys.pojo.vo.TableVO,
                 com.hr319wg.util.FileUtil,
                 java.io.File" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.api.ActivePageAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    String url = (String) request.getAttribute("FileURL");
    if (url != null && url.trim().length() > 0) {
        response.sendRedirect(url);
    } else {
        String sessionKey = request.getParameter("sessionKey");
        if (null == sessionKey || "".equals(sessionKey))
            sessionKey = Constants.OBJECT2;
        TableVO tvo = (TableVO) request.getAttribute(sessionKey);

        if (tvo == null) {
            tvo = (TableVO) session.getAttribute(sessionKey);
        }
        // 得到对应的语句
        String activeSql = (String) session.getAttribute("activeSql2");
        try {
            if (tvo != null && activeSql != null) {
                //tvo中进行了分页处理,不是全部数据
                TableVO newtvo = new TableVO();
                CellVO[] head = new CellVO[tvo.getHeader().length];
                for (int j = 0; j < head.length; j++) {
                    head[j]=new CellVO();
                    CommonFuns.copyProperties(head[j], tvo.getHeader()[j]);
                }
                newtvo.setHeader(head);
                ActivePageAPI api = (ActivePageAPI) SysContext.getBean("sys_activePageApi");
                User user = (User) (session.getAttribute(Constants.USER_INFO));
                api.querySql(newtvo, activeSql, user, 0, 0, false);
                String path = application.getRealPath("/") + File.separator + "file" + File.separator + "tmp";
                String fileName = FileUtil.exportFile(path, newtvo, true);
                url = request.getContextPath() + "/file/tmp/" + fileName;
                response.sendRedirect(url);
            } else {
                out.println("导出数据前请先查询");
            }
        }
        catch (Exception e) {

        }
    }
%>