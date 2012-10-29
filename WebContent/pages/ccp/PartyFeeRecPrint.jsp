<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.ccp.ucc.IPartyUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.cont.util.UnicodeToRtfcode" %>
<%@ page import="com.hr319wg.ccp.util.CcpConstants" %>
<%@ page import="com.hr319wg.cont.util.RTFParser" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="com.hr319wg.util.FileUtil" %>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.ccp.util.CcpTools"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<%
    try {
        IPartyUCC partyucc = (IPartyUCC)SysContext.getBean("ccp_partyUCC");
        Map map = partyucc.findPartyFee(request.getParameter("sid"));
        Hashtable ht = new Hashtable();
        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_RECID), UnicodeToRtfcode.outCode(CommonFuns.filterNull((String) map.get(CcpConstants.D015001))));
        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_PARTY), UnicodeToRtfcode.outCode(CodeUtil.interpertCode("PA",(String) map.get(CcpConstants.D015010))));
        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_CAPMONEY), UnicodeToRtfcode.outCode(CommonFuns.filterNull(CcpTools.convertMoney((String) map.get(CcpConstants.D015030),"0"))));
        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_MONEY), UnicodeToRtfcode.outCode(CommonFuns.filterNull((String) map.get(CcpConstants.D015030))));
        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUMMARY), UnicodeToRtfcode.outCode(CommonFuns.filterNull((String) map.get(CcpConstants.D015008))));
        String date = CommonFuns.getDateByFormat(CommonFuns.filterNull((String) map.get(CcpConstants.D015005)),"yyyyÄêMMÔÂddÈÕ");
        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_DATE), UnicodeToRtfcode.outCode(date));

        RTFParser parser = new RTFParser(ht);
        String filePath = getServletConfig().getServletContext().getRealPath("/") + File.separator + "file" + File.separator + "party" + File.separator + "template" + File.separator + "receive.doc";
        File file = new File(filePath);
        
     
        System.out.println(file);
        if (file.exists()) {
            FileInputStream fis = new FileInputStream(filePath);
            byte[] fileContent = new byte[fis.available()];
            fis.read(fileContent);
            fis.close();
            byte[] newFileContent = parser.returnNewContent(fileContent);
            String path = getServletConfig().getServletContext().getRealPath("/") + File.separator + "file" + File.separator + "party" + File.separator + "temp" + File.separator;
            String fileName = FileUtil.createFile(newFileContent, path, "doc");
            String relpath = "/file/party/temp/" + fileName;
            response.sendRedirect(relpath);
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