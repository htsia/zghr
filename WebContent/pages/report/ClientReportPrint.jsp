<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="com.hr319wg.rpt.service.RptClient"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ include file="../include/taglib.jsp" %>
<link href="/css/style.css" rel="stylesheet" type="text/css"/>
<%
     // ��ǰ�οؼ���ӡ��񣬶�Ӧн�ʷ��Ž����ֱ�Ӵ�
     //��������
     String strFileName;     //�ļ���
     String strPath;
     File objFile;             //�ļ�����
     FileInputStream  objFileReader; //���ļ�����
     String RptCode=request.getParameter("RptCode");
     String ID=request.getParameter("ID");
     String ORGUID=request.getParameter("ORGUID");
     String Parameter=request.getParameter("Parameter");
     String Title=request.getParameter("Title");
     String Command=request.getParameter("Command");
     byte[] chrBuffer = new byte[5000];  //����
     int intLength;                    //ʵ�ʶ������ַ���(һ������Ϊһ���ַ�)
     strPath=application.getRealPath("/");

    //--------------��������---------------------
     User user = (User) session.getAttribute(Constants.USER_INFO);
     RptClient rc=(RptClient)SysContext.getBean("rpt_infoClient");
     rc.setID(ID);
     rc.setOrguid(ORGUID);
     rc.setParameter(Parameter);
     rc.setUserInfo(user);
     rc.setPath(strPath);
     rc.setRptCode(RptCode);
     rc.setCommand(Command);
     rc.setTitle(Title);
    String  strurl="";
    String []url=null;
    if (request.getParameter("depts")!=null){   // �ಿ�Ŵ�ӡ
         String []selectdeptList=request.getParameter("depts").split(",");
         url=new String[selectdeptList.length];
         for(int i=0;i<selectdeptList.length;i++){
             rc.setWhereCondition(" A001.A001743='"+selectdeptList[i]+"'");
             strFileName=rc.GenerateReport();
             String path = request.getContextPath();
             String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/pages/cache/";
             strurl= basePath+strFileName.substring(strFileName.lastIndexOf("\\")+1);
             url[i]=strurl;
         }
     }
     else{ 
        if (session.getAttribute(Constants.ROSTER_CONDITION)!=null){
             // �ǼǱ�����Դ �����ḽ������
             rc.setWhereCondition(session.getAttribute(Constants.ROSTER_CONDITION).toString());
             // ����������session
             session.removeAttribute(Constants.ROSTER_CONDITION);
         }
         else{
             rc.setWhereCondition("");
         }
         strFileName=rc.GenerateReport();
         String path = request.getContextPath();
         String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/pages/cache/";
         strurl= basePath+strFileName.substring(strFileName.lastIndexOf("\\")+1);
         url=new String[1];
         url[0]=strurl;
     }
  %>
<body MS_POSITIONING="GridLayout">
    <OBJECT id="FormulaPrint" style="Z-INDEX: 101; LEFT: -88px; POSITION: absolute; TOP: -32px" codeBase="rptprint.cab"
        classid="clsid:C3EFDE64-5B3A-4220-B004-6ADD4E89D4A0" VIEWASTEXT>
    </OBJECT>
    <table height=98% width=98%>
        <tr><td align="center" valign="middle">
        <FONT face="����">���ڴ�ӡ,��ȴ�....</FONT>
        </td></tr>
    </table>
    <script language="javascript">
    <%
       String urlString=url[0];
       for(int i=1;i<url.length;i++){
          urlString+="\t"+url[i];
       }
       out.println("FormulaPrint.PrintXls('"+urlString+"');");
    %>
     window.close();
    </script>
</body>

