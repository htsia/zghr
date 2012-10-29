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
            font-family: "黑体";
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
                alert("您的电脑可能没有安装Microsoft Excel软件，或者没有将本站点设为信任站点。")
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
                alert("您的电脑可能没有安装Microsoft Excel软件，或者没有将本站点设为信任站点。")
                return false;
            }
        }
      //weitao add end 
      
     //原"导出并打印"事件  return forPrint(document.forms(0))
    </script>

<h:form id="form1">
    <h:inputHidden id="reportList" value="#{ccp_PartyFeeListBB.reportList}"/>
    <f:verbatim>
    <input type="hidden" name="superId" value="<%=CommonFuns.filterNull(request.getParameter("superId"))%>">
    <input type="hidden" name="flag" value="2">
    </f:verbatim>
    <h:panelGrid width="100%" columns="2" border="0" cellspacing="0" cellpadding="0" styleClass="td_page">
        <h:panelGroup>
            <h:outputText value="业务时间："/>
            <h:inputText id="leaveSDate" value="#{ccp_PartyFeeListBB.leaveSDate}" size="12" styleClass="input"/>
            <h:commandButton value="" styleClass="button_date"
                             onclick="PopUpCalendarDialog('form1:leaveSDate');return false;"/>
            <h:outputText value=" "/>
            <h:outputText value="至"/>
            <h:outputText value=" "/>
            <h:inputText id="leaveEDate" value="#{ccp_PartyFeeListBB.leaveEDate}" size="12" styleClass="input"/>
            <h:commandButton value="" styleClass="button_date"
                             onclick="PopUpCalendarDialog('form1:leaveEDate');return false;"/>
            <h:outputText value=" "/>
            <h:commandButton value=" 查询 " styleClass="button01" action="#{ccp_PartyFeeListBB.queryPartyFeeReport}"/>
        </h:panelGroup>
        <h:panelGrid columns="1" align="right">
            <h:commandButton value="导出并打印" type="button" onclick="return  exportToExcel()" styleClass="button01"/>
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
        <td align="center"><span class="style1">党费收支结存情况表</span></td>
    </tr>
</table>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" id="dtable">
    <tr>
        <td>填报单位：<%=CommonFuns.filterNull(CodeUtil.interpertCode("PA", request.getParameter("superId")))%></td>
        <%
            if (sdate.equals("") && edate.equals("")) {
        %>
        <td align="center"><%=CommonFuns.getSysDate("yyyy")%>年01月01日 至&nbsp;<%=CommonFuns.getSysDate("yyyy")%>年12月31日 </td>
        <%
        } else if (!sdate.equals("") && !edate.equals("")) {
        %>
        <td align="center"><%=sdate.substring(0, 4)%>年<%=sdate.substring(5, 7)%>月<%=sdate.substring(8)%>日
            至&nbsp;<%=edate.substring(0, 4)%>年<%=edate.substring(5, 7)%>月<%=edate.substring(8)%>日 </td>
        <%
            }
        %>
        <td align="right"><%=CommonFuns.getSysDate("yyyy年MM月dd日")%></td>
    </tr>
