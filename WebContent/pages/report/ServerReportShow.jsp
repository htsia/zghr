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
    // ��Ӧн�ʷ����е�excel�򿪰�Ŧ
    // ��excel��ʽ��ʾ���
    OutputStream os = response.getOutputStream();
    //��������
    String strFileName;     //�ļ���
    String strPath;
    File objFile;             //�ļ�����
    FileInputStream objFileReader; //���ļ�����
    String RptCode = request.getParameter("RptCode");
    String ID = CommonFuns.filterNull(request.getParameter("ID"));
    String ORGUID = CommonFuns.filterNull(request.getParameter("ORGUID"));
    String Parameter = CommonFuns.filterNull(request.getParameter("Parameter"));
    String Title = CommonFuns.filterNull(request.getParameter("Title"));
    String Command = CommonFuns.filterNull(request.getParameter("Command"));
    String Where= CommonFuns.filterNull(request.getParameter("Where"));
    byte[] chrBuffer = new byte[5000];  //����
    int intLength;                    //ʵ�ʶ������ַ���(һ������Ϊһ���ַ�)
    strPath = application.getRealPath("/");

    //--------------��������---------------------
    User user = (User) session.getAttribute(Constants.USER_INFO);
    RptClient rc = (RptClient) SysContext.getBean("rpt_infoClient");
    rc.setID(ID);
    rc.setOrguid(ORGUID);
    rc.setParameter(Parameter);
    rc.setUserInfo(user);
    rc.setPath(strPath);
    rc.setRptCode(RptCode);
    rc.setWhereCondition("");
    rc.setCommand(Command);
    rc.setTitle(Title);
    if (!"".equals(Where)){
        rc.setWhereCondition(Where);
    }
    else if (session.getAttribute(Constants.ROSTER_CONDITION) != null) {
        // �ǼǱ�����Դ �����ḽ������
        rc.setWhereCondition(session.getAttribute(Constants.ROSTER_CONDITION).toString());
        // ����������session
        session.removeAttribute(Constants.ROSTER_CONDITION);
    } else {
        rc.setWhereCondition("");
    }

    strFileName = rc.GenerateReport();

    // ����ļ�
    response.reset();
    response.resetBuffer();
    
    String ff = "";
    try {
        ff = strFileName.substring(strFileName.lastIndexOf("\\") + 1);
    }
    catch (Exception eee) {
        Random rd = new Random();
        long lint = Math.abs(rd.nextLong());
        ff = "r" + Long.toString(lint) + ".xls";
    }
	%>
	<script type="text/javascript">
		location.href="/pages/cache/<%=ff%>";
	</script>
	<%
%>

