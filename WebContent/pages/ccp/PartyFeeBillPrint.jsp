<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.ccp.ucc.IPartyUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.cont.util.UnicodeToRtfcode" %>
<%@ page import="com.hr319wg.ccp.util.CcpConstants" %>
<%@ page import="com.hr319wg.cont.util.RTFParser" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="com.hr319wg.util.FileUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.math.BigDecimal" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
</head>
<%
    try {
        IPartyUCC partyucc = (IPartyUCC) SysContext.getBean("ccp_partyUCC");
        List list = partyucc.queryPartyBill(request.getParameter("pid"));
        if (list != null && !list.isEmpty()) {
            Hashtable ht = new Hashtable();
            //先将标签全部替换为空值
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_RECID), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_DATE), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUMMARY), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUMMARY), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_TYPE), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUBJECT), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_FEN), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_JIAO), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_YUAN), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TEN), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDRED), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_THOUSAND), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TENTHOUSAND), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDTHOUSAND), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MILLION), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MULTIMIL), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDMIL), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_FEN), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_JIAO), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_YUAN), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TEN), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDRED), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_THOUSAND), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TENTHOUSAND), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDTHOUSAND), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MILLION), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MULTIMIL), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDMIL), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUMMARY1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_TYPE1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUBJECT1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_FEN1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_JIAO1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_YUAN1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TEN1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDRED1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_THOUSAND1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TENTHOUSAND1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDTHOUSAND1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MILLION1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MULTIMIL1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDMIL1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_FEN1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_JIAO1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_YUAN1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TEN1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDRED1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_THOUSAND1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TENTHOUSAND1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDTHOUSAND1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MILLION1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MULTIMIL1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDMIL1), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUMMARY2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_TYPE2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUBJECT2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_FEN2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_JIAO2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_YUAN2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TEN2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDRED2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_THOUSAND2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TENTHOUSAND2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDTHOUSAND2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MILLION2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MULTIMIL2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDMIL2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_FEN2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_JIAO2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_YUAN2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TEN2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDRED2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_THOUSAND2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TENTHOUSAND2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDTHOUSAND2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MILLION2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MULTIMIL2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDMIL2), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUMMARY3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_TYPE3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUBJECT3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_FEN3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_JIAO3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_YUAN3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TEN3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDRED3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_THOUSAND3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TENTHOUSAND3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDTHOUSAND3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MILLION3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MULTIMIL3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDMIL3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_FEN3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_JIAO3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_YUAN3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TEN3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDRED3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_THOUSAND3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TENTHOUSAND3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDTHOUSAND3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MILLION3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MULTIMIL3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDMIL3), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUMMARY4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_TYPE4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUBJECT4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_FEN4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_JIAO4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_YUAN4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TEN4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDRED4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_THOUSAND4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TENTHOUSAND4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDTHOUSAND4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MILLION4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MULTIMIL4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDMIL4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_FEN4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_JIAO4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_YUAN4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TEN4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDRED4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_THOUSAND4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TENTHOUSAND4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDTHOUSAND4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MILLION4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MULTIMIL4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDMIL4), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_FEN5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_JIAO5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_YUAN5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TEN5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDRED5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_THOUSAND5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TENTHOUSAND5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDTHOUSAND5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MILLION5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MULTIMIL5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDMIL5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_FEN5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_JIAO5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_YUAN5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TEN5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDRED5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_THOUSAND5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TENTHOUSAND5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDTHOUSAND5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MILLION5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MULTIMIL5), UnicodeToRtfcode.outCode(""));
            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDMIL5), UnicodeToRtfcode.outCode(""));
            //end
            BigDecimal total = new BigDecimal(0.0);
            BigDecimal total1 = new BigDecimal(0.0);
            for (int i = 0; i < list.size(); i++) {
                Map htdata = (Map) list.get(i);
                ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_RECID), UnicodeToRtfcode.outCode(CommonFuns.filterNull((String) htdata.get(CcpConstants.D015001))));
                String date = CommonFuns.getDateByFormat(CommonFuns.filterNull((String) htdata.get(CcpConstants.D015005)),"yyyy年MM月dd日");
                ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_DATE), UnicodeToRtfcode.outCode(date));
                if (i == 0) {
                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUMMARY), UnicodeToRtfcode.outCode(CommonFuns.filterNull((String) htdata.get(CcpConstants.D015008))));
                    if (!CommonFuns.filterNull((String) htdata.get(CcpConstants.D015015)).equals("")) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_TYPE), UnicodeToRtfcode.outCode(CodeUtil.interpertCode("1045", CommonFuns.filterNull((String) htdata.get(CcpConstants.D015015)))));
                        if (htdata.get(CcpConstants.D015015).equals("10455002") || htdata.get(CcpConstants.D015015).equals("10455003") || htdata.get(CcpConstants.D015015).equals("10455004"))
                        {
                            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUBJECT), UnicodeToRtfcode.outCode(CodeUtil.interpertCode("PA", CommonFuns.filterNull((String) htdata.get(CcpConstants.D015010)))));
                        }
                    }
                    if (!CommonFuns.filterNull((String) htdata.get(CcpConstants.D015020)).equals("")) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_TYPE1), UnicodeToRtfcode.outCode(CodeUtil.interpertCode("1045", CommonFuns.filterNull((String) htdata.get(CcpConstants.D015020)))));
                        if (htdata.get(CcpConstants.D015020).equals("10455002") || htdata.get(CcpConstants.D015020).equals("10455003") || htdata.get(CcpConstants.D015020).equals("10455004"))
                        {
                            ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_SUBJECT1), UnicodeToRtfcode.outCode(CodeUtil.interpertCode("PA", CommonFuns.filterNull((String) htdata.get(CcpConstants.D015010)))));
                        }
                    }
                    if (!CommonFuns.filterNull((String) htdata.get(CcpConstants.D015025)).equals("")) {
                        BigDecimal sf = new BigDecimal(CommonFuns.filterNull((String) htdata.get(CcpConstants.D015025)));
//                        String val = "￥" + CommonFuns.filterNull((String) htdata.get(CcpConstants.D015025));
                        String val = CommonFuns.filterNull((String) htdata.get(CcpConstants.D015025));
                        boolean flag = false;
                        boolean flag1 = false;
                        if (val.indexOf(".") == -1) {
                            flag = true;
                        } else if (val.substring(val.indexOf(".")).length() == 2) {
                            flag1 = true;
                        }
                        val = val.replaceAll("\\.", "");
                        if (!val.equals("")) {
                            if (flag) val = val + "00";
                            if (flag1) val = val + "0";
                            for (int n = 0; n < val.length(); n++) {
                                if (n == 0) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_FEN), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 1) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_JIAO), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 2) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_YUAN), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 3) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TEN), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 4) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDRED), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 5) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_THOUSAND), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 6) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TENTHOUSAND), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 7) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDTHOUSAND), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 8) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MILLION), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 9) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MULTIMIL), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 10) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDMIL), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                }
                            }
                        }
                        total = total.add(sf);
                    }
                    if (!CommonFuns.filterNull((String) htdata.get(CcpConstants.D015030)).equals("")) {
                        BigDecimal sf = new BigDecimal(CommonFuns.filterNull((String) htdata.get(CcpConstants.D015030)));
//                        String val = "￥" + CommonFuns.filterNull((String) htdata.get(CcpConstants.D015030));
                        String val = CommonFuns.filterNull((String) htdata.get(CcpConstants.D015030));
                        boolean flag = false;
                        boolean flag1 = false;
                        if (val.indexOf(".") == -1) {
                            flag = true;
                        } else if (val.substring(val.indexOf(".")).length() == 2) {
                            flag1 = true;
                        }
                        val = val.replaceAll("\\.", "");
                        if (!val.equals("")) {
                            if (flag) val = val + "00";
                            if (flag1) val = val + "0";
                            for (int n = 0; n < val.length(); n++) {
                                if (n == 0) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_FEN1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 1) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_JIAO1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 2) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_YUAN1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 3) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TEN1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 4) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDRED1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 5) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_THOUSAND1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 6) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TENTHOUSAND1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 7) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDTHOUSAND1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 8) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MILLION1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 9) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MULTIMIL1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                } else if (n == 10) {
                                    ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDMIL1), UnicodeToRtfcode.outCode(val.charAt(val.length() - n - 1)));
                                }
                            }
                        }
                        total1 = total1.add(sf);
                    }
                } else {

                }
            }
            String t = String.valueOf(total);
            t = "￥" + t;
            boolean flag = false;
            boolean flag1 = false;
            if (t.indexOf(".") == -1) {
                flag = true;
            } else if (t.substring(t.indexOf(".")).length() == 2) {
                flag1 = true;
            }
            t = t.replaceAll("\\.", "");
            if (!t.equals("￥")) {
                if (flag) t = t + "00";
                if (flag1) t = t + "0";
                for (int n = 0; n < t.length(); n++) {
                    if (n == 0) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_FEN5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 1) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_JIAO5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 2) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_YUAN5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 3) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TEN5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 4) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDRED5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 5) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_THOUSAND5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 6) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_TENTHOUSAND5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 7) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDTHOUSAND5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 8) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MILLION5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 9) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_MULTIMIL5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    } else if (n == 10) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_BOW_HUNDMIL5), UnicodeToRtfcode.outCode(t.charAt(t.length() - n - 1)));
                    }
                }
            }
            String t1 = String.valueOf(total1);
            t1 = "￥" + t1;
            flag = false;
            flag1 = false;
            if (t1.indexOf(".") == -1) {
                flag = true;
            } else if (t1.substring(t1.indexOf(".")).length() == 2) {
                flag1 = true;
            }
            t1 = t1.replaceAll("\\.", "");
            if (!t1.equals("￥")) {
                if (flag) t1 = t1 + "00";
                if (flag1) t1 = t1 + "0";
                for (int n = 0; n < t.length(); n++) {
                    if (n == 0) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_FEN5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 1) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_JIAO5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 2) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_YUAN5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 3) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TEN5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 4) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDRED5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 5) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_THOUSAND5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 6) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_TENTHOUSAND5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 7) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDTHOUSAND5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 8) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MILLION5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 9) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_MULTIMIL5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    } else if (n == 10) {
                        ht.put(UnicodeToRtfcode.outCode(CcpConstants.RTF_LOAN_HUNDMIL5), UnicodeToRtfcode.outCode(t1.charAt(t.length() - n - 1)));
                    }
                }
            }
            RTFParser parser = new RTFParser(ht);
            String filePath = getServletConfig().getServletContext().getRealPath("/") + File.separator + "file" + File.separator + "party" + File.separator + "template" + File.separator + "bill.rtf";
            File file = new File(filePath);
            if (file.exists()) {
                FileInputStream fis = new FileInputStream(filePath);
                byte[] fileContent = new byte[fis.available()];
                fis.read(fileContent);
                fis.close();
                byte[] newFileContent = parser.returnNewContent(fileContent);
                String path = getServletConfig().getServletContext().getRealPath("/") + File.separator + "file" + File.separator + "party" + File.separator + "temp";
                String relpath = "/file/party/temp/" + FileUtil.createFile(newFileContent, path, "doc");
                response.sendRedirect(relpath);
            } else {
                out.println("没有记录");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<body>
</body>
</html>