</table>
<%
    //中央各金融机构
    BigDecimal bz1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal bz2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal bz3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal bz4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal bz5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal bz6 = new BigDecimal(0.0);//行政拨款
    BigDecimal bz7 = new BigDecimal(0.0);//利息
    BigDecimal bz8 = new BigDecimal(0.0);//其他收入
    BigDecimal bz9 = new BigDecimal(0.0);//合计
    //省级分支机构
    BigDecimal bs1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal bs2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal bs3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal bs4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal bs5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal bs6 = new BigDecimal(0.0);//行政拨款
    BigDecimal bs7 = new BigDecimal(0.0);//利息
    BigDecimal bs8 = new BigDecimal(0.0);//其他收入
    BigDecimal bs9 = new BigDecimal(0.0);//合计
    //地市级分支机构
    BigDecimal bd1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal bd2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal bd3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal bd4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal bd5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal bd6 = new BigDecimal(0.0);//行政拨款
    BigDecimal bd7 = new BigDecimal(0.0);//利息
    BigDecimal bd8 = new BigDecimal(0.0);//其他收入
    BigDecimal bd9 = new BigDecimal(0.0);//合计
    // 收入合计
    BigDecimal bsum1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal bsum2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal bsum3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal bsum4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal bsum5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal bsum6 = new BigDecimal(0.0);//行政拨款
    BigDecimal bsum7 = new BigDecimal(0.0);//利息
    BigDecimal bsum8 = new BigDecimal(0.0);//其他收入
    BigDecimal bsum9 = new BigDecimal(0.0);//合计

    //中央各金融机构
    BigDecimal lz1 = new BigDecimal(0.0);//上缴中央
    BigDecimal lz2 = new BigDecimal(0.0);//上缴中央各金融机构党委
    BigDecimal lz3 = new BigDecimal(0.0);//上缴地方党委
    BigDecimal lz4 = new BigDecimal(0.0);//上缴省级分支机构党委
    BigDecimal lz5 = new BigDecimal(0.0);//下拨款
    BigDecimal lz6 = new BigDecimal(0.0);//学习资料
    BigDecimal lz7 = new BigDecimal(0.0);//管理教育支出
    BigDecimal lz8 = new BigDecimal(0.0);//创先争优支出
    BigDecimal lz9 = new BigDecimal(0.0);//困难补助支出
    BigDecimal lz10 = new BigDecimal(0.0);//其他支出
    BigDecimal lz11 = new BigDecimal(0.0);//小计
    BigDecimal lz12 = new BigDecimal(0.0);//合计
    BigDecimal lz13 = new BigDecimal(0.0);//本年末结存党费数
    //省级分支机构
    BigDecimal ls1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal ls2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal ls3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal ls4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal ls5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal ls6 = new BigDecimal(0.0);//行政拨款
    BigDecimal ls7 = new BigDecimal(0.0);//利息
    BigDecimal ls8 = new BigDecimal(0.0);//其他收入
    BigDecimal ls9 = new BigDecimal(0.0);//合计
    BigDecimal ls10 = new BigDecimal(0.0);//其他支出
    BigDecimal ls11 = new BigDecimal(0.0);//小计
    BigDecimal ls12 = new BigDecimal(0.0);//合计
    BigDecimal ls13 = new BigDecimal(0.0);//本年末结存党费数
    //地市级分支机构
    BigDecimal ld1 = new BigDecimal(0.0);//上年实存党费数
    BigDecimal ld2 = new BigDecimal(0.0);//本年度党员交纳党费总额
    BigDecimal ld3 = new BigDecimal(0.0);//地市级分支机构党委上缴
    BigDecimal ld4 = new BigDecimal(0.0);//省级分支机构党委上缴
    BigDecimal ld5 = new BigDecimal(0.0);//上级党组织拨款
    BigDecimal ld6 = new BigDecimal(0.0);//行政拨款
    BigDecimal ld7 = new BigDecimal(0.0);//利息
    BigDecimal ld8 = new BigDecimal(0.0);//其他收入
    BigDecimal ld9 = new BigDecimal(0.0);//合计
    BigDecimal ld10 = new BigDecimal(0.0);//其他支出
    BigDecimal ld11 = new BigDecimal(0.0);//小计
    BigDecimal ld12 = new BigDecimal(0.0);//合计
    BigDecimal ld13 = new BigDecimal(0.0);//本年末结存党费数

    BigDecimal lsum1 = new BigDecimal(0.0);//上缴中央
    BigDecimal lsum2 = new BigDecimal(0.0);//上缴中央各金融机构党委
    BigDecimal lsum3 = new BigDecimal(0.0);//上缴地方党委
    BigDecimal lsum4 = new BigDecimal(0.0);//上缴省级分支机构党委
    BigDecimal lsum5 = new BigDecimal(0.0);//下拨款
    BigDecimal lsum6 = new BigDecimal(0.0);//学习资料支出
    BigDecimal lsum7 = new BigDecimal(0.0);//管理教育支出
    BigDecimal lsum8 = new BigDecimal(0.0);//创先争优支出
    BigDecimal lsum9 = new BigDecimal(0.0);//困难补助支出
    BigDecimal lsum10 = new BigDecimal(0.0);//其他支出
    BigDecimal lsum11 = new BigDecimal(0.0);//小计
    BigDecimal lsum12 = new BigDecimal(0.0);//合计
    BigDecimal lsum13 = new BigDecimal(0.0);//本年末结存党费数
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
        <td width="80" rowspan="2" align="center">上年实存党费数</td>
        <td colspan="8" align="center">收入</td>
    </tr>
    <tr>
        <td width="80" align="center">本年度党员缴纳党费总额</td>
        <td width="80" align="center">地市级分支机构党委上缴</td>
        <td width="80" align="center">省级分支机构党委上缴</td>
        <td width="80" align="center">上级党组织拨款</td>
        <td width="80" align="center">行政拨款</td>
        <td width="80" align="center">利息</td>
        <td width="80" align="center">其他收入</td>
        <td width="80" align="center">合计</td>
    </tr>
    <tr>
        <td align="center">甲</td>
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
        <td align="center">中央各金融机构</td>
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
        <td align="center">省级分支机构</td>
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
        <td align="center">地市级分支机构</td>
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
        <td align="center">总计</td>
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
    <td colspan="12" align="center">支出</td>
    <td width="80" rowspan="3" align="center">本年未结存党费数</td>
