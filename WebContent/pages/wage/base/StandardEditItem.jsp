<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageStdItemBO" %>
<%@ page import="com.hr319wg.wage.pojo.vo.WageStandardVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@ page import="java.util.*"%>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    WageStandardVO stdVO = (WageStandardVO) session.getAttribute("stdVO");
    ArrayList hItem = stdVO.getH_item();
    ArrayList vItem = stdVO.getV_item();
    ArrayList rItem = stdVO.getR_item();
%>

<script language="javascript" src="/js/hashtable.js"></script>
<script language="javascript" src="/js/selectItem.js"></script>

<x:saveState value="#{wage_standardBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="wage_standardBB.standard.unitId"/>
<h:inputHidden value="wage_standardBB.standard.stdId"/>
<h:panelGrid align="center" width="95%">
    <h:panelGrid align="right" columns="2" cellspacing="2">
        <h:commandButton styleClass="button01" value="下一步" action="#{wage_standardBB.step2_setCode}" onclick="if(checkSubmit(document.forms(0))){}else{return false;}"/>
        <h:commandButton styleClass="button01" value="取消返回" action="#{wage_standardBB.list}"/>
    </h:panelGrid>
</h:panelGrid>

<%
    ArrayList list2 = SysCacheTool.queryInfoItemBySetId("A815");
    int count2 = list2.size();
    String codestr ="";
    for (int i = 0; i < count2; i++) {
        InfoItemBO item = (InfoItemBO) list2.get(i);
        if (InfoItemBO.DATA_TYPE_INT.equals(item.getItemDataType())
                || InfoItemBO.DATA_TYPE_FLOAT.equals(item.getItemDataType())
                || InfoItemBO.DATA_TYPE_COMPUTE.equals(item.getItemDataType())) {
            boolean flag = false;
            if (rItem.size() > 0) {
                flag = ((WageStdItemBO) rItem.get(0)).getField().equals(item.getItemId()) ? true : false;
            }
            if (flag) {
                codestr = item.getItemId();
                break;
            }
        } else {
            continue;
        }
    }
   %>

<c:verbatim>
<br>
<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0" class="table03">
<tr>
    <td class="td_middle" ><strong>结果指标</strong></td>
    <td class="td_middle" align=center colspan="3">
        <input readonly alt="公式结果指标项|0|s" id="RItemIds" name="RItemIds" value="<%=codestr%>" code="<%=codestr%>" dict="yes" dict_num="INFOITEM"/>
        <input type="button" class="button_select" onclick="PopUpWageItemDlg(form1.RItemIds);" value=" " id="codebnt"/>
    </td>
</tr>
<tr align="center">
    <td class="td_top" colspan="4" align="left"><strong>纵向指标设置</strong></td>
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
                    }
                }
                for(int i=0;i<types.size();i++){
                    CodeItemBO code=(CodeItemBO)types.get(i);
                    if (!"1".equals(code.getItemStatus())) continue;
                    if(!code.getTreeId().startsWith("0001")) break;
                    out.println("<optgroup label="+code.getItemName()+">");
                    ArrayList rsa=(ArrayList)rs.get(code.getItemId());
                    if (rsa!=null){
                        for(int j=0;j<rsa.size();j++){
                            InfoSetBO set = (InfoSetBO) rsa.get(j);
                            out.println("<option value='" + set.getSetId() + "'>" + set.getSetNameEx() + "</option>");
                        }
                    }
                    out.println("</optgroup>");
                }
            %>
        </select>
      </td>
    <td class="td_middle">&nbsp;</td>
    <td align="center" class="td_middle">纵向指标</td>
    <td align="center" class="td_middle">关联代码</td>
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
                        WageStdItemBO tmp = (WageStdItemBO) vIterator.next();
                        String table=tmp.getTable();
                        if(table!=null && !"".equals(table)){
	                        String text = SysCacheTool.findInfoItem(table, tmp.getField()).getItemName();
	                        %>
	                        <option value="<%=tmp.getField()%>"><%=text%></option>
	                        <%
                        }
                    }
                }
            %>
        </select></td>
        <td align="center" class="td_middle">
        	</c:verbatim>
        	<h:selectOneMenu value="#{wage_standardBB.vCode}">
               <c:selectItems value="#{wage_standardBB.codeSet}"/>
            </h:selectOneMenu>
        	<c:verbatim>
        </td>
</tr>
<tr align="center">
    <td class="td_top" colspan="4" align="left"><strong>横向指标设置</strong></td>
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
                    if (!"1".equals(code.getItemStatus())) continue;
                    if(!code.getTreeId().startsWith("0001")) break;
                    out.println("<optgroup label="+code.getItemName()+">");
                    ArrayList rsa=(ArrayList)rs1.get(code.getItemId());
                    if (rsa!=null){
                        for(int j=0;j<rsa.size();j++){
                            InfoSetBO set = (InfoSetBO) rsa.get(j);
                            out.println("<option value='" + set.getSetId() + "'>" + set.getSetNameEx() + "</option>");
                        }
                    }
                    out.println("</optgroup>");
                }
            %>
        </select></td>
    <td class="td_middle">&nbsp;</td>
    <td align="center" class="td_middle" align="left">横向指标</td>
    <td align="center" class="td_middle">关联代码</td>
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
                        WageStdItemBO tmp = (WageStdItemBO) hIterator.next();
                        String table=tmp.getTable();
                        if(table!=null && !"".equals(table)){
	                        String text = SysCacheTool.findInfoItem(table, tmp.getField()).getItemName();
	                        %>
	                        <option value="<%=tmp.getField()%>"><%=text%></option>
	                        <%
                        }
                    }
                }
            %>
        </select></td>
        <td align="center" class="td_middle">
        	</c:verbatim>
        	<h:selectOneMenu value="#{wage_standardBB.hCode}">
               <c:selectItems value="#{wage_standardBB.codeSet}"/>
            </h:selectOneMenu>
        	<c:verbatim>
        </td>
</tr>

</table>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</c:verbatim>
</h:form>

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
                        if ((!InfoItemBO.DATA_TYPE_CODE .equals(item.getItemDataType()) && !InfoItemBO.DATA_TYPE_INT .equals(item.getItemDataType()) && !InfoItemBO.DATA_TYPE_FLOAT .equals(item.getItemDataType()))||
                             InfoItemBO.SYSITEM_HIDDEN.equals(item.getItemProperty()))
                            continue;
                        String value = new StringBuffer().append("tmp=new InfoItem('")
                                .append(CommonFuns.filterNull(item.getItemId())).append("','")
                                .append(CommonFuns.filterNull(item.getItemNameEx())).append("','")
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
    %>
</script>

<script type="text/javascript" language="javascript">
    function checkSubmit(form1) {
    	if (form1.RItemIds.value == "" || form1.RItemIds.value == null) {
            alert("结果指标不能为空！");
            return false;
        }else if (form1.VItemIds.options.length == 0) {
            alert("横向指标不能为空！");
            return false;
        } else {
            selectTotal(form1.HItemIds);
            selectTotal(form1.VItemIds);
            form1.RItemIds.value =form1.RItemIds.code
            return true;
        }
    }
</script>

