<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
<script language="javascript" src="<%=request.getContextPath()%>/js/structure.js"></script>
</c:verbatim>
<h:form id="form1">
    <h:inputHidden value="#{post_PostMapBB.postList}"/>
  <c:verbatim>
    <SCRIPT language=javascript>
        var actionbar = null;
        var mode = 'chart';

    <%
 
        OrgBO org= (OrgBO) session.getAttribute("ROOTORG");
        if (org!=null){
           out.println("var rootNode = new Node("+org.getOrgId()+",0,'"+org.getName()+"');");
           out.println("rootNode.open=true;");
        }
        List list = (List) session.getAttribute("POSTMAP");
        if (list != null) {
            String output = "";
            for (int i = 0; i < list.size(); i++) {
                CellVO[] row = (CellVO[]) list.get(i);
                output = "  var node" + row[0].getValue() + "=new Node(" + row[0].getValue() + ","+row[0].getValue()+",'"+row[3].getValue()+"',null,null,1)";
                out.println(output);
                if (row[1].getValue() != null && !"".equals(row[1].getValue())) {
                    output = "  node" + row[1].getValue()+".addSubnode(node"+row[0].getValue()+");";
                    out.println(output);
                    output = "  node" + row[1].getValue()+".open=true";
                    out.println(output);
                }
                else{
                    output = "  rootNode.addSubnode(node"+row[0].getValue()+");";
                    out.println(output);
                }
            }
        }
    %>
        var viewEmployeeAltLabel = "";
        var viewUnitInfoAltLabel = "";

        //set the global string var value
        var contextPath = "../../../";
        var codeKeyValue = "±àºÅ";
        var nameKeyValue = "Ãû³Æ";
        var chartVersion = "0";

        var isCompact = true;


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
      <table width="95%" border="0" cellspacing="0" cellpadding="0" id="control" valign="top">
          <tr>
              <td height="15"></td>
          </tr>

      </table>

    <table align="center">
    <tr>
        <td id=chartTd vAlign=top align=center>
            <SCRIPT language=javascript>
                drawChart();
            </SCRIPT>
        </td>
    </tr>
    </table>
    </c:verbatim>
</h:form>

