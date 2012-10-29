<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.HtmlMHTCompiler" %>
<%@ page import="java.io.File" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.util.FileUtil" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = request.getParameter("superId");
    String showLevel = request.getParameter("showLevel");
    boolean notShowVir="v2".equals(request.getParameter("vGroup"));
    int expand = 1;
    if (showLevel != null && !"".equals(showLevel)) {
        expand = Integer.parseInt(showLevel);
    }
    if (expand >= 4) expand = 4;
    showLevel = String.valueOf(expand);
    String lang = ((User) session.getAttribute(Constants.USER_INFO)).getLoginLang();
%>

<html>
<head><title>机构图</title>
    <link rel="stylesheet" type="text/css" href="/css/style.css"/>
    <script language="javascript" src="/js/structure.js"></script>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <SCRIPT language=javascript>
        function exportToWord(){
             //debugger;
             document.all("content").value=chartTd.innerHTML;
             document.all("exportType").value="WORD";
             return true;
        }
        function exportToPDF(){
             document.all("content").value=chartTd.innerHTML;
             document.all("exportType").value="PDF";
             return true;
        }
        //oid,机构编号，机构类型，机构层次，是否打开，
        var actionbar = null;
        var aNode;
        var mode = 'chart';

        <%
        if ("tree".equals(request.getParameter("RadioGroup"))){
             out.println("mode='tree';");
        }
        OrgBO org = SysCacheTool.findOrgById(superId);
        ArrayList list = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", superId);

        String name = "";
        String id="";
        if(org != null){
            name = org.getName();
            id  = org.getOrgId();
            out.println("var node"+org.getOrgId()+"= new Node("+org.getOrgId()+","+org.getTreeId()+",'"+name+"',1,false,0);");
            out.println("node"+org.getOrgId()+".open=true;");
            out.println("aNode=node"+org.getOrgId()+";");


            if(list != null && list.size() >0){
               for(int i=0;i<list.size();i++){
                 OrgBO bo = (OrgBO)list.get(i);
                 if(Constants.YES.equals(bo.getOrgCancel())){
                     continue;
                 }
                 if (OrgBO.VIRTUALTYPE.equals(bo.getorgType()) && notShowVir ) continue;
                   String sid=bo.getOrgId();
                   out.println("var node"+bo.getOrgId()+"= new Node("+bo.getOrgId()+","+bo.getTreeId()+",'"+bo.getName()+"',2,true,0);");
                   out.println("node"+id+".addSubnode(node"+sid+");");

                   if (expand>1){  // 还要显示下级
                        ArrayList child = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", sid);
                        if (child!=null && child.size()>0)        out.println("node"+sid+".open=true;");
                        for(int j=0;j<child.size();j++){
                             OrgBO childbo = (OrgBO)child.get(j);
                             if(Constants.YES.equals(childbo.getOrgCancel())){
                                 continue;
                             }
                             if (OrgBO.VIRTUALTYPE.equals(childbo.getorgType()) && notShowVir ) continue;

                               String csid=childbo.getOrgId();
                               out.println("var node"+childbo.getOrgId()+"= new Node("+childbo.getOrgId()+","+childbo.getTreeId()+",'"+childbo.getName()+"',3,true,0);");
                               out.println("node"+sid+".addSubnode(node"+csid+");");

                               // 显示下下级
                                if (expand>2){
                                    ArrayList childchild = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", csid);
                                    if (childchild!=null && childchild.size()>0)        out.println("node"+csid+".open=true;");
                                    for(int k=0;k<childchild.size();k++){
                                         OrgBO childchildbo = (OrgBO)childchild.get(k);
                                             if(Constants.YES.equals(childchildbo.getOrgCancel())){
                                                 continue;
                                             }
                                             if (OrgBO.VIRTUALTYPE.equals(childchildbo.getorgType()) && notShowVir ) continue;
                                           String ccsid=childchildbo.getOrgId();
                                           out.println("var node"+childchildbo.getOrgId()+"= new Node("+childchildbo.getOrgId()+","+childchildbo.getTreeId()+",'"+childchildbo.getName()+"',4,true,0);");
                                           out.println("node"+csid+".addSubnode(node"+ccsid+");");

                                           // 显示第4级
                                           if (expand>3){
                                               ArrayList child4 = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "OU", ccsid);
                                               if (child4!=null && child4.size()>0)        out.println("node"+ccsid+".open=true;");
                                               for(int l=0;l<child4.size();l++){
                                                   OrgBO child4bo = (OrgBO)child4.get(l);
                                                   if(Constants.YES.equals(child4bo.getOrgCancel())){
                                                         continue;
                                                   }
                                                   if (OrgBO.VIRTUALTYPE.equals(child4bo.getorgType()) && notShowVir ) continue;
                                                   String c4id=child4bo.getOrgId();
                                                   out.println("var node"+c4id+"= new Node("+child4bo.getOrgId()+","+child4bo.getTreeId()+",'"+child4bo.getName()+"',5,true,0)");
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


        var rootNode = aNode;

        function drawChart() {
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
<form action="/pages/org/chart/OrgChart.jsp">
<table width="98%" border="0" cellspacing="0" cellpadding="0" id="control" align="center">
    <tr>
        <td align="left">
            <strong>
              <%=LanguageSupport.getResource("JGGL-1032","显示虚拟组织",lang)%>
            </strong>
            <INPUT id="v1" value="v1" type="radio" name="vGroup" <%if ("v2".equals(request.getParameter("vGroup"))) out.print(""); else out.print("checked"); %>>
          <%=LanguageSupport.getResource("JGGL-1036","是",lang)%>
            <INPUT id="v2" value="v2" type="radio" name="vGroup" <%if (!"v2".equals(request.getParameter("vGroup"))) out.print(""); else out.print("checked"); %>>
          <%=LanguageSupport.getResource("JGGL-1037","否",lang)%>
            &nbsp;&nbsp;&nbsp;
            <strong>
             <%=LanguageSupport.getResource("JGGL-1034","显示级数",lang)%>
            </strong>
            <input type="text" name="showLevel" id="showLevel" value=<%=showLevel%>>
            <input type="hidden" name="superId" id="superId" value=<%=superId%>>
            <strong>
           <%=LanguageSupport.getResource("JGGL-1035","显示模式",lang)%>
            </strong>
            <INPUT id="chart" value="chart" <%if ("tree".equals(request.getParameter("RadioGroup"))) out.print(""); else out.print("checked"); %> type="radio" name="RadioGroup">
            <%=LanguageSupport.getResource("JGGL-1038","纵向",lang)%>
            <INPUT id="tree" value="tree"  <%if (!"tree".equals(request.getParameter("RadioGroup"))) out.print(""); else out.print("checked"); %> type="radio" name="RadioGroup">
            <%=LanguageSupport.getResource("JGGL-1039","横向",lang)%>
       </td>
    </tr>
    <tr>
        <td align="right">
            <input type="submit" class="button01"  value="<%=LanguageSupport.getResource("JGGL-1040","设置",lang)%>">
            <input type="hidden" id="content" name="content" value="">
            <input type="hidden" id="exportType" name="exportType" value="">
            <input type="submit" id="exportWord" class="button01"  value="<%=LanguageSupport.getResource("JGGL-1041","导出WORD",lang)%>" onclick="return exportToWord();" style="display:none">
            <input type="submit" id="exportPdf" class="button01"  value="<%=LanguageSupport.getResource("JGGL-1042","导出PDF",lang)%>" onclick="return exportToPDF();" style="display:none">
            <input type="button" class="button01" onclick="print1()" value="<%=LanguageSupport.getResource("JGGL-1043","打印",lang)%>">
        </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align=center>
    <tr>
        <td id=chartTd vAlign=top align=center>
        </td>
    </tr>
</table>
</form>
</body>

<script type="text/javascript">
    drawChart();

    if (mode=='chart'){
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
    }

    function print1() {
        document.all('control').style.display = "none";
        window.print();
        document.all('control').style.display = "";
    }
    <%
       if (request.getParameter("content")!=null && !"".equals(request.getParameter("content"))){
          try{
          String content="<link href='/css/style.css' rel='stylesheet' type='text/css'/>\n";
          content+=request.getParameter("content");
          String basePath=application.getRealPath("/");
          String fileName="";
          String exportPath="";
          if ("WORD".equals(request.getParameter("exportType"))){
               fileName=CommonFuns.getUUID()+".doc";
               exportPath=application.getRealPath("/file/tmp/")+File.separator+fileName;

               HtmlMHTCompiler ht=new HtmlMHTCompiler(content,basePath,"GBK",exportPath);
               ht.compile();

              session.setAttribute("SHOWFILE_URL","/file/tmp/"+fileName);
              session.setAttribute("SHOWFILE_TITLE","机构图文件(WORD格式)");
          }
          else{
               fileName=CommonFuns.getUUID();
               exportPath=application.getRealPath("/file/tmp/")+File.separator+fileName+".html";
               FileUtil.createFile(content.getBytes(),exportPath);
               FileUtil.Html2Pdf(exportPath,basePath+File.separator+"pages"+File.separator+"common"+File.separator+"xhtml2fo.xsl");
               session.setAttribute("SHOWFILE_URL","/file/tmp/"+fileName+".pdf");
               session.setAttribute("SHOWFILE_TITLE","机构图文件(PDF格式)");
          }
          }
          catch(Exception e){
          
          }
     %>
              showAllFile();
    <%
       }
    %>
</script>

</html>