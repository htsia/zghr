<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.lead.pojo.bo.GridResultBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultItemVO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String colString=request.getParameter("Col");
    int col=0;
    if (colString!=null && !"".equals(colString)){
        col=Integer.parseInt(colString);
    }
%>

<html>
<head>
    <script type="text/javascript">
        with (window) onload = onresize = function(){
            var mainHeight = document.body.offsetHeight - 20;
            document.getElementById("main").style.height = "" + mainHeight + "px";
        }
    </script>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>

</head>
<body>
       <br>
       <table align="center" width="100%"  border="0" cellspacing="0" cellpadding="0">
       <tr><td width="40%">
       <table name="data" width="100%">
        <%
            List gridInfo = (List) session.getAttribute("gridInfo");
            if (gridInfo != null) {
                StaticResultVO[] resultvo = new StaticResultVO[gridInfo.size()];
                resultvo[0] = new StaticResultVO();
                StaticResultItemVO[] items = new StaticResultItemVO[1];
                items[0] = new StaticResultItemVO();
                items[0].setAllValue("");   // 设置标题
                items[0].setCount(0);   // 设置数值
                resultvo[0].setItems(items);

                for (int i = 0; i < gridInfo.size(); i++) {
                    GridResultBO row = (GridResultBO) gridInfo.get(i);
                    String outstring = "<tr><td class='td_middle_center' nowrap>" + CommonFuns.filterNull(row.getOrgName()) + "</td>";
                    String value = "";
                    if (col == 0) {
                        value = CommonFuns.filterNull(row.getShowInfo1());
                    } else if (col == 1) {
                        value = CommonFuns.filterNull(row.getShowInfo2());
                    } else if (col == 2) {
                        value = CommonFuns.filterNull(row.getShowInfo3());
                    } else if (col == 3) {
                        value = CommonFuns.filterNull(row.getShowInfo4());
                    } else if (col == 4) {
                        value = CommonFuns.filterNull(row.getShowInfo5());
                    } else if (col == 5) {
                        value = CommonFuns.filterNull(row.getShowInfo6());
                    } else if (col == 6) {
                        value = CommonFuns.filterNull(row.getShowInfo7());
                    } else if (col == 7) {
                        value = CommonFuns.filterNull(row.getShowInfo8());
                    } else if (col == 8) {
                        value = CommonFuns.filterNull(row.getShowInfo9());
                    } else if (col == 9) {
                        value = CommonFuns.filterNull(row.getShowInfo10());
                    } else if (col == 10) {
                        value = CommonFuns.filterNull(row.getShowInfo11());
                    } else if (col == 11) {
                        value = CommonFuns.filterNull(row.getShowInfo12());
                    } else if (col == 12) {
                        value = CommonFuns.filterNull(row.getShowInfo13());
                    } else if (col == 13) {
                        value = CommonFuns.filterNull(row.getShowInfo14());
                    } else if (col == 14) {
                        value = CommonFuns.filterNull(row.getShowInfo15());
                    } else if (col == 15) {
                        value = CommonFuns.filterNull(row.getShowInfo16());
                    } else if (col == 16) {
                        value = CommonFuns.filterNull(row.getShowInfo17());
                    } else if (col == 17) {
                        value = CommonFuns.filterNull(row.getShowInfo18());
                    } else if (col == 18) {
                        value = CommonFuns.filterNull(row.getShowInfo19());
                    } else if (col == 19) {
                        value = CommonFuns.filterNull(row.getShowInfo20());
                    } else if (col == 20) {
                        value = CommonFuns.filterNull(row.getShowInfo21());
                    } else if (col == 21) {
                        value = CommonFuns.filterNull(row.getShowInfo22());
                    } else if (col == 22) {
                        value = CommonFuns.filterNull(row.getShowInfo23());
                    } else if (col == 23) {
                        value = CommonFuns.filterNull(row.getShowInfo24());
                    } else if (col == 24) {
                        value = CommonFuns.filterNull(row.getShowInfo25());
                    } else if (col == 25) {
                        value = CommonFuns.filterNull(row.getShowInfo26());
                    } else if (col == 26) {
                        value = CommonFuns.filterNull(row.getShowInfo27());
                    } else if (col == 27) {
                        value = CommonFuns.filterNull(row.getShowInfo28());
                    } else if (col == 28) {
                        value = CommonFuns.filterNull(row.getShowInfo29());
                    } else if (col == 29) {
                        value = CommonFuns.filterNull(row.getShowInfo30());
                    } else if (col == 30) {
                        value = CommonFuns.filterNull(row.getShowInfo31());
                    } else if (col == 31) {
                        value = CommonFuns.filterNull(row.getShowInfo32());
                    } else if (col == 32) {
                        value = CommonFuns.filterNull(row.getShowInfo33());
                    } else if (col == 33) {
                        value = CommonFuns.filterNull(row.getShowInfo34());
                    } else if (col == 34) {
                        value = CommonFuns.filterNull(row.getShowInfo35());
                    } else if (col == 35) {
                        value = CommonFuns.filterNull(row.getShowInfo36());
                    } else if (col == 36) {
                        value = CommonFuns.filterNull(row.getShowInfo37());
                    } else if (col == 37) {
                        value = CommonFuns.filterNull(row.getShowInfo38());
                    } else if (col == 38) {
                        value = CommonFuns.filterNull(row.getShowInfo39());
                    } else if (col == 39) {
                        value = CommonFuns.filterNull(row.getShowInfo40());
                    }

                    outstring += "<td class='td_middle_center'>" + value + "</td>";
                    outstring += "</tr>";
                    out.println(outstring);

                    if (i!=0){
                        resultvo[i] = new StaticResultVO();
                        items = new StaticResultItemVO[1];
                        items[0] = new StaticResultItemVO();
                        items[0].setAllValue("");   // 设置标题
                        try{
                            items[0].setCount(Integer.parseInt(value));   // 设置数值
                        }
                        catch(Exception e){
                            CommonFuns.DebugLog("--- i="+i+";value=["+value+"] --");
                        }
                        resultvo[i].setItems(items);
                    }
                }
                session.setAttribute("STATIC_RESULT", resultvo);
            }
        %>
        </table>
       </td>

       <td>
           <iframe  width="98%" name="main" src="/pages/qry/StaticResultBar.jsp?height=300&width=<% if (gridInfo==null){out.println("200");} else {out.println(gridInfo.size()*20);}%>"></iframe>
       </td>
       </tr>
      </table>
</body>
<script type="text/javascript">
</script>
</html>
