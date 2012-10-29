<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.Hashtable"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.user.pojo.bo.RoleDataBO"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String setId = request.getParameter("setId");
    String disable = "";
    if(setId != null && !"".equals(setId.trim())){
        User user = (User)session.getAttribute(Constants.USER_INFO);
        Hashtable hash = user.getPmsInfoSet();
        boolean  flag=true;

        if(hash.containsKey(setId)){
          String n= (String) hash.get(setId);
          if(RoleDataBO.PERMISSION_REFUSE.equals(n)){
                flag =false;
            }else{
                flag = true;
            }
        }else{
            disable = "disabled" ;
        }
        if(!flag){
            out.println("<font color=#0033CC>对不起，您没有权限查看该指标集！</font>");
             return;
        }
    }

%>
<c:verbatim>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/hashtable.js"></script>
<script type="text/javascript">
var itemlist=new Hashtable();
var myHash;
function InfoItem(dataType,code,prop){
  this.dataType=dataType;
  this.code=code;
  this.prop=prop;
}

function forsave(){
    if(forsubmit(document.forms(0))){
        document.all("form1:save").click();
     }
}

function ChangeItem(arg) {
    var buttonObj;
    var txtObj;

    var length = itemlist.size();
    var key = itemlist.keys();
    var flage = true;

    buttonObj = document.all.selvalue;
    txtObj = document.all.itemValue;
    var codeobj = itemlist.get(arg.value);
    var datatype = codeobj.dataType;
    var proper = codeobj.prop;

    txtObj.value = "";
    txtObj.dataType = datatype;
    buttonObj.style.display="none";
    switch (datatype) {
        case 'code':
            txtObj.dict_num = codeobj.code;
            txtObj.dict = "yes";
            txtObj.code = "";
            txtObj.readOnly = true;
            buttonObj.style.display="block";
            if (proper == "2")
                buttonObj.disabled = true;
            else
                buttonObj.disabled = false;
            break;
        case 'd':
            txtObj.readOnly = true;
            buttonObj.style.display="block";
            if (proper == "2")
                buttonObj.disabled = true;
            else
                buttonObj.disabled = false;
            break;
        case 'WageDept':
            txtObj.dict_num = "WAGEDEPT";
            txtObj.readOnly = true;
            txtObj.dict = "yes";
            txtObj.code = "";
            buttonObj.style.display="block";
            if (proper == "2")
                buttonObj.disabled = true;
            else
                buttonObj.disabled = false;
            break;
        case 'OU':
            txtObj.dict_num = "OU";
            txtObj.readOnly = true;
            txtObj.dict = "yes";
            txtObj.code = "";
            buttonObj.style.display="block";
            if (proper == "2")
                buttonObj.disabled = true;
            else
                buttonObj.disabled = false;
            break;
        case 'PE':
            txtObj.dict_num = "PE";
            txtObj.readOnly = true;
            txtObj.dict = "yes";
            txtObj.code = "";
            buttonObj.style.display="block";
            if (proper == "2")
                buttonObj.disabled = true;
            else
                buttonObj.disabled = false;
            break;
        case 'PO':
            txtObj.dict_num = "PO";
            txtObj.readOnly = true;
            txtObj.dict = "yes";
            txtObj.code = "";
            buttonObj.style.display="block";
            if (proper == "2")
                buttonObj.disabled = true;
            else
                buttonObj.disabled = false;
            break;
        case 'PA':
            txtObj.dict_num = "PA";
            txtObj.readOnly = true;
            txtObj.dict = "yes";
            txtObj.code = "";
            buttonObj.style.display="block";
            if (proper == "2")
                buttonObj.disabled = true;
            else
                buttonObj.disabled = false;
            break;
        case 'WA':
            txtObj.dict_num = "WA";
            txtObj.readOnly = true;
            txtObj.dict = "yes";
            txtObj.code = "";
            buttonObj.style.display="block";
            if (proper == "2")
                buttonObj.disabled = true;
            else
                buttonObj.disabled = false;
            break;
        default:
            buttonObj.disabled = false;
            txtObj.readOnly = false;
            txtObj.dict_num = "";
            txtObj.dict = "no";
            txtObj.code = "";
            break;
    }
    return true;
}

function BetchdoValue() {
    var destObj = document.all.itemValue;
    var dataType = destObj.dataType;
    switch (dataType) {
        case 'WageDept':
            var pid=document.all.chk.value.split(",")[0];
            PopUpWageDeptDlgByPerson(destObj,pid);
            break;
        case 'd':
            PopUpCalendarDialog(destObj);
            break;
         case 'd6':
            PopUpCalendarDlg_OnlyMonth(destObj);
            break;
        case 'code':
            PopUpCodeDlgOneControl(destObj.id);
            break;
        case 'OU':
            PopUpOrgDlg(destObj.id,"-1");
            break;
        case 'PE':
            fPopUpPerDlg(destObj.id);
            break;
        case 'PO':
            fPopUpPostDlg(destObj.id);
            break;
        case 'WA':
            fPopUpWageUnitDlg(destObj.id);
            break;
         case 'PA':
            fPopUpPartyDlg(destObj.id,'2');
            break;
        default:
            break;
    }
    return true;
}
</script>
</c:verbatim>


