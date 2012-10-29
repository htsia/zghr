<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.hr319wg.sys.service.ActivePageService" %>

<html>
<head>
    <title></title>
    <link href="/css/styleDesktop.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%
    User user = (User) session.getAttribute(Constants.USER_INFO);
%>

<br>
<table width="95%" align="center">
    <tr><td align="center"><span style="font-size: 14pt; font-family: 楷体_GB2312"><strong>年薪发放情况</strong></span></td></tr>
</table>
<br>

<table class="table02" width="95%" align="center">
    <tr>
        <td rowspan=2 align="center" class=td_middle><strong>年度</strong></td>
        <td class=td_middle align="center" colspan=4><strong>核定标准</strong></td>
        <td class=td_middle align="center" colspan=5><strong>发放</strong></td>
        <td class=td_middle align="center" colspan=4><strong>余额</strong></td>
        <td rowspan=2 align="center" class=td_middle><strong>说明</strong></td>
     </tr>

    <tr>
        <td align="center" class=td_middle><strong>小计</strong></td>
        <td align="center" class=td_middle><strong>应发</strong></td>
        <td align="center" class=td_middle><strong>中长期激励</strong></td>
        <td align="center" class=td_middle><strong>年奖</strong></td>

        <td align="center" class=td_middle><strong>年度</strong></td>
        <td align="center" class=td_middle><strong>预发</strong></td>
        <td align="center" class=td_middle><strong>补发</strong></td>
        <td align="center" class=td_middle><strong>中长期激励</strong></td>
        <td align="center" class=td_middle><strong>年奖</strong></td>

        <td class=td_middle align="center" ><strong>小计</strong></td>
        <td class=td_middle align="center" ><strong>应发</strong></td>
        <td class=td_middle align="center" ><strong>中长期激励</strong></td>
        <td align="center" class=td_middle><strong>年奖</strong></td>
    </tr>

    <tr>
       <%
           ActivePageService api=(ActivePageService)SysContext.getBean("sys_activePageService");
           String sql = "select A200200,A200201,A200202,A200203,A200208,A200204,A200206,A200207,A200209,A200205 from A200 where id='" + user.getUserId() + "' order by A200200";
           CellVO[] head = new CellVO[10];
           head[0] = new CellVO();
           head[0].setItemId("A200200");

           head[1] = new CellVO();
           head[1].setItemId("A200201");

           head[2] = new CellVO();
           head[2].setItemId("A200202");

           head[3] = new CellVO();
           head[3].setItemId("A200203");

           head[4] = new CellVO();
           head[4].setItemId("A200208");

           head[5] = new CellVO();
           head[5].setItemId("A200204");

           head[6] = new CellVO();
           head[6].setItemId("A200206");

           head[7] = new CellVO();
           head[7].setItemId("A200207");

           head[8] = new CellVO();
           head[8].setItemId("A200209");

           head[9] = new CellVO();
           head[9].setItemId("A200205");


           Vector vt =api.getDataListBySql(head,sql);
           int A200201=0;
           int A200202=0;
           int A200203=0;
           int A203202=0;
           int A203203=0;
           int A203204=0;
           int A203205=0;
           int A200204=0;
           int A200206=0;
           int A200207=0;
           int A200208=0;
           int A200209=0;

           if (vt!=null && vt.size()>0){
               for(int i=0;i<vt.size();i++){
                   CellVO[]row=(CellVO[])vt.get(i);
                   sql = "select A203201,A203202,A203203,A203204,A203205 from A203 where id='" + user.getUserId() + "' and A203200='"+row[0].getValue()+"'";
                   CellVO[] detail = new CellVO[5];
                   detail[0] = new CellVO();
                   detail[0].setItemId("A203201");

                   detail[1] = new CellVO();
                   detail[1].setItemId("A203202");

                   detail[2] = new CellVO();
                   detail[2].setItemId("A203203");

                   detail[3] = new CellVO();
                   detail[3].setItemId("A203204");

                   detail[4] = new CellVO();
                   detail[4].setItemId("A203205");

                   Vector vtdetail =api.getDataListBySql(detail,sql);
                   String rowspan="1";
                   if (vtdetail.size()>1) rowspan=String.valueOf(vtdetail.size());
                   out.println("<tr>");
                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[0].getValue()+"</td>");
                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[1].getValue()+"</td>");
                   if (row[1].getValue()!=null && !"".equals(row[1].getValue()))  A200201+=Integer.parseInt(row[1].getValue());

                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[2].getValue()+"</td>");
                   if (row[2].getValue()!=null && !"".equals(row[2].getValue())) A200202+=Integer.parseInt(row[2].getValue());

                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[3].getValue()+"</td>");
                   if (row[3].getValue()!=null && !"".equals(row[3].getValue())) A200203+=Integer.parseInt(row[3].getValue());

                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[4].getValue()+"</td>");
                   if (row[4].getValue()!=null && !"".equals(row[4].getValue())) A200208+=Integer.parseInt(row[4].getValue());

                   if (vtdetail==null || vtdetail.size()==0){
                       out.println("<td align=\"center\" class=td_middle></td>");
                       out.println("<td align=\"center\" class=td_middle></td>");
                       out.println("<td align=\"center\" class=td_middle></td>");
                       out.println("<td align=\"center\" class=td_middle></td>");
                       out.println("<td align=\"center\" class=td_middle></td>");
                   }
                   else{
                       CellVO[]vtrow=(CellVO[])vtdetail.get(0);
                       out.println("<td align=\"center\" class=td_middle>"+vtrow[0].getValue()+"</td>");

                       out.println("<td align=\"center\" class=td_middle>"+vtrow[1].getValue()+"</td>");
                       if (vtrow[1].getValue()!=null && !"".equals(vtrow[1].getValue()))  A203202+=Integer.parseInt(vtrow[1].getValue());

                       out.println("<td align=\"center\" class=td_middle>"+vtrow[2].getValue()+"</td>");
                       if (vtrow[2].getValue()!=null && !"".equals(vtrow[2].getValue()))  A203203+=Integer.parseInt(vtrow[2].getValue());

                       out.println("<td align=\"center\" class=td_middle>"+vtrow[3].getValue()+"</td>");
                       if (vtrow[3].getValue()!=null && !"".equals(vtrow[3].getValue()))  A203204+=Integer.parseInt(vtrow[3].getValue());

                       out.println("<td align=\"center\" class=td_middle>"+vtrow[4].getValue()+"</td>");
                       if (vtrow[4].getValue()!=null && !"".equals(vtrow[4].getValue()))  A203205+=Integer.parseInt(vtrow[4].getValue());

                    }


                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[5].getValue()+"</td>");
                   if (row[5].getValue()!=null && !"".equals(row[5].getValue())) A200204+=Integer.parseInt(row[5].getValue());

                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[6].getValue()+"</td>");
                   if (row[6].getValue()!=null && !"".equals(row[6].getValue())) A200206+=Integer.parseInt(row[6].getValue());

                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[7].getValue()+"</td>");
                   if (row[7].getValue()!=null && !"".equals(row[7].getValue())) A200207+=Integer.parseInt(row[7].getValue());

                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[8].getValue()+"</td>");
                   if (row[8].getValue()!=null && !"".equals(row[8].getValue())) A200209+=Integer.parseInt(row[8].getValue());

                   out.println("<td align=\"center\" rowspan="+rowspan+" class=td_middle>"+row[9].getValue()+"</td>");
                   out.println("</tr>");

                   for(int j=1;j<vtdetail.size();j++){
                       CellVO[]vtrow=(CellVO[])vtdetail.get(j);
                       out.println("<tr>");
                       out.println("<td align=\"center\" class=td_middle>"+vtrow[0].getValue()+"</td>");
                       out.println("<td align=\"center\" class=td_middle>"+vtrow[1].getValue()+"</td>");
                       if (vtrow[1].getValue()!=null && !"".equals(vtrow[1].getValue()))  A203202+=Integer.parseInt(vtrow[1].getValue());

                       out.println("<td align=\"center\" class=td_middle>"+vtrow[2].getValue()+"</td>");
                       if (vtrow[2].getValue()!=null && !"".equals(vtrow[2].getValue()))  A203203+=Integer.parseInt(vtrow[2].getValue());

                       out.println("<td align=\"center\" class=td_middle>"+vtrow[3].getValue()+"</td>");
                       if (vtrow[3].getValue()!=null && !"".equals(vtrow[3].getValue()))  A203204+=Integer.parseInt(vtrow[3].getValue());

                       out.println("<td align=\"center\" class=td_middle>"+vtrow[4].getValue()+"</td>");
                       if (vtrow[4].getValue()!=null && !"".equals(vtrow[4].getValue()))  A203204+=Integer.parseInt(vtrow[4].getValue());

                       out.println("</tr>");
                   }
               }
           }

       %>

    <tr>
        <td align="center" class=td_middle><strong>合计</strong></td>
        <td align="center" class=td_middle><%=A200201%></td>
        <td align="center" class=td_middle><%=A200202%></td>
        <td align="center" class=td_middle><%=A200203%></td>
        <td align="center" class=td_middle><%=A200208%></td>
        <td align="center" class=td_middle>-</td>
        <td align="center" class=td_middle><%=A203202%></td>
        <td align="center" class=td_middle><%=A203203%></td>
        <td align="center" class=td_middle><%=A203204%></td>
        <td align="center" class=td_middle><%=A203205%></td>
        <td align="center" class=td_middle><%=A200204%></td>
        <td align="center" class=td_middle><%=A200206%></td>
        <td align="center" class=td_middle><%=A200207%></td>
        <td align="center" class=td_middle><%=A200209%></td>
        <td align="center" class=td_middle></td>
    </tr>

</table>
</body>
</html>