</tr>
<tr>
    <td width="80" rowspan="2" align="center">上缴中央</td>
    <td width="80" rowspan="2" align="center">上缴中央各金融机构党委</td>
    <td width="80" rowspan="2" align="center">上缴地方党委</td>
    <td width="80" rowspan="2" align="center">上缴省级分支机构党委</td>
    <td width="80" rowspan="2" align="center">下拨款</td>
    <td colspan="6" align="center">使用</td>
    <td width="30" rowspan="2" align="center">合计</td>
</tr>
<tr>
    <td width="30" align="center">学习资料</td>
    <td width="30" align="center">管理教育</td>
    <td width="30" align="center">创先争优</td>
    <td width="30" align="center">困难补助</td>
    <td width="30" align="center">其他</td>
    <td width="30" align="center">小计</td>
</tr>
<tr>
    <td align="center">甲</td>
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
    <td align="center">中央各金融机构</td>
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
    <td align="center">省级分支机构</td>
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
    <td align="center">地市级分支机构</td>
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
    <td align="center">总计</td>
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

        if (partyType.equals("0891101")) {//上级
            //借方科目
            if (bsubject.equals("10453001")) {//期初实存党费数
                bz1 = bz1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10453002")) {//期末结存党费数
                lz13 = lz13.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455001")) {//党员缴纳党费
                bz2 = bz2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455002")) {//地市级分支机构党委上缴
                bz3 = bz3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455003")) {//省级分支机构党委上缴
                bz4 = bz4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455004")) {//上级党组织拨款
                bz5 = bz5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455005")) {//行政拨款
                bz6 = bz6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455006")) {//利息收入
                bz7 = bz7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455007")) {//其他收入
                bz8 = bz8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456001")) {//上缴中央
                lz1 = lz1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456002")) {//上缴上级党委
                lz2 = lz2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456003")) {//上缴一级分支机构党委
                lz2 = lz2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456004")) {//上缴地方党委
                lz4 = lz4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456005")) {//下拨款
                lz3 = lz3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456006")) {//学习资料支出
                lz5 = lz5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456007")) {//管理教育支出
                lz6 = lz6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456008")) {//创先争优支出
                lz7 = lz7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456009")) {//困难补助支出
                lz8 = lz8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456010")) {//管理费用
                lz9 = lz9.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456099")) {//其他支出
                lz10 = lz10.add(new BigDecimal(bvalue));
            }
            //贷方科目
            if (lsubject.equals("10453001")) {//期初实存党费数
                bz1 = bz1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10453002")) {//期末结存党费数
                lz13 = lz13.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455001")) {//党员缴纳党费
                bz2 = bz2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455002")) {//地市级分支机构党委上缴
                bz3 = bz3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455003")) {//省级分支机构党委上缴
                bz4 = bz4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455004")) {//上级党组织拨款
                bz5 = bz5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455005")) {//行政拨款
                bz6 = bz6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455006")) {//利息收入
                bz7 = bz7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455007")) {//其他收入
                bz8 = bz8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456001")) {//上缴中央
                lz1 = lz1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456002")) {//上缴上级党委
                lz2 = lz2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456003")) {//上缴一级分支机构党委
                lz2 = lz2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456004")) {//上缴地方党委
                lz4 = lz4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456005")) {//下拨款
                lz3 = lz3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456006")) {//学习资料支出
                lz5 = lz5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456007")) {//管理教育支出
                lz6 = lz6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456008")) {//创先争优支出
                lz7 = lz7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456009")) {//困难补助支出
                lz8 = lz8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456010")) {//管理费用
                lz9 = lz9.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456099")) {//其他支出
                lz10 = lz10.add(new BigDecimal(lvalue));
            }
        } else
        if (partyType.substring(5, 6).equals("1") || partyType.substring(5, 6).equals("9") || partyType.equals("0891900") && superId.equals("100"))
        {//省级分支机构
            //借方科目
            if (bsubject.equals("10453001")) {//期初实存党费数
                bs1 = bs1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10453002")) {//期末结存党费数
                ls13 = ls13.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455001")) {//党员缴纳党费
                bs2 = bs2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455002")) {//地市级分支机构党委上缴
                bs3 = bs3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455003")) {//省级分支机构党委上缴
                bs4 = bs4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455004")) {//上级党组织拨款
                bs5 = bs5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455005")) {//行政拨款
                bs6 = bs6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455006")) {//利息收入
                bs7 = bs7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455007")) {//其他收入
                bs8 = bs8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456001")) {//上缴中央
                ls1 = ls1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456002")) {//上缴中央各金融机构党委
                ls2 = ls2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456003")) {//上缴上级党委
                ls2 = ls2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456004")) {//上缴省级分支机构党委
                ls4 = ls4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456005")) {//上缴地方党委
                ls3 = ls3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456006")) {//下拨款
                ls5 = ls5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456007")) {//学习资料支出
                ls6 = ls6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456008")) {//管理教育支出
                ls7 = ls7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456009")) {//创先争优支出
                ls8 = ls8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456010")) {//困难补助支出
                ls9 = ls9.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456099")) {//其他支出
                ls10 = ls10.add(new BigDecimal(bvalue));
            }
            //贷方科目
            if (lsubject.equals("10453001")) {//期初实存党费数
                bs1 = bs1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10453002")) {//期末结存党费数
                ls13 = ls13.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455001")) {//党员缴纳党费
                bs2 = bs2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455002")) {//地市级分支机构党委上缴
                bs3 = bs3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455003")) {//省级分支机构党委上缴
                bs4 = bs4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455004")) {//上级党组织拨款
                bs5 = bs5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455005")) {//行政拨款
                bs6 = bs6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455006")) {//利息收入
                bs7 = bs7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455007")) {//其他收入
                bs8 = bs8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456001")) {//上缴中央
                ls1 = ls1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456002")) {//上缴中央各金融机构党委
                ls2 = ls2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456003")) {//上缴上级党委
                ls2 = ls2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456004")) {//上缴省级分支机构党委
                ls4 = ls4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456005")) {//上缴地方党委
                ls3 = ls3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456006")) {//下拨款
                ls5 = ls5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456007")) {//学习资料支出
                ls6 = ls6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456008")) {//管理教育支出
                ls7 = ls7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456009")) {//创先争优支出
                ls8 = ls8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456010")) {//困难补助支出
                ls9 = ls9.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456099")) {//其他支出
                ls10 = ls10.add(new BigDecimal(lvalue));
            }
        } else {//地市级分支机构
            //借方科目
            if (bsubject.equals("10453001")) {//期初实存党费数
                bd1 = bd1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10453002")) {//期末结存党费数
                ld13 = ld13.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455001")) {//党员缴纳党费
                bd2 = bd2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455002")) {//地市级分支机构党委上缴
                bd3 = bd3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455003")) {//省级分支机构党委上缴
                bd4 = bd4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455004")) {//上级党组织拨款
                bd5 = bd5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455005")) {//行政拨款
                bd6 = bd6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455006")) {//利息收入
                bd7 = bd7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10455007")) {//其他收入
                bd8 = bd8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456001")) {//上缴中央
                ld1 = ld1.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456002")) {//上缴中央各金融机构党委
                ld2 = ld2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456003")) {//上缴上级党委
                ld2 = ld2.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456004")) {//上缴省级分支机构党委
                ld4 = ld4.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456005")) {//上缴地方党委
                ld3 = ld3.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456006")) {//下拨款
                ld5 = ld5.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456007")) {//学习资料支出
                ld6 = ld6.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456008")) {//管理教育支出
                ld7 = ld7.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456009")) {//创先争优支出
                ld8 = ld8.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456010")) {//困难补助支出
                ld9 = ld9.add(new BigDecimal(bvalue));
            } else if (bsubject.equals("10456099")) {//其他支出
                ld10 = ld10.add(new BigDecimal(bvalue));
            }
            //贷方科目
            if (lsubject.equals("10453001")) {//期初实存党费数
                bd1 = bd1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10453002")) {//期末结存党费数
                ld13 = ld13.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455001")) {//党员缴纳党费
                bd2 = bd2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455002")) {//地市级分支机构党委上缴
                bd3 = bd3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455003")) {//省级分支机构党委上缴
                bd4 = bd4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455004")) {//上级党组织拨款
                bd5 = bd5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455005")) {//行政拨款
                bd6 = bd6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455006")) {//利息收入
                bd7 = bd7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10455007")) {//其他收入
                bd8 = bd8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456001")) {//上缴中央
                ld1 = ld1.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456002")) {//上缴上级党委
                ld2 = ld2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456003")) {//上缴一级分支机构党委
                ld2 = ld2.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456004")) {//上缴地方党委
                ld4 = ld4.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456005")) {//下拨款
                ld3 = ld3.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456006")) {//学习资料支出
                ld5 = ld5.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456007")) {//管理教育支出
                ld6 = ld6.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456008")) {//创先争优支出
                ld7 = ld7.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456009")) {//困难补助支出
                ld8 = ld8.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456010")) {//管理费用
                ld9 = ld9.add(new BigDecimal(lvalue));
            } else if (lsubject.equals("10456099")) {//其他支出
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

    bsum1 = bz1.add(bs1).add(bd1);//上年实存党费数
    bsum2 = bz2.add(bs2).add(bd2);//本年度党员交纳党费总额
    bsum3 = bz3.add(bs3).add(bd3);//地市级分支机构党委上缴
    bsum4 = bz4.add(bs4).add(bd4);//省级分支机构党委上缴
    bsum5 = bz5.add(bs5).add(bd5);//上级党组织拨款
    bsum6 = bz6.add(bs6).add(bd6);//行政拨款
    bsum7 = bz7.add(bs7).add(bd7);//利息
    bsum8 = bz8.add(bs8).add(bd8);//其他收入
    bsum9 = bz9.add(bs9).add(bd9);//合计

    lsum1 = lz1.add(ls1).add(ld1);//上缴中央
    lsum2 = lz2.add(ls2).add(ld2);//上缴一级分支机构党委
    lsum3 = lz3.add(ls3).add(ld3);//上缴地方党委
    lsum4 = lz4.add(ls4).add(ld4);//上缴省级分支机构党委
    lsum5 = lz5.add(ls5).add(ld5);//下拨款
    lsum6 = lz6.add(ls6).add(ld6);//学习资料支出
    lsum7 = lz7.add(ls7).add(ld7);//管理教育支出
    lsum8 = lz8.add(ls8).add(ld8);//创先争优支出
    lsum9 = lz9.add(ls9).add(ld9);//困难补助支出
    lsum10 = lz10.add(ls10).add(ld10);//其他支出
    lsum11 = lz11.add(ls11).add(ld11);//小计
    lsum12 = lz12.add(ls12).add(ld12);//合计
    lsum13 = lz13.add(ls13).add(ld13);//本年末结存党费数
%>
<table width="95%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000"
       style="border-collapse:collapse">
<tr>
    <td rowspan="2" align="center">&nbsp;</td>
    <td width="80" rowspan="2" align="center">上年实存党费数</td>
    <td colspan="8" align="center">收入</td>
</tr>
<tr>
    <td width="80" align="center">本年度党员缴纳党费总额</td>
    <td width="80" align="center">地市级分支机构党委上缴</td>
    <td width="80" align="center">省级分支机构党委上缴</td>
    <td width="80" align="center">上级党组织拨款</td>
    <td width="80" align="center">行政拨款</td>
    <td width="80" align="center">利息</td>
    <td width="80" align="center">其他收入</td>
    <td width="80" align="center">合计</td>
</tr>
<tr>
    <td align="center">甲</td>
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
    <td align="center">中央各金融机构</td>
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
    <td align="center">省级分支机构</td>
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
    <td align="center">地市级分支机构</td>
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
    <td align="center">总计</td>
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
    <td colspan="12" align="center">支出</td>
    <td width="80" rowspan="3" align="center">本年未结存党费数</td>
</tr>
<tr>
    <td width="80" rowspan="2" align="center">上缴中央</td>
    <td width="80" rowspan="2" align="center">上缴中央各金融机构党委</td>
    <td width="80" rowspan="2" align="center">上缴地方党委</td>
    <td width="80" rowspan="2" align="center">上缴省级分支机构党委</td>
    <td width="80" rowspan="2" align="center">下拨款</td>
    <td colspan="6" align="center">使用</td>
    <td width="30" rowspan="2" align="center">合计</td>
</tr>
<tr>
    <td width="30" align="center">学习资料</td>
    <td width="30" align="center">管理教育</td>
    <td width="30" align="center">创先争优</td>
    <td width="30" align="center">困难补助</td>
    <td width="30" align="center">其他</td>
    <td width="30" align="center">小计</td>
</tr>
<tr>
    <td align="center">甲</td>
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
    <td align="center">中央各金融机构</td>
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
    <td align="center">省级分支机构</td>
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
    <td align="center">地市级分支机构</td>
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
    <td align="center">总计</td>
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
 
