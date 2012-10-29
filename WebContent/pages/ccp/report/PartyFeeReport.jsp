<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.ccp.util.CcpConstants" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.ccp.ucc.IPartyUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.ccp.pojo.bo.PartyBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.math.BigDecimal" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String sdate = CommonFuns.filterNull((String) request.getAttribute("sdate"));
    String edate = CommonFuns.filterNull((String) request.getAttribute("edate"));
%>


    <style type="text/css">
        <!--
        .style1 {
            font-family: "����";
            font-size: 20px;
        }

        td {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
            color: #000000;
        }

        body {
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
        }

        -->
    </style>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function forPrint(form) {
            var sdate = "";
            var edate = "";
            if (document.all("form1:leaveSDate") == "" || document.all("form1:leaveEDate") == "") {
            
            } else {
                sdate = document.all("form1:leaveSDate").value;
                edate = document.all("form1:leaveEDate").value;
            }
            windowOpen("/pages/ccp/report/FeeReportPrint.jsf?pid=" + document.all("superId").value + "&sdate=" + sdate + "&edate=" + edate, "", "status=no,toolbar=no,menubar=yes,location=no", "900", "600", "no");
        }



        function exportToExcel2() {
            try {
                var range = document.body.createTextRange();
                range.moveToElementText(dtable);
                range.execCommand('Copy');
                excel = new ActiveXObject('Excel.Application');
                excel.Application.Visible = true;
                book = excel.Workbooks.Add;
                sheet = book.Worksheets.Add;
                sheet.Paste;
            } catch(e) {
                alert("���ĵ��Կ���û�а�װMicrosoft Excel���������û�н���վ����Ϊ����վ�㡣")
                return false;
            }
        }
        //weitao add 
        function exportToExcel() {
            try {
                var range = document.body.createTextRange();
                range.moveToElementText(document.getElementById("datatable"));
                range.execCommand('Copy');
                excel = new ActiveXObject('Excel.Application');
                excel.Application.Visible = true;
                book = excel.Workbooks.Add;
                sheet = book.Worksheets.Add;
                sheet.Paste;
            } catch(e) {
                alert("���ĵ��Կ���û�а�װMicrosoft Excel���������û�н���վ����Ϊ����վ�㡣")
                return false;
            }
        }
      //weitao add end 
      
     //ԭ"��������ӡ"�¼�  return forPrint(document.forms(0))
    </script>

<h:form id="form1">
    <h:inputHidden id="reportList" value="#{ccp_PartyFeeListBB.reportList}"/>
    <f:verbatim>
    <input type="hidden" name="superId" value="<%=CommonFuns.filterNull(request.getParameter("superId"))%>">
    <input type="hidden" name="flag" value="2">
    </f:verbatim>
    <h:panelGrid width="100%" columns="2" border="0" cellspacing="0" cellpadding="0" styleClass="td_page">
        <h:panelGroup>
            <h:outputText value="ҵ��ʱ�䣺"/>
            <h:inputText id="leaveSDate" value="#{ccp_PartyFeeListBB.leaveSDate}" size="12" styleClass="input"/>
            <h:commandButton value="" styleClass="button_date"
                             onclick="PopUpCalendarDialog('form1:leaveSDate');return false;"/>
            <h:outputText value=" "/>
            <h:outputText value="��"/>
            <h:outputText value=" "/>
            <h:inputText id="leaveEDate" value="#{ccp_PartyFeeListBB.leaveEDate}" size="12" styleClass="input"/>
            <h:commandButton value="" styleClass="button_date"
                             onclick="PopUpCalendarDialog('form1:leaveEDate');return false;"/>
            <h:outputText value=" "/>
            <h:commandButton value=" ��ѯ " styleClass="button01" action="#{ccp_PartyFeeListBB.queryPartyFeeReport}"/>
        </h:panelGroup>
        <h:panelGrid columns="1" align="right">
            <h:commandButton value="��������ӡ" type="button" onclick="return  exportToExcel()" styleClass="button01"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

<f:verbatim>
<br>

