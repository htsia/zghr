<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="/pages/include/taglib.jsp" %>

<script language=javascript src="/js/list.js"></script> 
<%
    String reverseQuery=request.getParameter("reverseQuery");// 是否反查
    String reverseQueryURL=request.getParameter("reverseQueryURL");// 反查网址
    String rowQueryURL=request.getParameter("rowQueryURL");// 行反查网址

    String sessionObject=request.getParameter("sessionObject");
    if (sessionObject==null || "".equals(sessionObject)){
        sessionObject="ShowTable";
    }
    //从request得到TableVO
    String rowFuncName = (String) request.getParameter("rowFuncName");
    String func = "";
    
    TableVO table = (TableVO) session.getAttribute(sessionObject);
    int fix = -1;
    if (table != null) {
        if (table.getFixCols() != null && !"".equals(table.getFixCols())) {
            fix = Integer.parseInt(table.getFixCols());
        }

        //得到列表的头部
        CellVO[] header = table.getHeader();
        //得到列表的记录
        RecordVO[] rows = table.getRowData();
        //列表的列数
        int colnum = header==null?0:header.length;
        //列表的记录数
        int rownum = 0;
        if (rows!=null) rownum=rows.length;
        out.println("<div style='width:100%;height:100%;overflow:auto' id=datatable>");
        out.println("<table class='table03' width='98%' align='center' id=list>");

        if (table.getFixCols() == null || "".equals(table.getFixCols())) { // 单标题
            out.println("<tr>");
            //画头部各列
            for (int i = 0; i < colnum; i++) {
                if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[i].getItemProperty()))
                    out.println("<td  id='locked' class='locked_top' nowrap><strong>" + header[i].getItemName() + "</strong></td>");
            }
            out.println("</tr>");
        } else {  // 双标题
            out.println("<tr>");
            for (int k = 0; k < fix; k++) {
                if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[k].getItemProperty()))
                    out.println("<td  id='locked' class='locked_top' style='z-index:3' nowrap rowspan=2><strong>" + header[k].getItemName() + "</strong></td>");
            }

            String[] fns = CommonFuns.filterNull(table.getFatherColNames()).split(",");
            String[] fspan = CommonFuns.filterNull(table.getFatherColSpans()).split(",");
            for (int k = 0; k < fns.length; k++) {
                out.println("<td  id='locked' class='locked_top' nowrap align='center' colspan=" + fspan[k] + "><strong>" + fns[k] + "</strong></td>");
            }
            out.println("</tr>");

            out.println("<tr>");
            for (int k = fix; k < colnum; k++) {
                if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[k].getItemProperty()))
                    out.println("<td  id='locked' class='locked_top' nowrap><strong>" + header[k].getItemName() + "</strong></td>");
            }
            out.println("</tr>");
        }

        // 画数据
        for (int i = 0; i < rownum; i++) {
            RecordVO row = rows[i]; //得到某一行
            out.println("<tr>");
            CellVO[] cell = row.getCell();
            if (rowFuncName != null && !"".equals(rowFuncName)) {
                func = rowFuncName + "('" + cell[0].getValue() + "')";
            } else {
                func = "";
            }
            for (int j = 0; j < colnum; j++) {
                if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[j].getItemProperty())) {
                    if (j < fix) {       // 固定列
                        if ("true".equals(reverseQuery) && rowQueryURL!=null && !"".equals(rowQueryURL)){
                            out.println("<td  style='position:relative'  class='td_middle' nowrap onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this) onclick=\"javascript:" + func + "\" ><a target='_blank' href='javascript:alert(1);'>" + cell[j].getValue() + "</A></td>");
                        }
                        else{
                            out.println("<td  style='position:relative'  class='td_middle' nowrap onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this) onclick=\"javascript:" + func + "\" >" + cell[j].getValue() + "</td>");
                        }
                    } else {
                        if ("true".equals(reverseQuery) && cell[j].getItemId().indexOf("*")<0){
                           out.println("<td  class='td_middle' nowrap onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this) onclick=\"javascript:" + func + "\" ><a target='_blank' href='"+reverseQueryURL+"?pk="+cell[0].getValue()+"&cellDes="+cell[j].getItemDesc()+"&cellID="+cell[j].getItemId()+"&addInfo="+CommonFuns.filterNull(table.getAdditionInfo())+"'>" + CommonFuns.filterNull(cell[j].getValue()) + "</a></td>");
                        }
                        else{
                           out.println("<td  class='td_middle' nowrap onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this) onclick=\"javascript:" + func + "\" >" + CommonFuns.filterNull(cell[j].getValue()) + "</td>");
                        }
                    }
                }
            }
            out.println("</tr>");
        }
        out.println("</table>");
        out.println("</div>");
    }
%>
<script language=javascript>
    <%
       out.print("window.setInterval('setFix()', 700);");
        // 列锁定
        if (fix>0){
           out.print("tableFixCol="+fix+";");
           out.print("window.setInterval('setFixCol()', 700);");
        }
    %>
</script>
