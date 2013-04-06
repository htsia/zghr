<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    boolean hasOperSign = false;

    String isSelf = "";
    try {
        isSelf = CommonFuns.filterNull(request.getParameter("isSelf"));
    } catch (Exception e) {
        isSelf = "";
    }
    boolean showExcel = false;
    try {
        showExcel = Boolean.valueOf(request.getParameter("showExcel")).booleanValue();
    } catch (Exception e) {
    }
    String operSignType = "checkBox";
    try {
        hasOperSign = Boolean.valueOf(request.getParameter("hasOperSign")).booleanValue();
    } catch (Exception e) {
    }
    if (hasOperSign) {
        operSignType = request.getParameter("operSignType");
    }
    boolean hasEdit = false;
    try {
        hasEdit = Boolean.valueOf(request.getParameter("hasEdit")).booleanValue();
    } catch (Exception e) {
    }
    String editName = "";
    if (hasOperSign) {
        editName = request.getParameter("editName");
    }
    boolean isCheckRight = true;
    try {
        isCheckRight = Boolean.valueOf(request.getParameter("isCheckRight")).booleanValue();
    } catch (Exception e) {
    }
    //是否有功能按钮
    boolean hasFuncBnt = true;
    try {
        if (request.getParameter("hasFuncBnt") != null && !"".equals(request.getParameter("hasFuncBnt"))) {
            hasFuncBnt = Boolean.valueOf(request.getParameter("hasFuncBnt")).booleanValue();
        }
    } catch (Exception e) {
    }
    boolean isScroll = true;
    try {
        isScroll = Boolean.valueOf(request.getParameter("isScroll")).booleanValue();
    } catch (Exception e) {
    }
    String tableId = request.getParameter("tableId");
    if (tableId == null || "".equals(tableId.trim())) {
        tableId = Constants.OBJECT_DETAIL;
    }

    TableVO table = (TableVO) session.getAttribute(tableId);
    String flag = request.getParameter("flag");
    String fk = request.getParameter("fk");
    String setId = request.getParameter("setId");

    if (table != null) {
        int tableright = table.getPermission();
        if (isCheckRight && tableright == TableVO.PERMISSON_REFUSE) {
            //拒绝的权限
            out.println("<font color=#0033CC>对不起，您没有权限查看该指标集！</font>");
            return;
        }

        String rsType = table.getSet_rsType();

        if (InfoSetBO.RS_TYPE_MANY.equals(rsType)) {
            //1:n
            CellVO[] header = table.getHeader();
            RecordVO[] rows = table.getRowData();
            int colnum = header.length;
            int rownum = 0;
            if (rows != null) {
                rownum = rows.length;
            }
            out.println("<br>");
            if (hasFuncBnt || showExcel) {
                //draw operation button
                out.println("<table width=95% border=0 cellspacing=2 cellpadding=0 align=center>");
                out.println("<tr>");
                out.println("<td height=30 align=right valign='middle'>");
                String disable = "";
                if (isCheckRight && tableright != TableVO.PERMISSON_WRITE ) {
                    disable = "disabled";
                }
                if("B200".equals(setId)){
                	disable="";
                }

                if(!showExcel){
                    out.println("<input name=add type=button class=button01 value=新增 " + disable + " onclick=forAdd(document.forms(0),'1')>");
                    out.println("<input name=mod type=button class=button01 value=修改 " + disable + " onclick=forEdit(document.forms(0),'6')>");
                    out.println("<input name=del type=button class=button01 value=删除 " + disable + "  onclick=forDel(document.forms(0),'5')>");
                   	out.println("<input name=del type=button class=button01 value=置为当前 " + disable + "  onclick=forCurrent(document.forms(0))>");                    	
                }
                out.println("<input name=del type=button class=button01 value=导出Excel  onclick=forExport()>");
                out.println("</td>");
                out.println("<td height=30>");
                out.println("</td>");
                out.println("</tr>");
                //end 画操作按钮
            }
            out.println("</table>");
%>

    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="<%=hasOperSign%>"/>
        <jsp:param name="operSignType" value="<%=operSignType%>"/>
        <jsp:param name="isCheckRight" value="<%=isCheckRight%>"/>
        <jsp:param name="target" value="<%=tableId%>"/>
        <jsp:param name="isPage" value="false"/>
        <jsp:param name="isScroll" value="<%=isScroll%>"/>
        <jsp:param name="isSelf" value="<%=isSelf%>"/>
        <jsp:param name="isRow" value="false"/>
    </jsp:include>
<%
        }
        out.println("<input type=hidden name=flag value='" + CommonFuns.filterNull(flag) + "'>");
        out.println("<input type=hidden name=fk value='" + CommonFuns.filterNull(fk) + "'>");
        out.println("<input type=hidden name=setId value='" + CommonFuns.filterNull(setId) + "'>");
        out.println("<input type=hidden name=curID value=''>");
        out.println("<input type=hidden name=pk value=''>");
    }
%>
<script type="text/javascript">
    with (window) onload = onresize = function(){
        var mainHeight = document.body.offsetHeight - 50;
        if (document.getElementById("datatable")!=null && document.getElementById("datatable")!=undefined){
          document.getElementById("datatable").style.height = "" + mainHeight + "px";
        }
    }

</script>
