<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageFBStdItemBO" %>
<%@ page import="com.hr319wg.wage.pojo.vo.WageFBStandardVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@ page import="java.util.*"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    WageFBStandardVO stdVO = (WageFBStandardVO) session.getAttribute("stdVO");
    ArrayList hItem = stdVO.getH_item();
    ArrayList vItem = stdVO.getV_item();
    ArrayList rItem = stdVO.getR_item();
%>
<html>
<head>
    <title></title>
    <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/hashtable.js"></script>
    <script language="javascript">
        function InfoItem(id, name, dataType, code) {
            this.itemId = id;
            this.name = name;
            this.dataType = dataType;
            this.code = code;
        }
        var itemHash = new Hashtable();
        <%
            List setList = SysCacheTool.queryAllInfoSet();
            if (setList != null) {
                for (int i=0;i<setList.size();i++) {
                    InfoSetBO set = (InfoSetBO)setList.get(i);
                    String setId = set.getSetId();
                    if (!"A".equals(set.getSet_bType())) continue;
                    
                    List itemList = SysCacheTool.queryInfoItemBySetId(setId);
                    if (null != itemList) {
                        String hashname = "hash" + setId;
                        out.println("var " + hashname + "=new Hashtable();");
                        for(int j =0;j<itemList.size();j++) {
                            InfoItemBO item = (InfoItemBO) itemList.get(j);
                            if (!InfoItemBO.DATA_TYPE_CODE .equals(item.getItemDataType()))
                                continue;
                            String value = new StringBuffer().append("tmp=new InfoItem('")
                                    .append(CommonFuns.filterNull(item.getItemId())).append("','")
                                    .append(CommonFuns.filterNull(item.getItemName())).append("','")
                                    .append(item.getItemDataType()).append("','")
                                    .append(CommonFuns.filterNull(item.getItemCodeSet())).append("');")
                                    .toString();
                            out.println(value);
                            out.println(hashname + ".put('" + item.getItemId() + "',tmp);");
                        }
                        out.println("itemHash.put('" + setId + "'," + hashname + ");");
                    }
                }
            }
        %></script>
    <script type="text/javascript" language="javascript">
        function checkSubmit(form1) {
            if (form1.HItemIds.options.length == 0 && form1.VItemIds.options.length == 0) {
                alert("横向指标、纵向指标不能同时为空！");
                return false;
//            } else if (form1.RItemIds.value == "" || form1.RItemIds.value == null) {
//                alert("结果指标不能为空！");
//                return false;
            } else {
                selectTotal(form1.HItemIds);
                selectTotal(form1.VItemIds);
//                form1.RItemIds.value =form1.RItemIds.code
                return true;
            }
        }
    </script>
</head>

<body>
<x:saveState value="#{wage_fbstandardBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="wage_fbstandardBB.standard.unitId"/>
<h:inputHidden value="wage_fbstandardBB.standard.stdId"/>
<h:panelGrid align="center" width="95%">
    <h:panelGrid align="right" columns="2" cellspacing="2">
        <h:commandButton styleClass="button01" value="下一步" action="#{wage_fbstandardBB.step2_setCode}" onclick="if(checkSubmit(document.forms(0))){}else{return false;}"/>
        <h:commandButton styleClass="button01" value="取消返回" action="#{wage_fbstandardBB.list}"/>
    </h:panelGrid>
</h:panelGrid>
<c:verbatim escape="false">
<br>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0" class="table03">
<tr align="center">
    <td class="td_top">备选指标</td>
    <td class="td_top">&nbsp;</td>
    <td class="td_top">已选指标</td>