<form name="form2">
<input type="hidden" name="content" value="">
<table  id="datatable" width="100%" border="0" align="center" cellpadding="0" cellspacing="8">
   <tr>
     <td>
       <table width="95%" border="0" align="center" cellpadding="0" cellspacing="8" >
    <tr>
        <td align="center"><span class="style1">������֧��������</span></td>
    </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" id="dtable">
    <tr>
        <td>���λ��<%=CommonFuns.filterNull(CodeUtil.interpertCode("PA", request.getParameter("superId")))%></td>
        <%
            if (sdate.equals("") && edate.equals("")) {
        %>
        <td align="center"><%=CommonFuns.getSysDate("yyyy")%>��01��01�� ��&nbsp;<%=CommonFuns.getSysDate("yyyy")%>��12��31�� </td>
        <%
        } else if (!sdate.equals("") && !edate.equals("")) {
        %>
        <td align="center"><%=sdate.substring(0, 4)%>��<%=sdate.substring(5, 7)%>��<%=sdate.substring(8)%>��
            ��&nbsp;<%=edate.substring(0, 4)%>��<%=edate.substring(5, 7)%>��<%=edate.substring(8)%>�� </td>
        <%
            }
        %>
        <td align="right"><%=CommonFuns.getSysDate("yyyy��MM��dd��")%></td>
    </tr>
