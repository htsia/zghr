<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.util.Random"%>
<%@ page import="com.hr319wg.rpt.service.RptClient"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>

<%
    // 显示流程表格 
    OutputStream os = response.getOutputStream();
    //变量声明
    String strFileName;     //文件名
    String strPath;
    File objFile;             //文件对象
    FileInputStream objFileReader; //读文件对象
    String Title = request.getParameter("Title");
    String RptCode = request.getParameter("RptCode");
    String ID = CommonFuns.filterNull(request.getParameter("ID"));
    String ORGUID = CommonFuns.filterNull(request.getParameter("ORGUID"));
    String Parameter = CommonFuns.filterNull(request.getParameter("Parameter"));
    String Command = CommonFuns.filterNull(request.getParameter("Command"));
    String Where = CommonFuns.filterNull(request.getParameter("Where"));

    byte[] chrBuffer = new byte[5000];  //缓冲
    int intLength;                    //实际读出的字符数(一个中文为一个字符)
    strPath = application.getRealPath("/");

    //--------------产生报表---------------------
    User user = (User) session.getAttribute(Constants.USER_INFO);
    RptClient rc = (RptClient) SysContext.getBean("rpt_infoClient");
    rc.setUserInfo(user);
    rc.setRptCode(RptCode);
    rc.setID(ID);
    rc.setOrguid(ORGUID);
    rc.setParameter(Parameter);
    rc.setCommand(Command);
    rc.setWhereCondition(Where);
    rc.setPath(strPath);
    rc.setTitle(Title);
    strFileName = rc.RollORFlowReport();

    // 输出文件
    response.reset();
    response.resetBuffer();
    response.setContentType("application/vnd.ms-excel;charset=GBK");
    String ff = "";
    try {
        ff = strFileName.substring(strFileName.lastIndexOf("\\") + 1);
    }
    catch (Exception eee) {
        Random rd = new Random();
        long lint = Math.abs(rd.nextLong());
        ff = "r" + Long.toString(lint) + ".xls";
    }
    response.setHeader("Content-disposition", "inline;filename=" + ff);

    //创建文件对象
    objFile = new java.io.File(strFileName);
    //--------------返回结果------------------
    //判断文件是否存在
    if (objFile.exists()) {//文件存在
        //创建读文件对象
        objFileReader = new java.io.FileInputStream(objFile);
        //读文件内容
        while ((intLength = objFileReader.read(chrBuffer)) != -1) {
            //输出
            os.write(chrBuffer, 0, intLength);
        }

        //关闭读文件对象
        objFileReader.close();
    } else { //文件不存在
        out.println("下列文件不存在：" + strFileName);
    }
    os.flush();
    os.close();
%>

