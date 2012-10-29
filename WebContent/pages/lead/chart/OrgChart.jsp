<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = request.getParameter("superId");
    if (superId == null || "".equals(superId)) {  // 没有时取第一个
        User user = (User) session.getAttribute(Constants.USER_INFO);
        superId = user.getOrgId();
    }
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
           out.println(node.toString());

           if(list != null && list.size() >0){
                out.println("node"+id+".open=true;");
                out.println("aNode=node"+id+";");
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
                       StringBuffer subnode = new StringBuffer();
                       subnode.append("var node").append(sid).append("= new Node(")
                      .append(sid).append(",")
                      .append(stree).append(",'")
                      .append(sname).append("',")
                      .append(2).append(",").append(true).append(",3);");
                       out.println(subnode.toString());
                       out.println("node"+id+".addSubnode(node"+sid+");");
                    }

                    ArrayList child = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", sid);
                    if (child!=null && child.size()>0) {
                        out.println("node"+sid+".open=true;");
                        for(int j=0;j<child.size();j++){
                             OrgBO childbo = (OrgBO)child.get(j);
                             if(childbo != null){
                                 if(Constants.YES.equals(childbo.getOrgCancel())){
                                     continue;
                                 }
                             }
                            if(childbo != null){
                               String csid=childbo.getOrgId();
                               out.println("var node"+childbo.getOrgId()+"= new Node("+childbo.getOrgId()+","+childbo.getTreeId()+",'"+childbo.getName()+"',3,true,3);");
                               out.println("node"+sid+".addSubnode(node"+csid+");");
                                ArrayList childchild = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", csid);
                                if (childchild!=null && childchild.size()>0) {
                                    out.println("node"+csid+".open=true;");
                                    for(int k=0;childchild!=null && k<childchild.size();k++){
                                         OrgBO childchildbo = (OrgBO)childchild.get(k);
                                         if(childchildbo != null){
                                             if(Constants.YES.equals(childchildbo.getOrgCancel())){
                                                 continue;
                                             }
                                         }
                                           String ccsid=childchildbo.getOrgId();
                                           out.println("var node"+childchildbo.getOrgId()+"= new Node("+childchildbo.getOrgId()+","+childchildbo.getTreeId()+",'"+childchildbo.getName()+"',4,true,3);");
                                           out.println("node"+csid+".addSubnode(node"+ccsid+");");

                                               ArrayList child4 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", ccsid);
                                               for(int l=0;l<child4.size();l++){
                                                   OrgBO child4bo = (OrgBO)child4.get(l);

                                                 if(child4bo != null){
                                                     if(Constants.YES.equals(child4bo.getOrgCancel())){
                                                         continue;
                                                     }
                                                 }
                                                   String c4id=child4bo.getOrgId();
                                                   out.println("var node"+c4id+"= new Node("+child4bo.getOrgId()+","+child4bo.getTreeId()+",'"+child4bo.getName()+"',5,true,0);");
                                                   out.println("node"+ccsid+".addSubnode(node"+c4id+");");
                                                }
                                     
                                     }
                                 }
                            }

                         }
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" align=center>
    <tr><td>&nbsp;</td></tr>

    <tr>
        <td id=chartTd vAlign=top align=center>
            <SCRIPT>
                drawChart();
                obj = document.all.tags("DIV")[0];
                if (obj!=null && obj!=undefined){
                    var table = obj.parentElement.parentElement.parentElement;
                    var tr=obj.parentElement.parentElement;
                    tr.cells[0].colSpan-=3;
                    if (tr.cells[0].colSpan<=0) tr.cells[0].colSpan=1;
                    tr.cells[2].colSpan-=3;
                    if (tr.cells[2].colSpan<=0) tr.cells[2].colSpan=1;
                    tr.cells[1].colSpan+=6;
                    obj.innerHTML="<table class='orgunitchartitemcell2' cellSpacing=0 cellPadding=0 border=0><tr><td><%=name%></td></tr></table>";
                    obj.style.height=25;
                }
               
            </SCRIPT>
        </td>
    </tr>
</table>
</body>

<script type="text/javascript">
    function print1() {
        document.all('control').style.display = "none";
        window.print();
        document.all('control').style.display = "";
    }
</script>
</html>