</table>
<%
    //��������ڻ���
    BigDecimal bz1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal bz2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal bz3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal bz4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal bz5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal bz6 = new BigDecimal(0.0);//��������
    BigDecimal bz7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal bz8 = new BigDecimal(0.0);//��������
    BigDecimal bz9 = new BigDecimal(0.0);//�ϼ�
    //ʡ����֧����
    BigDecimal bs1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal bs2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal bs3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal bs4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal bs5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal bs6 = new BigDecimal(0.0);//��������
    BigDecimal bs7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal bs8 = new BigDecimal(0.0);//��������
    BigDecimal bs9 = new BigDecimal(0.0);//�ϼ�
    //���м���֧����
    BigDecimal bd1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal bd2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal bd3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal bd4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal bd5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal bd6 = new BigDecimal(0.0);//��������
    BigDecimal bd7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal bd8 = new BigDecimal(0.0);//��������
    BigDecimal bd9 = new BigDecimal(0.0);//�ϼ�
    // ����ϼ�
    BigDecimal bsum1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal bsum2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal bsum3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal bsum4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal bsum5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal bsum6 = new BigDecimal(0.0);//��������
    BigDecimal bsum7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal bsum8 = new BigDecimal(0.0);//��������
    BigDecimal bsum9 = new BigDecimal(0.0);//�ϼ�

    //��������ڻ���
    BigDecimal lz1 = new BigDecimal(0.0);//�Ͻ�����
    BigDecimal lz2 = new BigDecimal(0.0);//�Ͻ���������ڻ�����ί
    BigDecimal lz3 = new BigDecimal(0.0);//�Ͻɵط���ί
    BigDecimal lz4 = new BigDecimal(0.0);//�Ͻ�ʡ����֧������ί
    BigDecimal lz5 = new BigDecimal(0.0);//�²���
    BigDecimal lz6 = new BigDecimal(0.0);//ѧϰ����
    BigDecimal lz7 = new BigDecimal(0.0);//�������֧��
    BigDecimal lz8 = new BigDecimal(0.0);//��������֧��
    BigDecimal lz9 = new BigDecimal(0.0);//���Ѳ���֧��
    BigDecimal lz10 = new BigDecimal(0.0);//����֧��
    BigDecimal lz11 = new BigDecimal(0.0);//С��
    BigDecimal lz12 = new BigDecimal(0.0);//�ϼ�
    BigDecimal lz13 = new BigDecimal(0.0);//����ĩ��浳����
    //ʡ����֧����
    BigDecimal ls1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal ls2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal ls3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal ls4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal ls5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal ls6 = new BigDecimal(0.0);//��������
    BigDecimal ls7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal ls8 = new BigDecimal(0.0);//��������
    BigDecimal ls9 = new BigDecimal(0.0);//�ϼ�
    BigDecimal ls10 = new BigDecimal(0.0);//����֧��
    BigDecimal ls11 = new BigDecimal(0.0);//С��
    BigDecimal ls12 = new BigDecimal(0.0);//�ϼ�
    BigDecimal ls13 = new BigDecimal(0.0);//����ĩ��浳����
    //���м���֧����
    BigDecimal ld1 = new BigDecimal(0.0);//����ʵ�浳����
    BigDecimal ld2 = new BigDecimal(0.0);//����ȵ�Ա���ɵ����ܶ�
    BigDecimal ld3 = new BigDecimal(0.0);//���м���֧������ί�Ͻ�
    BigDecimal ld4 = new BigDecimal(0.0);//ʡ����֧������ί�Ͻ�
    BigDecimal ld5 = new BigDecimal(0.0);//�ϼ�����֯����
    BigDecimal ld6 = new BigDecimal(0.0);//��������
    BigDecimal ld7 = new BigDecimal(0.0);//��Ϣ
    BigDecimal ld8 = new BigDecimal(0.0);//��������
    BigDecimal ld9 = new BigDecimal(0.0);//�ϼ�
    BigDecimal ld10 = new BigDecimal(0.0);//����֧��
    BigDecimal ld11 = new BigDecimal(0.0);//С��
    BigDecimal ld12 = new BigDecimal(0.0);//�ϼ�
    BigDecimal ld13 = new BigDecimal(0.0);//����ĩ��浳����

    BigDecimal lsum1 = new BigDecimal(0.0);//�Ͻ�����
    BigDecimal lsum2 = new BigDecimal(0.0);//�Ͻ���������ڻ�����ί
    BigDecimal lsum3 = new BigDecimal(0.0);//�Ͻɵط���ί
    BigDecimal lsum4 = new BigDecimal(0.0);//�Ͻ�ʡ����֧������ί
    BigDecimal lsum5 = new BigDecimal(0.0);//�²���
    BigDecimal lsum6 = new BigDecimal(0.0);//ѧϰ����֧��
    BigDecimal lsum7 = new BigDecimal(0.0);//�������֧��
    BigDecimal lsum8 = new BigDecimal(0.0);//��������֧��
    BigDecimal lsum9 = new BigDecimal(0.0);//���Ѳ���֧��
    BigDecimal lsum10 = new BigDecimal(0.0);//����֧��
    BigDecimal lsum11 = new BigDecimal(0.0);//С��
    BigDecimal lsum12 = new BigDecimal(0.0);//�ϼ�
    BigDecimal lsum13 = new BigDecimal(0.0);//����ĩ��浳����
    try {
//        IPartyUCC partyucc = (IPartyUCC) SysContext.getBean("ccp_partyUCC");
//        List list = partyucc.queryPartyFeeReport(request.getParameter("superId"));
        List list = (List) request.getAttribute("feereport");
       
        if (list == null || list.size() == 0) {
%>
<table width="95%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse">
    <tr>
        <td rowspan="2" align="center">&nbsp;</td>
        <td width="80" rowspan="2" align="center">����ʵ�浳����</td>
        <td colspan="8" align="center">����</td>
    </tr>
    <tr>
        <td width="80" align="center">����ȵ�Ա���ɵ����ܶ�</td>
        <td width="80" align="center">���м���֧������ί�Ͻ�</td>
        <td width="80" align="center">ʡ����֧������ί�Ͻ�</td>
        <td width="80" align="center">�ϼ�����֯����</td>
        <td width="80" align="center">��������</td>
        <td width="80" align="center">��Ϣ</td>
        <td width="80" align="center">��������</td>
        <td width="80" align="center">�ϼ�</td>
    </tr>
    <tr>
        <td align="center">��</td>
        <td align="center">1</td>
        <td align="center">2</td>
        <td align="center">3</td>
        <td align="center">4</td>
        <td align="center">5</td>
        <td align="center">6</td>
        <td align="center">7</td>
        <td align="center">8</td>
        <td align="center">9</td>
    </tr>
    <tr>
        <td align="center">��������ڻ���</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right" bgcolor="#00CCCC">0</td>
    </tr>
    <tr>
        <td align="center">ʡ����֧����</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right" bgcolor="#00CCCC">0</td>
    </tr>
    <tr>
        <td align="center">���м���֧����</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right">&nbsp;</td>
        <td align="right" bgcolor="#00CCCC">0</td>
    </tr>
    <tr>
        <td align="center">�ܼ�</td>
        <td align="right" bgcolor="#00CCCC">0</td>
        <td align="right" bgcolor="#00CCCC">0</td>
        <td align="right" bgcolor="#00CCCC">0</td>
        <td align="right" bgcolor="#00CCCC">0</td>
        <td align="right" bgcolor="#00CCCC">0</td>
        <td align="right" bgcolor="#00CCCC">0</td>
        <td align="right" bgcolor="#00CCCC">0</td>
        <td align="right" bgcolor="#00CCCC">0</td>
        <td align="right" bgcolor="#00CCCC">0</td>
    </tr>
</table>
<br>
<table width="95%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse">
<tr>
    <td rowspan="3" align="center">&nbsp;</td>
    <td colspan="12" align="center">֧��</td>
    <td width="80" rowspan="3" align="center">����δ��浳����</td>
</tr>
<tr>
    <td width="80" rowspan="2" align="center">�Ͻ�����</td>
    <td width="80" rowspan="2" align="center">�Ͻ���������ڻ�����ί</td>
    <td width="80" rowspan="2" align="center">�Ͻɵط���ί</td>
    <td width="80" rowspan="2" align="center">�Ͻ�ʡ����֧������ί</td>
    <td width="80" rowspan="2" align="center">�²���</td>
    <td colspan="6" align="center">ʹ��</td>
    <td width="30" rowspan="2" align="center">�ϼ�</td>
</tr>
<tr>
    <td width="30" align="center">ѧϰ����</td>
    <td width="30" align="center">�������</td>
    <td width="30" align="center">��������</td>
    <td width="30" align="center">���Ѳ���</td>
    <td width="30" align="center">����</td>
    <td width="30" align="center">С��</td>
</tr>
<tr>
    <td align="center">��</td>
    <td align="center">11</td>
    <td align="center">12</td>
    <td align="center">13</td>
    <td align="center">14</td>
    <td align="center">15</td>
    <td align="center">16</td>
    <td align="center">17</td>
    <td align="center">18</td>
    <td align="center">19</td>
    <td align="center">20</td>
    <td align="center">21</td>
    <td align="center">22</td>
    <td align="center">23</td>
</tr>
<tr>
    <td align="center">��������ڻ���</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
</tr>
<tr>
    <td align="center">ʡ����֧����</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
</tr>
<tr>
    <td align="center">���м���֧����</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right">&nbsp;</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
</tr>
<tr>
    <td align="center">�ܼ�</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC">0</td>
</tr>
</table>
<%
} else {
    for (int i = 0; i < list.size(); i++) {
        Map map = (Map) list.get(i);
        PartyBO bo = SysCacheTool.findParty(CommonFuns.filterNull((String) map.get("PARTYID")));
        if (bo == null) {
            bo = SysCacheTool.findParty(request.getParameter("superId"));
        }
        String partyType = bo.getMemberType();
        String superId = bo.getSuperId();
        String bsubject = CommonFuns.filterNull((String) map.get(CcpConstants.D015015));
        String lsubject = CommonFuns.filterNull((String) map.get(CcpConstants.D015020));
        String bvalue = CommonFuns.filterNull(String.valueOf(map.get(CcpConstants.D015025)));
        if (bvalue.trim().equals("")) {
            bvalue = "0.0";
        }
        String lvalue = CommonFuns.filterNull(String.valueOf(map.get(CcpConstants.D015030)));
        if (lvalue.trim().equals("")) {
            lvalue = "0.0";
        }

        if (partyType.equals("0891101")) {//�ϼ�
            //�跽��Ŀ
            if (bsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                bz1 = bz1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10453002")) {//��ĩ��浳����
                lz13 = lz13.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455001")) {//��Ա���ɵ���
                bz2 = bz2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                bz3 = bz3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                bz4 = bz4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455004")) {//�ϼ�����֯����
                bz5 = bz5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455005")) {//��������
                bz6 = bz6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455006")) {//��Ϣ����
                bz7 = bz7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455007")) {//��������
                bz8 = bz8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456001")) {//�Ͻ�����
                lz1 = lz1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456002")) {//�Ͻ��ϼ���ί
                lz2 = lz2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456003")) {//�Ͻ�һ����֧������ί
                lz2 = lz2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456004")) {//�Ͻɵط���ί
                lz4 = lz4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456005")) {//�²���
                lz3 = lz3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456006")) {//ѧϰ����֧��
                lz5 = lz5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456007")) {//�������֧��
                lz6 = lz6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456008")) {//��������֧��
                lz7 = lz7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456009")) {//���Ѳ���֧��
                lz8 = lz8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456010")) {//�������
                lz9 = lz9.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456099")) {//����֧��
                lz10 = lz10.add(new BigDecimal(bvalue));
            }
            //������Ŀ
            if (lsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                bz1 = bz1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10453002")) {//��ĩ��浳����
                lz13 = lz13.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455001")) {//��Ա���ɵ���
                bz2 = bz2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                bz3 = bz3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                bz4 = bz4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455004")) {//�ϼ�����֯����
                bz5 = bz5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455005")) {//��������
                bz6 = bz6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455006")) {//��Ϣ����
                bz7 = bz7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455007")) {//��������
                bz8 = bz8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456001")) {//�Ͻ�����
                lz1 = lz1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456002")) {//�Ͻ��ϼ���ί
                lz2 = lz2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456003")) {//�Ͻ�һ����֧������ί
                lz2 = lz2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456004")) {//�Ͻɵط���ί
                lz4 = lz4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456005")) {//�²���
                lz3 = lz3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456006")) {//ѧϰ����֧��
                lz5 = lz5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456007")) {//�������֧��
                lz6 = lz6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456008")) {//��������֧��
                lz7 = lz7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456009")) {//���Ѳ���֧��
                lz8 = lz8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456010")) {//�������
                lz9 = lz9.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456099")) {//����֧��
                lz10 = lz10.add(new BigDecimal(lvalue));
            }
        } else
        if (partyType.substring(5, 6).equals("1") || partyType.substring(5, 6).equals("9") || partyType.equals("0891900") && superId.equals("100"))
        {//ʡ����֧����
            //�跽��Ŀ
            if (bsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                bs1 = bs1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10453002")) {//��ĩ��浳����
                ls13 = ls13.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455001")) {//��Ա���ɵ���
                bs2 = bs2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                bs3 = bs3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                bs4 = bs4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455004")) {//�ϼ�����֯����
                bs5 = bs5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455005")) {//��������
                bs6 = bs6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455006")) {//��Ϣ����
                bs7 = bs7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455007")) {//��������
                bs8 = bs8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456001")) {//�Ͻ�����
                ls1 = ls1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                ls2 = ls2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                ls2 = ls2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                ls4 = ls4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456005")) {//�Ͻɵط���ί
                ls3 = ls3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456006")) {//�²���
                ls5 = ls5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456007")) {//ѧϰ����֧��
                ls6 = ls6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456008")) {//�������֧��
                ls7 = ls7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456009")) {//��������֧��
                ls8 = ls8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456010")) {//���Ѳ���֧��
                ls9 = ls9.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456099")) {//����֧��
                ls10 = ls10.add(new BigDecimal(bvalue));
            }
            //������Ŀ
            if (lsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                bs1 = bs1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10453002")) {//��ĩ��浳����
                ls13 = ls13.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455001")) {//��Ա���ɵ���
                bs2 = bs2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                bs3 = bs3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                bs4 = bs4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455004")) {//�ϼ�����֯����
                bs5 = bs5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455005")) {//��������
                bs6 = bs6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455006")) {//��Ϣ����
                bs7 = bs7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455007")) {//��������
                bs8 = bs8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456001")) {//�Ͻ�����
                ls1 = ls1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                ls2 = ls2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                ls2 = ls2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                ls4 = ls4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456005")) {//�Ͻɵط���ί
                ls3 = ls3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456006")) {//�²���
                ls5 = ls5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456007")) {//ѧϰ����֧��
                ls6 = ls6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456008")) {//�������֧��
                ls7 = ls7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456009")) {//��������֧��
                ls8 = ls8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456010")) {//���Ѳ���֧��
                ls9 = ls9.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456099")) {//����֧��
                ls10 = ls10.add(new BigDecimal(lvalue));
            }
        } else {//���м���֧����
            //�跽��Ŀ
            if (bsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                bd1 = bd1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10453002")) {//��ĩ��浳����
                ld13 = ld13.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455001")) {//��Ա���ɵ���
                bd2 = bd2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                bd3 = bd3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                bd4 = bd4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455004")) {//�ϼ�����֯����
                bd5 = bd5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455005")) {//��������
                bd6 = bd6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455006")) {//��Ϣ����
                bd7 = bd7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455007")) {//��������
                bd8 = bd8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456001")) {//�Ͻ�����
                ld1 = ld1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456002")) {//�Ͻ���������ڻ�����ί
                ld2 = ld2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456003")) {//�Ͻ��ϼ���ί
                ld2 = ld2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456004")) {//�Ͻ�ʡ����֧������ί
                ld4 = ld4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456005")) {//�Ͻɵط���ί
                ld3 = ld3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456006")) {//�²���
                ld5 = ld5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456007")) {//ѧϰ����֧��
                ld6 = ld6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456008")) {//�������֧��
                ld7 = ld7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456009")) {//��������֧��
                ld8 = ld8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456010")) {//���Ѳ���֧��
                ld9 = ld9.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456099")) {//����֧��
                ld10 = ld10.add(new BigDecimal(bvalue));
            }
            //������Ŀ
            if (lsubject.equals("10453001")) {//�ڳ�ʵ�浳����
                bd1 = bd1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10453002")) {//��ĩ��浳����
                ld13 = ld13.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455001")) {//��Ա���ɵ���
                bd2 = bd2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455002")) {//���м���֧������ί�Ͻ�
                bd3 = bd3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455003")) {//ʡ����֧������ί�Ͻ�
                bd4 = bd4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455004")) {//�ϼ�����֯����
                bd5 = bd5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455005")) {//��������
                bd6 = bd6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455006")) {//��Ϣ����
                bd7 = bd7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455007")) {//��������
                bd8 = bd8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456001")) {//�Ͻ�����
                ld1 = ld1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456002")) {//�Ͻ��ϼ���ί
                ld2 = ld2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456003")) {//�Ͻ�һ����֧������ί
                ld2 = ld2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456004")) {//�Ͻɵط���ί
                ld4 = ld4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456005")) {//�²���
                ld3 = ld3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456006")) {//ѧϰ����֧��
                ld5 = ld5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456007")) {//�������֧��
                ld6 = ld6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456008")) {//��������֧��
                ld7 = ld7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456009")) {//���Ѳ���֧��
                ld8 = ld8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456010")) {//�������
                ld9 = ld9.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456099")) {//����֧��
                ld10 = ld10.add(new BigDecimal(lvalue));
            }
        }
    }
    bz9 = bz2.add(bz3).add(bz4).add(bz5).add(bz6).add(bz7).add(bz8);
    lz11 = lz6.add(lz7).add(lz8).add(lz9).add(lz10);
    lz12 = lz1.add(lz2).add(lz3).add(lz4).add(lz5).add(lz11);
    lz13 = bz1.add(bz9).add(lz12.multiply(new BigDecimal(-1)));

    bs9 = bs2.add(bs3).add(bs4).add(bs5).add(bs6).add(bs7).add(bs8);
    ls11 = ls6.add(ls7).add(ls8).add(ls9).add(ls10);
    ls12 = ls1.add(ls2).add(ls3).add(ls4).add(ls5).add(ls11);
    ls13 = bs1.add(bs9).add(ls12.multiply(new BigDecimal(-1)));

    bd9 = bd2.add(bd3).add(bd4).add(bd5).add(bd6).add(bd7).add(bd8);
    ld11 = ld6.add(ld7).add(ld8).add(ld9).add(ld10);
    ld12 = ld1.add(ld2).add(ld3).add(ld4).add(ld5).add(ld11);
    ld13 = bd1.add(bd9).add(ld12.multiply(new BigDecimal(-1)));

    bsum1 = bz1.add(bs1).add(bd1);//����ʵ�浳����
    bsum2 = bz2.add(bs2).add(bd2);//����ȵ�Ա���ɵ����ܶ�
    bsum3 = bz3.add(bs3).add(bd3);//���м���֧������ί�Ͻ�
    bsum4 = bz4.add(bs4).add(bd4);//ʡ����֧������ί�Ͻ�
    bsum5 = bz5.add(bs5).add(bd5);//�ϼ�����֯����
    bsum6 = bz6.add(bs6).add(bd6);//��������
    bsum7 = bz7.add(bs7).add(bd7);//��Ϣ
    bsum8 = bz8.add(bs8).add(bd8);//��������
    bsum9 = bz9.add(bs9).add(bd9);//�ϼ�

    lsum1 = lz1.add(ls1).add(ld1);//�Ͻ�����
    lsum2 = lz2.add(ls2).add(ld2);//�Ͻ�һ����֧������ί
    lsum3 = lz3.add(ls3).add(ld3);//�Ͻɵط���ί
    lsum4 = lz4.add(ls4).add(ld4);//�Ͻ�ʡ����֧������ί
    lsum5 = lz5.add(ls5).add(ld5);//�²���
    lsum6 = lz6.add(ls6).add(ld6);//ѧϰ����֧��
    lsum7 = lz7.add(ls7).add(ld7);//�������֧��
    lsum8 = lz8.add(ls8).add(ld8);//��������֧��
    lsum9 = lz9.add(ls9).add(ld9);//���Ѳ���֧��
    lsum10 = lz10.add(ls10).add(ld10);//����֧��
    lsum11 = lz11.add(ls11).add(ld11);//С��
    lsum12 = lz12.add(ls12).add(ld12);//�ϼ�
    lsum13 = lz13.add(ls13).add(ld13);//����ĩ��浳����
%>
<table width="95%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse">
<tr>
    <td rowspan="2" align="center">&nbsp;</td>
    <td width="80" rowspan="2" align="center">����ʵ�浳����</td>
    <td colspan="8" align="center">����</td>
</tr>
<tr>
    <td width="80" align="center">����ȵ�Ա���ɵ����ܶ�</td>
    <td width="80" align="center">���м���֧������ί�Ͻ�</td>
    <td width="80" align="center">ʡ����֧������ί�Ͻ�</td>
    <td width="80" align="center">�ϼ�����֯����</td>
    <td width="80" align="center">��������</td>
    <td width="80" align="center">��Ϣ</td>
    <td width="80" align="center">��������</td>
    <td width="80" align="center">�ϼ�</td>
</tr>
<tr>
    <td align="center">��</td>
    <td align="center">1</td>
    <td align="center">2</td>
    <td align="center">3</td>
    <td align="center">4</td>
    <td align="center">5</td>
    <td align="center">6</td>
    <td align="center">7</td>
    <td align="center">8</td>
    <td align="center">9</td>
</tr>
<tr>
    <td align="center">��������ڻ���</td>
    <%
        if (bz1.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bz1)%></td>
    <%
        }
        if (bz2.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bz2)%></td>
    <%
        }
        if (bz3.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bz3)%></td>
    <%
        }
        if (bz4.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bz4)%></td>
    <%
        }
        if (bz5.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bz5)%></td>
    <%
        }
        if (bz6.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bz6)%></td>
    <%
        }
        if (bz7.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bz7)%></td>
    <%
        }
        if (bz8.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bz8)%></td>
    <%
        }
    %>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bz9)%></td>
