<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="/pages/include/taglib.jsp" %>

    <script language="javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/tree_check.js"></script>
    <div id="dt"></div>

<%!
        private void drawCodeTree(JspWriter out, String spId,String onlyUse) {
        try {
            ArrayList list = SysCacheTool.querySubObject(SysCache.OBJ_CODEITEM, Constants.INFO_SET_TYPE_CODEID, spId);
            if (list != null && list.size() != 0) {
                for (int i = 0; i < list.size(); i++) {
                    CodeItemBO item = (CodeItemBO) list.get(i);
                    if ("true".equals(onlyUse) && !"1".equals(item.getItemStatus())){
                        continue;
                    }
                    StringBuffer sf = new StringBuffer();
                    sf.append("var t")
                            .append(item.getItemId()).append("=tree.add(");
                    String superId = item.getItemSuper();
                    if (superId.equals("-1")) {
                        sf.append("root,'last','")
                                .append(item.getItemName())
                                .append("','n")
                                .append(i)
                                .append("','")
                                .append(item.getItemId())
                                .append("','','book_open');");
                    } else {
                        sf.append("t").append(superId);
                        sf.append(",'last','")
                                .append(item.getItemName())
                                .append("','n")
                                .append(i)
                                .append("','")
                                .append(item.getItemId())
                                .append("','','book_open');");
                    }
                    out.println(sf.toString());
                    drawCodeTree(out,item.getItemId(),onlyUse);
                }
            }
        }
        catch (Exception e) {

        }
    }
%>
<script language="JavaScript">
    //定义树的图片对象
    var flag = false;
    var images = getTreeImage();

    //初始化树
    var tree = new newtree(images, 16, dt)
    var root = tree.root
    <%
        String onlyUse=CommonFuns.filterNull(request.getParameter("onlyUse"));
        drawCodeTree(out, Constants.INFO_SET_TYPE_CODEID,onlyUse);
    %>

    tree.onclick = treeNodeclick;

    function treeNodeclick(srcNode) {
        var key2 = srcNode.key2;
        parent.refreshList(key2);
    }
</script>