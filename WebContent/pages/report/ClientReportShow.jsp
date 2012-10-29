<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="com.hr319wg.rpt.service.RptClient"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%
    // 用前段控件显示表格，对应薪资发放界面的直接打开
    //变量声明
    String strFileName;     //文件名
    String strPath;
    File objFile;             //文件对象
    FileInputStream objFileReader; //读文件对象
    String RptCode = request.getParameter("RptCode");
    String ID = CommonFuns.filterNull(request.getParameter("ID"));
    String ORGUID = CommonFuns.filterNull(request.getParameter("ORGUID"));
    String Parameter = CommonFuns.filterNull(request.getParameter("Parameter"));
    String Title = CommonFuns.filterNull(request.getParameter("Title"));
    String Command = CommonFuns.filterNull(request.getParameter("Command"));
    byte[] chrBuffer = new byte[5000];  //缓冲
    int intLength;                    //实际读出的字符数(一个中文为一个字符)
    strPath = application.getRealPath("/");

    //--------------产生报表---------------------
    User user = (User) session.getAttribute(Constants.USER_INFO);
    RptClient rc = (RptClient) SysContext.getBean("rpt_infoClient");
    rc.setID(ID);
    rc.setOrguid(ORGUID);
    rc.setParameter(Parameter);
    rc.setUserInfo(user);
    rc.setPath(strPath);
    rc.setRptCode(RptCode);
    rc.setCommand(Command);
    rc.setTitle(Title);
    if (session.getAttribute(Constants.ROSTER_CONDITION) != null) {
        // 登记表数据源 花名册附加条件
        rc.setWhereCondition(session.getAttribute(Constants.ROSTER_CONDITION).toString());
        // 用完必须清除session
        //session.removeAttribute(Constants.ROSTER_CONDITION);
    } else {
        rc.setWhereCondition("");
    }
    strFileName = rc.GenerateReport();
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/pages/cache/";
    String strurl = basePath + strFileName.substring(strFileName.lastIndexOf("\\") + 1);
%>
<body MS_POSITIONING="GridLayout">
    <OBJECT id="FormulaPrint" style="Z-INDEX: 101; LEFT: 88px; POSITION: absolute; TOP: 32px" codeBase="rptprint.cab"
        classid="clsid:C3EFDE64-5B3A-4220-B004-6ADD4E89D4A0" VIEWASTEXT>
    </OBJECT>
    <form id="Form1" method="post" runat="server">
        <FONT face="宋体"></FONT>
    </form>
    <script language="javascript">
         FormulaPrint.ShowXls("<%=strurl%>");
         window.close();
    </script>
</body>