</tr>
<tr>
    <td align="center">ʡ����֧����</td>
    <%
        if (bs1.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bs1)%></td>
    <%
        }
        if (bs2.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bs2)%></td>
    <%
        }
        if (bs3.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bs3)%></td>
    <%
        }
        if (bs4.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bs4)%></td>
    <%
        }
        if (bs5.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bs5)%></td>
    <%
        }
        if (bs6.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bs6)%></td>
    <%
        }
        if (bs7.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bs7)%></td>
    <%
        }
        if (bs8.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bs8)%></td>
    <%
        }
    %>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bs9)%></td>
</tr>
<tr>
    <td align="center">���м���֧����</td>
    <%
        if (bd1.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bd1)%></td>
    <%
        }
        if (bd2.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bd2)%></td>
    <%
        }
        if (bd3.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bd3)%></td>
    <%
        }
        if (bd4.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bd4)%></td>
    <%
        }
        if (bd5.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bd5)%></td>
    <%
        }
        if (bd6.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bd6)%></td>
    <%
        }
        if (bd7.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bd7)%></td>
    <%
        }
        if (bd8.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(bd8)%></td>
    <%
        }
    %>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bd9)%></td>
</tr>
<tr>
    <td align="center">�ܼ�</td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum1)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum2)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum3)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum4)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum5)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum6)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum7)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum8)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(bsum9)%></td>