</tr>
<tr>
    <td align="center" class="td_middle">
        <select style="WIDTH: 200px" name="infoSet" onChange="forSelectSet(form1.infoItem,form1.infoSet)">
            <option value="">请选择纵向指标集</option>
            <%
                ArrayList types = SysCacheTool.queryCodeItemBySetId("2001");
                List  list = SysCacheTool.queryAllInfoSet();
                HashMap rs = new HashMap();
                for (int i=0;i<list.size();i++) {
                    InfoSetBO tmp = (InfoSetBO) list.get(i);
                    if ("A".equals(tmp.getSet_bType()) && InfoSetBO.STATUS_OPEN.equals(tmp.getSetStatus())) {
                        ArrayList rsa=(ArrayList)rs.get(tmp.getSet_sType());
                        if(rsa==null)rsa=new ArrayList();
                        rsa.add(tmp);
                        rs.put(tmp.getSet_sType(),rsa);
                    } else if (!"A".equals(tmp.getSet_bType())) {
                        continue;
                    }
                }
                for(int i=0;i<types.size();i++){
                    CodeItemBO code=(CodeItemBO)types.get(i);
                    if(!code.getTreeId().startsWith("0001")) break;
//                    out.println("<optgroup label="+code.getItemName()+">");
                    ArrayList rsa=(ArrayList)rs.get(code.getItemId());
                    int count=rsa.size();
                    for(int j=0;j<count;j++){
                        InfoSetBO set = (InfoSetBO) rsa.get(j);
                        if(set.getSetId().equals("A705")||set.getSetId().equals("A204"))
                            out.println("<option value='" + set.getSetId() + "'>" + set.getSetName() + "</option>");
                    }
//                    out.println("</optgroup>");
                }
            %>
        </select></td>
    <td class="td_middle">&nbsp;</td>
    <td align="center" class="td_middle">纵向指标</td>
</tr>
<tr>
    <td  align="center" valign="top" class="td_middle">
        <select size="8" multiple style="WIDTH: 200px" name="infoItem">
        </select></td>
    <td align="center" class="td_middle">
        <INPUT name=addVItem type=button class="button01" onclick="forAddItem(form1.VItemIds,form1.infoItem)"
               value=" ->> ">
        <br><br>
        <INPUT name=DelLoc1 type=button class="button01" onclick="removeItem(document.forms(0).VItemIds)"
               value=" <<- "></td>
    <td align="center" class="td_middle">
        <select name="VItemIds" size="6" multiple style="WIDTH: 200px">
            <%
                if (vItem != null && vItem.size() > 0) {
                    Iterator vIterator = vItem.iterator();
                    while (vIterator.hasNext()) {
                        WageFBStdItemBO tmp = (WageFBStdItemBO) vIterator.next();
                        String text = SysCacheTool.findInfoItem(tmp.getTable(), tmp.getField()).getItemName();
            %>
            <option value="<%=tmp.getField()%>"><%=text%></option>
            <%
                    }
                }
            %>
        </select></td>
</tr>
<tr>
    <td align="center" class="td_middle">
        <select style="WIDTH: 200px" name="infoSet1" onChange="forSelectSet(form1.infoItem1,form1.infoSet1)">
            <option value="">请选择横向指标集</option>
            <%
                ArrayList types1 = SysCacheTool.queryCodeItemBySetId("2001");
                List  list1 = SysCacheTool.queryAllInfoSet();
                HashMap rs1 = new HashMap();
                for (int i=0;i<list1.size();i++) {
                    InfoSetBO tmp = (InfoSetBO) list1.get(i);
                    if ("A".equals(tmp.getSet_bType()) && InfoSetBO.ISSUE_YES.equals(tmp.getSet_Issue())) {
                        ArrayList rsa=(ArrayList)rs1.get(tmp.getSet_sType());
                        if(rsa==null)rsa=new ArrayList();
                        rsa.add(tmp);
                        rs1.put(tmp.getSet_sType(),rsa);
                    } else if (!"A".equals(tmp.getSet_bType())) {
                        continue;
                    }
                }
                for(int i=0;i<types1.size();i++){
                    CodeItemBO code=(CodeItemBO)types1.get(i);
                    if(!code.getTreeId().startsWith("0001")) break;
//                    out.println("<optgroup label="+code.getItemName()+">");
                    ArrayList rsa=(ArrayList)rs1.get(code.getItemId());
                    int count=rsa.size();
                    for(int j=0;j<count;j++){
                        InfoSetBO set = (InfoSetBO) rsa.get(j);
                        if(set.getSetId().equals("A705")||set.getSetId().equals("A204"))
                            out.println("<option value='" + set.getSetId() + "'>" + set.getSetName() + "</option>");
                    }
//                    out.println("</optgroup>");
                }
            %>
        </select></td>
    <td class="td_middle">&nbsp;</td>
    <td align="center" class="td_middle">横向指标</td>