<x:saveState value="#{emp_BatchPersonUpdateBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{emp_BatchPersonUpdateBB.pageInit}"/>
    <h:commandButton id="save" onclick="return true" action="#{emp_BatchPersonUpdateBB.saveUpdate}" style="display:none"/>
    <script type="text/javascript">
    <%
        TableVO table = (TableVO) request.getAttribute("batch_new");
        String pid = (String) session.getAttribute("batch_perlist");
        if(setId != null && !"".equals(setId) && table != null){

        RecordVO[] rsv=table.getRowData();
        CellVO[]	 row=rsv[0].getCell();
        String code="";
        int colnum= row.length;
        for(int j=0;j<colnum;j++){
           CellVO cell = row[j];
           if(InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType())||InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType())||InfoItemBO.PROPERTY_CONTROL_HIDE.equals(cell.getItemProperty()) || InfoItemBO.PROPERTY_CONTROL_SHOW.equals(cell.getItemProperty()) || cell.getPermission() != CellVO.PERMISSION_WRITE){
              continue;
           }else {
              if(CommonFuns.filterNull(cell.getItemCodeSet()).equals(""))
               code="temp";
              else
                code=CommonFuns.filterNull(cell.getItemCodeSet());

                String value=new StringBuffer().append("tmp=new InfoItem('")
                .append(InfoItemBO.getHtmlDataType(cell.getItemDataType())).append("','")
                .append(code).append("','").append(cell.getItemProperty()).append("');") .toString();
                out.println(value);
                out.println("itemlist.put('"+cell.getItemId()+"',tmp);");
            }
          }
        }
    %>
    </script>

    <c:verbatim>
    <br>
    <input type="hidden" name="setId" value="<%=setId%>">
    <input type="hidden" name="chk" value="<%=pid%>">
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr nowrap>
        <td class="td_top"><strong><%=LanguageSupport.getResource("RYGL-2112"," 选择指标 ")%></strong></td>
        <td class="td_top"><strong><%=LanguageSupport.getResource("RYGL-2113"," 修改内容")%></strong></td>
        <td class="td_top"><strong><%=LanguageSupport.getResource("YXGL-1026"," 操作 ")%></strong></td>
    </tr>

    <tr nowrap>
        <td class="td_top">
            <select name="setItem" onChange='ChangeItem(this)'>
                <option value="--"><%=LanguageSupport.getResource("RYGL-2114"," 请选择指标")%></option>
                <%
                    if (setId != null && !"".equals(setId) && table != null) {
                        RecordVO[] rsv = table.getRowData();
                        CellVO[]     row = rsv[0].getCell();
                        int colnum = row.length;
                        for (int j = 0; j < colnum; j++) {
                            CellVO cell = row[j];
                            if (InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType()) ||InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType())|| InfoItemBO.PROPERTY_CONTROL_HIDE.equals(cell.getItemProperty())|| InfoItemBO.PROPERTY_CONTROL_SHOW.equals(cell.getItemProperty()) || cell.getPermission() != CellVO.PERMISSION_WRITE)
                            {
                                continue;
                            }
                            out.print("<option value=" + cell.getItemId() + ">");
                            out.print(cell.getItemName());
                            out.println("</option>");
                        }
                    }
                %>
            </select>
        </td>
        <td class="td_top">
            <input type=text id='itemValue' name="itemValue" class="input" value='' dataType='' dict_num='' dict='yes'      code=''>
            <input id="selvalue" name='selvalue' type=button class=button_select onclick='BetchdoValue()'>
        </td>
        <td class="td_top" align="center">
            <input name="fromsave" id="fromsave" type="button" <%=disable%> class="button01" value='<%=LanguageSupport.getResource("RYGL-2115","保存")%>'      onclick="forsave()">
            <input name="Submit" type="button" class="button01" value='<%=LanguageSupport.getResource("RYGL-2116"," 关闭")%>' onclick="parent.close()">
        </td>
    </tr>
</table>
<br>
<jsp:include page="BatchUpdateList.jsp"></jsp:include>
</c:verbatim>

<script language=javascript>
    function selPost(idf, org) {
        obj = document.all(org);
        if (obj.value == null || obj.value == "") {
            alert("在选岗位时，部门不能为空");
            return;
        }
        var arg = parent.CSApp;
        fPopUpPostDlgByOrg(idf, obj.code, arg);
    }
    function selPostNo(idf) {
        var arg = parent.CSApp;
        fPopUpPostDlg(idf, arg);
    }
</script>
</h:form>