</tr>
</table>
<br>
<table width="95%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse">
<tr>
    <td rowspan="3" align="center">&nbsp;</td>
    <td colspan="12" align="center">֧��</td>
    <td width="80" rowspan="3" align="center">����δ��浳����</td>
</tr>
<tr>
    <td width="80" rowspan="2" align="center">�Ͻ�����</td>
    <td width="80" rowspan="2" align="center">�Ͻ���������ڻ�����ί</td>
    <td width="80" rowspan="2" align="center">�Ͻɵط���ί</td>
    <td width="80" rowspan="2" align="center">�Ͻ�ʡ����֧������ί</td>
    <td width="80" rowspan="2" align="center">�²���</td>
    <td colspan="6" align="center">ʹ��</td>
    <td width="30" rowspan="2" align="center">�ϼ�</td>
</tr>
<tr>
    <td width="30" align="center">ѧϰ����</td>
    <td width="30" align="center">�������</td>
    <td width="30" align="center">��������</td>
    <td width="30" align="center">���Ѳ���</td>
    <td width="30" align="center">����</td>
    <td width="30" align="center">С��</td>
</tr>
<tr>
    <td align="center">��</td>
    <td align="center">11</td>
    <td align="center">12</td>
    <td align="center">13</td>
    <td align="center">14</td>
    <td align="center">15</td>
    <td align="center">16</td>
    <td align="center">17</td>
    <td align="center">18</td>
    <td align="center">19</td>
    <td align="center">20</td>
    <td align="center">21</td>
    <td align="center">22</td>
    <td align="center">23</td>
