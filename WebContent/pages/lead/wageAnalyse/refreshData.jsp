<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultItemVO" %>
<%@ page import="java.util.Hashtable" %>
<link href="/css/styleDesktop.css" rel="stylesheet" type="text/css"/>

<%
    String superID = request.getParameter("superId");
    String[] month = (String[]) session.getAttribute("month");
    Hashtable htdetail = (Hashtable) session.getAttribute("htdetail");
    // 显示合计行图像
    StaticResultVO[] resultvo = new StaticResultVO[month.length];
    for (int j = 0; j < month.length; j++) {
        String index = superID + "|" + month[j];
        resultvo[j] = new StaticResultVO();
        StaticResultItemVO[] items = new StaticResultItemVO[1];
        items[0] = new StaticResultItemVO();
        items[0].setAllValue(month[j] + "年");    // 设置标题

        resultvo[j].setItems(items);

        if (htdetail.get(index) != null) {

            items[0].setSum(htdetail.get(index).toString());       // 设置数值 
        } else {
            items[0].setSum("0");       // 设置数值
        }
    }
    session.setAttribute("STATIC_RESULT", resultvo);
%>