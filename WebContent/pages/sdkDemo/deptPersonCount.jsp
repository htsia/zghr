<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.sys.api.ActivePageAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultItemVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticResultVO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <head>
      <title></title>
      <link href="/css/style.css" rel="stylesheet" type="text/css"/>
      <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
      <script type="text/javascript">
          function dosubmit(){
               PopUpOrgDlg('orgId',2,'');
               document.all('orgId').value=document.all('orgId').code;
               document.all('form1').submit();
          }
      </script>
  </head>

  <body>
  <form id="form1" action="deptPersonCount.jsp">
  <%
      User user = (User) session.getAttribute(Constants.USER_INFO);
      String orgID = request.getParameter("orgId");
      if (orgID == null || "".equals(orgID)) {
          orgID = user.getOrgId();
      }
      String orgName = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,orgID);
      String sql = "select B001005,pcount from (select A001705,count(*) as pcount from a001 where A001705 in (select orguid from b001 where B001002='" + orgID + "' and B001075='089111') group by A001705) aaa left join b001 on A001705=orguid order by b001010";
      ActivePageAPI api = (ActivePageAPI) SysContext.getBean("sys_activePageApi");
      TableVO table = new TableVO();
      CellVO[] head = new CellVO[2];
      head[0] = new CellVO();
      head[0].setItemId("B001005");
      head[0].setItemName("部门名称");

      head[1] = new CellVO();
      head[1].setItemId("pcount");
      head[1].setItemName("人数");

      table.setHeader(head);

      api.querySql(table, sql, null, 0, 0, false);
      session.setAttribute("ShowTable", table);
  %>
  <table width="98%" align="center" height="98%">
   <tr><td height="5" colspan=2>
       <strong>选择单位</strong>
       <input type="text" readonly id="orgId" name="orgId" code="<%=orgID%>" value="<%=orgName%>">
       <input type="button"  onclick="dosubmit();" class="button_select">
       <input type="button"  onclick="ExportShowTable();" class="button01" value="导出">
   </td></tr>
      
  <tr>
      <td width="280">
      <jsp:include page="/pages/common/activepage/ShowTable.jsp">
          <jsp:param name="para" value="true"/>
     </jsp:include>
      </td>
      <td>
          <%
              StaticResultVO[] resultvo = new StaticResultVO[table.getRecordNum()];
              for (int i = 0; i <table.getRecordNum(); i++) {
                  CellVO[] row=table.getRowData()[i].getCell();
                  resultvo[i] = new StaticResultVO();
                  StaticResultItemVO[] items = new StaticResultItemVO[1];
                  items[0] = new StaticResultItemVO();
                  items[0].setAllValue(row[0].getValue());   // 设置标题
                  items[0].setCount(Integer.parseInt(row[1].getValue()));      // 设置数值
                  items[0].setSum("0");
                  resultvo[i].setItems(items);
              }
              session.setAttribute("STATIC_RESULT", resultvo);

          %>
          <iframe width="98%" height="98%" frameborder='0'  scrolling='auto' src="/pages/qry/StaticResultBar.jsp?height=380&width=1500"></iframe>
      </td>
  </tr>
  </table>
</form>
</body>
</html>