</tr>
<tr>
    <td align="center">��������ڻ���</td>
    <%
        if (lz1.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz1)%></td>
    <%
        }
    %>
    <td align="right">&nbsp;</td>
    <%
        if (lz2.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz2)%></td>
    <%
        }
        if (lz3.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz3)%></td>
    <%
        }
        if (lz4.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz4)%></td>
    <%
        }
        if (lz5.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz5)%></td>
    <%
        }
        if (lz6.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz6)%></td>
    <%
        }
        if (lz7.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz7)%></td>
    <%
        }
        if (lz8.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz8)%></td>
    <%
        }
        if (lz10.equals(new BigDecimal(0.0)) && lz9.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(lz10.add(lz9))%></td>
    <%
        }
    %>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lz11)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lz12)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lz13)%></td>
</tr>
<tr>
    <td align="center">ʡ����֧����</td>
    <%
        if (ls1.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls1)%></td>
    <%
        }
    %>
    <td align="right">&nbsp;</td>
    <%
        if (ls2.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls2)%></td>
    <%
        }
        if (ls3.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls3)%></td>
    <%
        }
        if (ls4.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls4)%></td>
    <%
        }
        if (ls5.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls5)%></td>
    <%
        }
        if (ls6.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls6)%></td>
    <%
        }
        if (ls7.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls7)%></td>
    <%
        }
        if (ls8.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls8)%></td>
    <%
        }

        if (ls10.equals(new BigDecimal(0.0)) && ls9.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ls10.add(ls9))%></td>
    <%
        }
    %>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(ls11)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(ls12)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(ls13)%></td>