</tr>

<tr>
    <td  align="center" valign="top" class="td_middle">
        <select size="8" multiple style="WIDTH: 200px" name="infoItem1">
        </select></td>
    <td align="center" class="td_middle">
        <INPUT name=AddLoc2 type=button class="button01" onclick="forAddItem(form1.HItemIds,form1.infoItem1)"
               value=" ->> ">
        <br><br>
        <INPUT name=DelLoc2 type=button class="button01" onclick="removeItem(form1.HItemIds)" value=" <<- "></td>
    <td align="center" class="td_middle">
        <select size="6" multiple style="WIDTH: 200px" name="HItemIds">
            <%
                if (hItem != null && hItem.size() > 0) {
                    Iterator hIterator = hItem.iterator();
                    while (hIterator.hasNext()) {
                        WageFBStdItemBO tmp = (WageFBStdItemBO) hIterator.next();
                        String text = SysCacheTool.findInfoItem(tmp.getTable(), tmp.getField()).getItemName();
            %>
            <option value="<%=tmp.getField()%>"><%=text%></option>
            <%
                    }
                }
            %>
        </select></td>
</tr>
<!--<tr>-->
    <!--<td class="td_middle">&nbsp;</td>-->
    <!--<td class="td_middle" align=center>选择结果指标</td>-->
    <!--<td class="td_middle" align=center>-->
        <%
//            ArrayList list2 = SysCacheTool.queryInfoItemBySetId("A815");
//            int count2 = list2.size();
//            String code ="";
//            for (int i = 0; i < count2; i++) {
//                InfoItemBO item = (InfoItemBO) list2.get(i);
//                if (InfoItemBO.DATA_TYPE_INT.equals(item.getItemDataType())
//                        || InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())
//                        || InfoItemBO.DATA_TYPE_COMPUTE.equals(item.getItemDataType())) {
//                    boolean flag = false;
//                    if (rItem.size() > 0) {
//                        flag = ((WageFBStdItemBO) rItem.get(0)).getField().equals(item.getItemId()) ? true : false;
//                    }
//                    if (flag) {
//                        code = item.getItemId();
//                        break;
//                    }
//                } else {
//                    continue;
//                }
//            }
           %>
        <%--<input readonly alt="公式结果指标项|0|s" id="RItemIds" name="RItemIds" value="<%=code%>" code="<%=code%>" dict="yes" dict_num="INFOITEM"/>--%>
    <%--<input type="button" class="button_select" onclick="PopUpWageItemDlg(form1.RItemIds);" value=" "--%>
                     <!--id="codebnt"/>-->
        <%--<select style="WIDTH: 200px" name="RItemIds">--%>
            <!--<option value=""></option>-->
            <%
//                ArrayList list2 = SysCacheTool.queryInfoItemBySetId("A815");
//                int count2 = list2.size();
//                for (int i = 0; i < count2; i++) {
//                    InfoItemBO item = (InfoItemBO) list2.get(i);
//                    if (InfoItemBO.DATA_TYPE_INT.equals(item.getItemDataType())
//                            || InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())
//                            || InfoItemBO.DATA_TYPE_COMPUTE.equals(item.getItemDataType())) {
//                        boolean flag = false;
//                        if (rItem.size() > 0) {
//                            flag = ((WageFBStdItemBO) rItem.get(0)).getField().equals(item.getItemId()) ? true : false;
//                        }
//                        String selected = "";
//                        if (flag) {
//                            selected = "selected";
//                        }
//                        out.println("<option value='" + item.getItemId() + "' " + selected + ">" + item.getItemName() + "</option>");
//                    } else {
//                        continue;
//                    }
//                }
           %>
        <!--</select>-->
        <!--</td>-->
<!--</tr>-->
</table>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</h:form>
</body>
</html>