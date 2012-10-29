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
    // ��ʾ���̱�� 
    OutputStream os = response.getOutputStream();
    //��������
    String strFileName;     //�ļ���
    String strPath;
    File objFile;             //�ļ�����
    FileInputStream objFileReader; //���ļ�����
    String Title = request.getParameter("Title");
    String RptCode = request.getParameter("RptCode");
    String ID = CommonFuns.filterNull(request.getParameter("ID"));
    String ORGUID = CommonFuns.filterNull(request.getParameter("ORGUID"));
    String Parameter = CommonFuns.filterNull(request.getParameter("Parameter"));
    String Command = CommonFuns.filterNull(request.getParameter("Command"));
    String Where = CommonFuns.filterNull(request.getParameter("Where"));

    byte[] chrBuffer = new byte[5000];  //����
    int intLength;                    //ʵ�ʶ������ַ���(һ������Ϊһ���ַ�)
    strPath = application.getRealPath("/");

    //--------------��������---------------------
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

    // ����ļ�
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

    //�����ļ�����
    objFile = new java.io.File(strFileName);
    //--------------���ؽ��------------------
    //�ж��ļ��Ƿ����
    if (objFile.exists()) {//�ļ�����
        //�������ļ�����
        objFileReader = new java.io.FileInputStream(objFile);
        //���ļ�����
        while ((intLength = objFileReader.read(chrBuffer)) != -1) {
            //���
            os.write(chrBuffer, 0, intLength);
        }

        //�رն��ļ�����
        objFileReader.close();
    } else { //�ļ�������
        out.println("�����ļ������ڣ�" + strFileName);
    }
    os.flush();
    os.close();
%>

