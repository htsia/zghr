<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.api.ActivePageAPI" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCache" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
  <head>
      <title></title>
      <base target="_self">
      <link href="/css/style.css" rel="stylesheet" type="text/css"/>
      <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
      <script type="text/javascript" language="javascript" src="/js/check.js"></script>
       <script type="text/javascript">
           function forSave() {
               document.all("save").value="1";
               return forsubmit(document.forms(0));
           }
       </script>
  </head>
  <body>
  <form id="form1" action="/pages/common/colEdit.jsp">
  <%
      String save = CommonFuns.filterNull(request.getParameter("save"));
      String selectItem = CommonFuns.filterNull(request.getParameter("selectItem"));

      //从request里得到TableVO,键值request.getAttribute(tableId)
      String tableId = request.getParameter("target");
      if (tableId == null || "".equals(tableId.trim())) {
          tableId = Constants.OBJECT;
      }
      //从request得到TableVO
      TableVO table = (TableVO) request.getAttribute(tableId);
      //如果request里没有，则从session里取
      if (table == null) {
          table = (TableVO) session.getAttribute(tableId);
      }

      String keyName = "ID";
      List modiList = new ArrayList();
      if ("B".equals(table.getSetType())) {
          keyName = "ORGUID";
      }


      if ("1".equals(save)) { // 执行保存操作
          ActivePageAPI api = (ActivePageAPI) SysContext.getBean("sys_activePageApi");
          InfoItemBO ib = SysCacheTool.findInfoItem("", selectItem);
          InfoSetBO setbo = SysCacheTool.findInfoSet(ib.getSetId());
          for (int i = 0; i < table.getRowData().length; i++) {
              Hashtable row = table.getRowData()[i].cellArray2Hash();
              CellVO cell = (CellVO) row.get(keyName);
              CellVO modi = (CellVO) row.get(selectItem);

              String modiValue = CommonFuns.filterNull(request.getParameter(cell.getValue()));
              if ("TOMCAT".equals(CommonFuns.getAppType())) {
                  modiValue = CommonFuns.getParaFromURL(request.getQueryString(), cell.getValue());
                  modiValue = URLDecoder.decode(modiValue);
              }
              if (!modiValue.equals(modi.getValue())) {
                  modiList.add(cell.getValue());
                  modi.setValue(modiValue);
                  String sql = "update " + setbo.getSetId() + " set " + ib.getItemId() + "='" + modiValue + "' where " + keyName + "='" + cell.getValue() + "'";
                  if (InfoSetBO.RS_TYPE_MANY.equals(setbo.getSet_rsType())) {
                      sql += " and " + setbo.getSetId() + "000='00901'";
                  }
                  try {
                      api.executeSql(sql);
                  }
                  catch (Exception e) {

                  }
                  if ("A001".equals(setbo.getSetId())){ // 刷新缓存
                      SysCache.setPerson(cell.getValue(), SysCache.OPER_UPDATE);
                  }
                  else if ("B001".equals(setbo.getSetId())){ // 刷新缓存
                      SysCache.setMap(new String[]{cell.getValue()}, SysCache.OPER_UPDATE,SysCache.OBJ_UNIT);
                  }
              }
          }


          if ("ORGUID".equals(keyName)) {
              SysCache.setMap((String[]) modiList.toArray(new String[modiList.size()]), SysCache.OPER_UPDATE, SysCache.OBJ_ORG);
          } else {
              SysCache.setMap((String[]) modiList.toArray(new String[modiList.size()]), SysCache.OPER_UPDATE, SysCache.OBJ_PERSON);
          }
      }

  %>

     <table width="98%" align="center" >
         <tr><td align="right" colspan="3">
             <select name="selectItem" onchange="disPlayProcessBar();submit();">
                 <option>--请选择字段--</option>
         <%
             CellVO[] head = table.getHeader();
             for (int i = 0; i < head.length; i++) {
                 if (head[i].getPermission() == CellVO.PERMISSION_WRITE &&
                     !InfoItemBO.PROPERTY_SYSTEM_.equals( head[i].getItemProperty()) &&
                     !InfoItemBO.PROPERTY_CONTROL_HIDE.equals( head[i].getItemProperty()) &&
                     !"B001002".equals(head[i].getItemId()) &&
                    !"A001701".equals(head[i].getItemId()) &&
                    !"A001705".equals(head[i].getItemId()) &&
                    !"A001706".equals(head[i].getItemId()) &&
                    !"A001708".equals(head[i].getItemId()) &&
                    !"A001735".equals(head[i].getItemId()) &&
                    !"A001054".equals(head[i].getItemId()) &&
                    !"A001715".equals(head[i].getItemId())
                         ) {
                     if ("".equals(selectItem)){
                           out.println("<option selected value='" + head[i].getItemId() + "'>" + head[i].getItemName() + "</option>\n");
                           selectItem=head[i].getItemId();
                     }
                     else{
                         if (selectItem.equals(head[i].getItemId())){
                            out.println("<option selected value='" + head[i].getItemId() + "'>" + head[i].getItemName() + "</option>\n");
                         }
                         else{
                            out.println("<option  value='" + head[i].getItemId() + "'>" + head[i].getItemName() + "</option>\n");
                         }
                     }
                 }
             }
         %>
             </select>
             <input type="hidden" name="save" value="0">
             <input type="submit" class="button01" value="保存" onclick="return forSave();">
         </td>
         </tr>
         </table>
      
         <table width="98%" align="center" class='table03' id="data">
         <tr>
             <%
                 if ("B".equals(table.getSetType())){
                     out.println("<td class='locked_top'>机构编码</td><td class='locked_top'>机构名称</td>");
                 }
                 else {
                     out.println("<td class='locked_top'>人员编码</td><td class='locked_top'>人员名称</td>");
                 }
                 
                 InfoItemBO ib=SysCacheTool.findInfoItem("",selectItem);
                 if (ib!=null){
                    out.println("<td class='locked_top'>"+ib.getItemName()+"</td>");
                 }
                 else{
                     out.println("<td class='locked_top'></td>");
                 }
             %>
         </tr>
         <%
             for (int i = 0; i < table.getRowData().length; i++) {
                 Hashtable row = table.getRowData()[i].cellArray2Hash();
                 CellVO cell = (CellVO) row.get(keyName);
                 if (cell != null) {
                     out.println("<tr>");
                     String key = cell.getValue();
                     if ("B".equals(table.getSetType())) {
                         OrgBO bo = SysCacheTool.findOrgById(key);
                         out.println("<td class='td_middle'>" + bo.getOrgCode() + "</td><td class='td_middle'>" + bo.getName() + "</td>");
                     } else {
                         PersonBO bo = SysCacheTool.findPersonById(key);
                         out.println("<td class='td_middle'>" + CommonFuns.filterNull(bo.getPersonCode()) + "</td><td class='td_middle'>" + CommonFuns.filterNull(bo.getName()) + "</td>");
                     }
                     CellVO modi = (CellVO) row.get(selectItem);
                     if (modi != null) {
                         if (InfoItemBO.DATA_TYPE_CODE.equals(ib.getItemDataType())) {
                             out.println("<td class='td_middle'><input name='" + key + "' type='text' class='input' dict='yes' dict_num='"
                                     + ib.getItemCodeSet() + "' code='" + modi.getValue() + "' value='" + CodeUtil.interpertCode(modi.getValue()) + "'>"
                                     + "<input type='button' class='button_select' onclick='PopUpCodeDlgOneControl(\"" + key + "\")'>"
                                     + "</td>");
                         } else {
                             out.println("<td class='td_middle'><input name='" + key + "' type='text' class='input' value='" + modi.getValue() + "'></td>");
                         }
                     } else {
                         out.println("<td class='td_middle'></td>");
                     }
                     out.println("</tr>");
                 }
             }
         %>
     </table>
      </form>
  </body>
</html>
<script type="text/javascript">
      setDataTableOver("data");
      interpret(document.forms(0));
      <%
         if ("1".equals(save)){
            out.println("alert('保存成功!')");
            out.println("document.all('save').value='1';");
         }
      %>
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
