<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageCostFieldBO" %>
<%@ page import="com.hr319wg.wage.ucc.IWageItemSetUCC" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ include file="/pages/include/taglib.jsp" %>

<html>
<head>
    <title></title>
</head>

<script type="text/javascript" src="../../js/tree.js"></script>
<script type="text/javascript" src="../../js/Appclient.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<body topmarge="0" leftmarge="0">
    <input type="button" value="取消选择" class="button01" onclick="window.returnValue = ',';window.close();">
    <div id="dt"></div>
    <script type="text/javascript">
        var img = getTreeImage();
        //初始化树
        var tree = new newtree(img, 16, dt);
        root = tree.root;
        <%
        //String str = "T" + citem.getItemId() + " = tree.add(root,'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','','fold','','');";
        //取所有code
        List list = SysCacheTool.queryCodeItemBySetId("0280");
        if(list != null){
            for(int i=0;i<list.size();i++){
                CodeItemBO citem = (CodeItemBO) list.get(i);
                String str = "";
                if("-1".equals(citem.getItemSuper()))
                    str = "T" + citem.getItemId() + " = tree.add(root,'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','CODE','fold','','');";
                else
                    str = "T" + citem.getItemId() + " = tree.add(T" + citem.getItemSuper() + ",'last','" + citem.getItemName() + "', 'T" + citem.getItemId() + "','','CODE','fold','','');";

                out.println(str);
            }
        }
        try{
            IWageItemSetUCC wageitem = (IWageItemSetUCC)SysContext.getBean("wage_wageItemSetUcc");
            WageCostFieldBO[] bos = wageitem.queryItem(null,WageCostFieldBO.TYPE_POST,true);
            if(bos != null){
                for(int i=0;i<bos.length;i++){
                    InfoItemBO ib=SysCacheTool.findInfoItem("",bos[i].getCostField());
                    if (!"1".equals(ib.getItemStatus())){
                        continue;
                    }
                    String str = "I" + bos[i].getCostFieldId() + " = tree.add(T" + bos[i].getCostType() + ",'last','" + bos[i].getFieldNameEx() + "', '" + bos[i].getCostField() + "','','ITEM','file','','');";
                    out.println(str);
                }
            }
        }catch(Exception e){

        }
        %>
        tree.expandAll(false);
        tree.onclick = function(srcNode) {
            if(srcNode.alt == 'ITEM'){
                window.returnValue = srcNode.getKey() + "," + srcNode.label.innerText;
                window.close();
            }
        }
    </script>
</body>
</html>