</tr>
<tr>
    <td align="center">���м���֧����</td>
    <%
        if (ld1.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld1)%></td>
    <%
        }
    %>
    <td align="right">&nbsp;</td>
    <%
        if (ld2.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld2)%></td>
    <%
        }
        if (ld3.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld3)%></td>
    <%
        }
        if (ld4.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld4)%></td>
    <%
        }
        if (ld5.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld5)%></td>
    <%
        }
        if (ld6.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld6)%></td>
    <%
        }
        if (ld7.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld7)%></td>
    <%
        }
        if (ld8.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld8)%></td>
    <%
        }

        if (ld10.equals(new BigDecimal(0.0)) && ld9.equals(new BigDecimal(0.0))) {
    %>
    <td align="right">&nbsp;</td>
    <%
    } else {
    %>
    <td align="right"><%=String.valueOf(ld10.add(ld9))%></td>
    <%
        }
    %>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(ld11)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(ld12)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(ld13)%></td>
</tr>
<tr>
    <td align="center">�ܼ�</td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum1)%></td>
    <td align="right" bgcolor="#00CCCC">0</td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum2)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum3)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum4)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum5)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum6)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum7)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum8)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum10.add(lsum9))%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum11)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum12)%></td>
    <td align="right" bgcolor="#00CCCC"><%=String.valueOf(lsum13)%></td>
</tr>
</table>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
     </td>
   </tr>
</table>
</form>
</f:verbatim>
 
