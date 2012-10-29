<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script type="text/javascript">
        function showSalary(name){
            var obj=document.all(name);
            if(obj.style.display=="none"){
                obj.style.display="";
            }else{
                obj.style.display="none";
            }

        }
    </script>
<head>

<body>
<c:view>
<x:saveState value="#{wage_persMgrBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_persMgrBB.pageInit}"/>
<table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
<tr>
    <td  class="td_form02" >
        Ñ¡ÔñÄê¶È
        <h:selectOneMenu value="#{wage_persMgrBB.year}" onchange="submit()"
                         valueChangeListener="#{wage_persMgrBB.viewSalaryByYear}">
            <c:selectItem itemValue="2000" itemLabel="2000"/>
            <c:selectItem itemValue="2001" itemLabel="2001"/>
            <c:selectItem itemValue="2002" itemLabel="2002"/>
            <c:selectItem itemValue="2003" itemLabel="2003"/>
            <c:selectItem itemValue="2004" itemLabel="2004"/>
            <c:selectItem itemValue="2005" itemLabel="2005"/>
            <c:selectItem itemValue="2006" itemLabel="2006"/>
            <c:selectItem itemValue="2007" itemLabel="2007"/>
            <c:selectItem itemValue="2008" itemLabel="2008"/>
            <c:selectItem itemValue="2009" itemLabel="2009"/>

            <c:selectItem itemValue="2010" itemLabel="2010"/>
            <c:selectItem itemValue="2011" itemLabel="2011"/>
            <c:selectItem itemValue="2012" itemLabel="2012"/>
            <c:selectItem itemValue="2013" itemLabel="2013"/>
            <c:selectItem itemValue="2014" itemLabel="2014"/>
            <c:selectItem itemValue="2015" itemLabel="2015"/>
            <c:selectItem itemValue="2016" itemLabel="2016"/>
            <c:selectItem itemValue="2017" itemLabel="2017"/>
            <c:selectItem itemValue="2018" itemLabel="2018"/>
            <c:selectItem itemValue="2019" itemLabel="2019"/>

            <c:selectItem itemValue="2020" itemLabel="2020"/>
            <c:selectItem itemValue="2021" itemLabel="2021"/>
            <c:selectItem itemValue="2022" itemLabel="2022"/>
            <c:selectItem itemValue="2023" itemLabel="2023"/>
            <c:selectItem itemValue="2024" itemLabel="2024"/>
            <c:selectItem itemValue="2025" itemLabel="2025"/>
            <c:selectItem itemValue="2026" itemLabel="2026"/>
        </h:selectOneMenu>
    </td>
</tr>
<%
    TableVO table = (TableVO) session.getAttribute("DetailInfo");
    if (table != null) {
        RecordVO [] rs = table.getRowData();
        if (rs != null && rs.length > 0) {
            int len = rs.length;
            for (int i = 0; i < len; i++) {
                Hashtable hash = rs[i].cellArray2Hash();
                if (hash != null && hash.size() > 0) {
                    String showValue = ((CellVO) hash.get("ALL_FIELD")).getValue();
                    if(showValue==null||"".equals(showValue)) continue;
                    String[] items = showValue.split(",");

                    CellVO A815701Cell = (CellVO) hash.get("A815701");
                    CellVO A815705Cell = (CellVO) hash.get("A815705");
                    out.println("<tr>");
                    out.println("<td class=\"td_form02\" valign='middle'><img src='/images/tips.gif' onclick=\"showSalary('r"+i+"')\">&nbsp;&nbsp;&nbsp;&nbsp;" + A815701Cell.getItemName() +":"+ A815701Cell.getValue() +  "</td>");
                    out.println("</tr>");
                    out.println("<tr>");
                    out.println("<td  class=\"td_form02\" style=\"display:none\" id=\"r"+i+"\">");
                    out.println("<table  width=\"95%\" align=\"center\" cellpadding=\"2\" cellspacing=\"0\" class=\"table03\">");
                    out.println("<tr>");
                    out.println("<td class=\"td_form01\">" + A815705Cell.getItemName() + "</td>");
                    out.println("<td class=\"td_form01\">" + CodeUtil.interpertCode("WAGE",A815705Cell.getValue()) + " </td>");
                    out.println("</tr>");
                    for (int j = 0; j < items.length; j++) {
                        CellVO cell = (CellVO) hash.get(items[j]);
                        if (cell!=null){
                            out.println("<tr>");
                            out.println("<td class=\"td_form01\">" + cell.getItemName() + "</td>");
                            out.println("<td class=\"td_form02\">" + cell.getValue() + " </td>");
                            out.println("</tr>");
                        }
                    }
                    out.println("</table>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
        }
    }
%>
</table>
</h:form>
</c:view>
</body>
</html>