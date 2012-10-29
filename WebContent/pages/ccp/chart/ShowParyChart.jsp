<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.ccp.pojo.bo.PartyBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String superId = request.getParameter("superId");
    String showLevel=request.getParameter("showLevel");
    int expand=1;
    if (showLevel!=null && !"".equals(showLevel)){
        expand=Integer.parseInt(showLevel);
    }
    if (expand>=3) expand=3;
    showLevel=String.valueOf(expand);
%>

<html>
<head><title>����֯����ͼ</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/structure.js"></script>
    <SCRIPT language=javascript>
        //oid,������ţ��������ͣ�������Σ��Ƿ�򿪣�
        var actionbar = null;
        var aNode;
        var mode = 'chart';

        <% 
        //RadioGroup ��ʾģʽ   �ӱ�ҳ���ȡ������Ĭ�� ����
        if ("tree".equals(request.getParameter("RadioGroup"))){
             out.println("mode='tree';");
        }
        PartyBO  partyBO = SysCacheTool.findParty(superId);
        ArrayList list = SysCacheTool.querySubObject(SysCache.OBJ_PARTY, "PA", superId);
        

        String name = "";
        String id="";
        if(partyBO != null){
            name = partyBO.getName();
            id  = partyBO.getPartyId();
            out.println("var node"+ id +"= new Node("+ id +","+ id+",'"+name+"',1,true,2)");
            out.println("aNode=node"+id +";");
            out.println("aNode.open=true;");

            if(list != null && list.size() >0){
               for(int i=0;i<list.size();i++){
            	   PartyBO  tempBO = (PartyBO)list.get(i);
                 if(tempBO != null){
                	String cancleDate = tempBO.getPartyCancelDate();
                   if(cancleDate != null && !"".equals(cancleDate) ){
                        continue;
                    }
                  }

                 if(tempBO != null){
                   String sid=tempBO.getPartyId();
                   out.println("var node"+sid+"= new Node("+sid+","+tempBO.getTreeId()+",'"+tempBO.getPartyName()+"',2,true,2)");
                   out.println("node"+id+".addSubnode(node"+sid+");");

                   if (expand>1){  // ��Ҫ��ʾ�¼�
                        ArrayList child = SysCacheTool.querySubObject(SysCache.OBJ_PARTY, "PA", sid);
                        for(int j=0;j<child.size();j++){
                        	PartyBO  childbo = (PartyBO)list.get(i);
                             if(childbo != null){
                            	 String cancleDate = childbo.getPartyCancelDate();
                                if(cancleDate != null && !"".equals(cancleDate)){
                                    continue;
                                }
                                 }
                            if(childbo != null){
                               String csid=childbo.getPartyId();
                               out.println("var node"+csid+"= new Node("+csid+","+childbo.getTreeId()+",'"+childbo.getName()+"',3,true,2)");
                               out.println("node"+sid+".addSubnode(node"+csid+");");

                               // ��ʾ���¼�
                                if (expand>2){
                                    ArrayList childchild = SysCacheTool.querySubObject(SysCache.OBJ_ORG, "PA", csid);
                                    for(int k=0;k<childchild.size();k++){
                                    	PartyBO  childchildbo = (PartyBO)list.get(i);
                                         if(childchildbo != null){
                                        	 String cancleDate = childbo.getPartyCancelDate();
                                             if(cancleDate != null && !"".equals(cancleDate)){
                                                  continue;
                                             }
                                         }
                                           String ccsid=childchildbo.getPartyId();
                                           out.println("var node"+ccsid+"= new Node("+ccsid+","+childchildbo.getTreeId()+",'"+childchildbo.getName()+"',4,true,2)");
                                           out.println("node"+csid+".addSubnode(node"+ccsid+");");
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
        var codeKeyValue = "���";
        var nameKeyValue = "����";
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
<form action="/pages/ccp/chart/ShowParyChart.jsp">
<table width="95%" border="0" cellspacing="0" cellpadding="0" id="control" valign="top">
    <tr>
        <td align="right">
            ��ʾ����
            <input type="text" name="showLevel" id="showLevel" value="<%=showLevel%>">
            <input type="hidden" name="superId" id="superId" value="<%=superId%>">
            ��ʾģʽ
            <INPUT id="chart" value="chart" <%if ("tree".equals(request.getParameter("RadioGroup"))) out.print(""); else out.print("checked"); %> type="radio" name="RadioGroup">����
            <INPUT id="tree" value="tree"  <%if (!"tree".equals(request.getParameter("RadioGroup"))) out.print(""); else out.print("checked"); %> type="radio" name="RadioGroup">����
            
            <input type="submit" class="button01"  value=" ���� ">
            <input type="button" class="button01" onclick="print1()" value=" ��ӡ ">
        </td>
    </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align=center>
    <tr>
        <td id=chartTd vAlign=top align=center>
            <SCRIPT>
                drawChart();
            </SCRIPT>
        </td>
    </tr>
</table>
</form>
</body>

<script type="text/javascript">
    function print1() {
        document.all('control').style.display = "none";
        window.print();
        document.all('control').style.display = "";
    }
</script>

</html>