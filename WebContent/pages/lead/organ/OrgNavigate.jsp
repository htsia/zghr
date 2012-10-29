<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = request.getParameter("superId");
    OrgBO org = SysCacheTool.findOrgById(superId);
    ArrayList list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", superId);
%>
<html>
<head><title>机构图</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/structure.js"></script>
    <SCRIPT language=javascript>
        //oid,机构编号，机构类型，机构层次，是否打开，
        //function Node(oid,code,name,level,open)
        var actionbar = null;
        var aNode;
        <%
        String id = "";
        String tree = "";
        String name = "";
         StringBuffer node=new StringBuffer();
        if(org != null){

           id=org.getOrgId();
           tree = org.getTreeId();
           name = org.getName();
           node.append("var node").append(id).append("= new Node(")
           .append(id).append(",")
           .append(tree).append(",'")
           .append(name).append("',")
           .append(1).append(",").append(false).append(");");
           if(list != null && list.size() >0){
               out.println(node.toString());
                out.println("node"+id+".open=true;");
            out.println("aNode=node"+id+";");
            StringBuffer subnode = new StringBuffer();
               String sid = "";
        String stree = "";
        String sname = "";
            for(int i=0;i<list.size();i++){
            OrgBO bo = (OrgBO)list.get(i);
            if(bo != null){
              if(Constants.YES.equals(bo.getOrgCancel())){
              continue;
            }
            }

            if(bo != null){               
               sid=bo.getOrgId();
               stree = bo.getTreeId();
               sname = bo.getName();
               subnode.append("var node").append(sid).append("= new Node(")
              .append(sid).append(",")
              .append(stree).append(",'")
              .append(sname).append("',")
              .append(2).append(",").append(false).append(");");
              out.println(subnode.toString());
              out.println("node"+id+".addSubnode(node"+sid+");");
          }
         }
            }
        }
        %>


    </SCRIPT>
    <SCRIPT language=javascript>
        var viewEmployeeAltLabel = "";
        var viewUnitInfoAltLabel = "";

        //set the global string var value
        var contextPath = "../../../";
        var codeKeyValue = "编号";
        var nameKeyValue = "名称";
        var chartVersion = "0";

        var isCompact = true;
        var mode = 'chart';

        var rootNode = aNode;

        function drawChart() {
            //debugger;
            if (rootNode != null)
                chartTd.appendChild(rootNode.createAllNode());

            adaptPosition();
            adaptLevelViewNode();

            if (rootNode != null) {
                if (mode != "chart") {
                    var leftPos = calculateSumOffset(rootNode.viewNode, 'offsetLeft');
                    leftPos += rootNode.viewNode.offsetWidth;
                    leftPos += 200;
                }
            }
        }
    </SCRIPT>
</head>

<body>
<table width="95%" border="0" cellspacing="0" cellpadding="0" id="control" valign="top">
    <tr>
        <td align="right">
            <input type="button" class="button01" onclick="print1()" value=" 打印 ">
        </td>
    </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align=center>
    <tr><td>&nbsp;</td></tr>
    <%
        if (org != null) {
    %>
    <tr><td align=center style="padding:3 ;">
		<span>
				<table class='orgunitchartitemcell2' border=0><tr><td><%=name%></td></tr>
                </table>
		</span>
    </td></tr>
    <%}%>
    <tr>
        <td id=chartTd vAlign=top align=center>
            <SCRIPT>
                drawChart();
            </SCRIPT>
        </td>
    </tr>
</table>
</body>
<%
    if (org != null && list != null && list.size() > 0) {
%>
<script>

    obj = document.all.tags("DIV")[0]
    obj.style.width = "200px";
    table = obj.parentElement.parentElement.parentElement
    table.deleteRow(0);
    table.deleteRow(0);
    <%
    if(list.size()==1){
    %>
    obj1 = document.all.tags("IMG")[0];
    obj1.src = "/images/orgverticallong.gif";
    <%}%>
</script>
<%}%>
<script type="text/javascript">
    function print1() {
        document.all('control').style.display = "none";
        window.print();
        document.all('control').style.display = "";
    }
</script>
</html>