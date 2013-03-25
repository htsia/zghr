<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.qry.pojo.bo.QueryItemBO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO"%>

<%@ include file="../include/taglib.jsp" %>
<script language="javascript">
function fPopUpSet(codeField, nameField,setType) {
    if (codeField == null || nameField == null)
        return;
    if (codeField != "[object]")
        codeField = document.all(codeField);
    if (nameField != "[object]")
        nameField = document.all(nameField);
    showx = event.screenX - event.offsetX - 160//+ 25; // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    retval = window.showModalDialog("/pages/qry/InfoSetTree.jsp?setType="+setType, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");

    if (retval != null) {
        retval = retval.split("|");
        codeField.value = retval[0];
        nameField.value = retval[1];
        if(retval[0] == "" && retval[1] == ""){
            return false;
        }else{
             return true;
       }
    }else{
        return false;
    }
}
function forSave() {
	var qryName=document.getElementById("qryName").value;
	if(qryName==''){
		alert("请输入查询名称");
		return false;
	}
    return toSubmit();
}
function forQuery(){
    flag = toSubmit();
    if(flag)
        showProcessBar();
    return flag;
}
function showProcessBar() {
    x = document.body.clientWidth / 2 - 150;
    y = document.body.clientHeight / 2;
    document.all("showItem").style.visibility = "hidden";
    document.all('processbar').style.top = y;
    document.all('processbar').style.left = x;
    document.all('processbar').style.display = "";
}

function toSubmit(){
    for (i = 0; i < form1.showItem.options.length; i++) {
        form1.showItem.options[i].selected = true;
    }
    for (i = 0; i < form1.orderItem.options.length; i++) {
        form1.orderItem.options[i].selected = true;
    }
    return true;
}

//0-up; 1-down;
function move(obj, flag) {
    if (obj == null)
        return;
    if (flag == 0) {
        for (i = 0; i < obj.options.length; i++) {
            if (obj.options[i].selected) {
                if (i == 0) return;
                tmpvalue = obj.options[i].value;
                tmptext = obj.options[i].text;
                tmp = document.createElement("option");
                tmp.value = tmpvalue;
                tmp.text = tmptext;
                obj.add(tmp, i - 1);
                obj.remove(i + 1);
                tmp.selected = true;
            }
        }
    } else {
        for (i = obj.options.length - 1; i >= 0; i--) {
            if (obj.options[i].selected) {
                if (i == (obj.length - 1)) return;
                tmp = document.createElement("option");
                tmp.value = obj.options[i].value;
                tmp.text = obj.options[i].text;
                obj.add(tmp, i + 2);
                obj.remove(i);
                tmp.selected = true;
            }
        }
    }
}
function deleteItem(src) {
    if (src == null) return;
    for (i = 0; i < src.options.length; i++) {
        if (src.options[i].selected) {
            src.remove(i);
            i--;
        }
    }
}

function insertOrder(type) {
    for (i = 0; i < form1.showItem.options.length; i++) {
        if (form1.showItem.options[i].selected == true) {
            itemId = form1.showItem.options[i].value;
            if (itemId.indexOf("SHOWID") != -1)
                itemId = itemId.substr(6);
            insertOrderItem(itemId, form1.showItem.options[i].text, type);
        }
    }
}
function insertOrderItem(itemId, itemName, type) {
    for (n = 0; n < form1.orderItem.options.length; n++) {
        tmp = form1.orderItem.options[n];
        if (tmp.value.substr(2) == itemId) {
            //alert(itemName + " 已经存在");
            return;
        }
    }
    tmp = document.createElement("option");
    tmp.value = type + "-" + itemId;
    if (0 == type)
        tmp.text = itemName + "    升序";
    else
        tmp.text = itemName + "    降序";
    form1.orderItem.add(tmp);
}

var node = null;
function doSel(srcNode) {
    node = srcNode;
    insertShowItem(0,srcNode.getKey(),srcNode.label.innerText);
}

//0-showName;1-showId
function insertShowItem(flag) {
    if(node == null){
        alert("请选择指标");
        return ;
    }
    if(node.getKey().length != 7)
        return ;

    alt = node.alt;
    datatype= alt.split("|")[0];

    if(flag == '1' && datatype!="'6"){
        alert("只有代码类型的指标才可以显示编号")
        return;
    }

    itemId = node.getKey();
    itemName = node.label.innerText;
    //验证同一个infoitemId只能出现一次
    for (n = 0; n < form1.showItem.options.length; n++) {
        tmp = form1.showItem.options[n].value;
        if (tmp.indexOf(itemId) != -1) {
            alert(itemName + " 已经存在");
            return;
        }
    }

    tmp = document.createElement("option");
    if (flag == 0) {
        tmp.value = itemId;
        tmp.text = itemName;
    } else {
        tmp.value = "SHOWID" + itemId;
        tmp.text = itemName + "    代码";
    }
    form1.showItem.add(tmp);
}
//0-showName;1-showId
function initShowItem(flag, itemId, itemName) {
    //验证同一个infoitemId只能出现一次
    for (n = 0; n < form1.showItem.options.length; n++) {
        tmp = form1.showItem.options[n].value;
        if (tmp.indexOf(itemId) != -1) {
            alert(itemName + " 已经存在");
            return;
        }
    }

    tmp = document.createElement("option");
    if (flag == 0) {
        tmp.value = itemId;
        tmp.text = itemName;
    } else {
        tmp.value = "SHOWID" + itemId;
        tmp.text = itemName + "    代码";
    }
    form1.showItem.add(tmp);
}
</script>

<%
    String qsType = CommonFuns.filterNull(request.getParameter("qsType"));
    String setType = CommonFuns.filterNull(request.getParameter("setType"));
    String qryName = CommonFuns.filterNull(request.getParameter("qryName"));
    String sysFlag = CommonFuns.filterNull(request.getParameter("sysFlag"));
    String classId = CommonFuns.filterNull(request.getParameter("classId"));
    String qryId = CommonFuns.filterNull(request.getParameter("qryId"));
    String unitType = CommonFuns.filterNull(request.getParameter("unitType"));
    String historySet = CommonFuns.filterNull(request.getParameter("historySet"));
    String historySetName = CommonFuns.filterNull(request.getParameter("historySetName"));

    QueryVO queryvo = (QueryVO) session.getAttribute("QUERY_VO");
    qsType = (queryvo != null && queryvo.getQsType() != null ? queryvo.getQsType() : qsType);
    setType = (queryvo != null && queryvo.getSetType() != null ? queryvo.getSetType() : setType);
    qryName = (queryvo != null && queryvo.getName() != null ? queryvo.getName() : qryName);
    sysFlag = (queryvo != null && queryvo.getSysFlag() != null ? queryvo.getSysFlag() : sysFlag);
    classId = (queryvo != null && queryvo.getClassId() != null ? queryvo.getClassId() : classId);
    qryId = (queryvo != null && queryvo.getQryId() != null ? queryvo.getQryId() : qryId);
    unitType = (queryvo != null && queryvo.getUnitType() != null ? queryvo.getUnitType() : unitType);
    historySet = (queryvo != null && queryvo.getHistorySet() != null ? queryvo.getHistorySet() : historySet);
    if(historySet != null && !"".equals(historySet)){
        InfoSetBO bo = SysCacheTool.findInfoSet(historySet);
        if(bo != null){
             historySetName = bo.getSetName();
        }
    }

    String dialog = CommonFuns.filterNull(request.getParameter("dialog"));
    if("".equals(dialog))
        dialog = "111";
    String orgHidden = "none";
    String itemHidden = "none";
    String saveHidden = "";
    String conditionHidden = "none";
    if("1".equals(dialog.substring(0,1)))
        orgHidden = "";
    if("1".equals(dialog.substring(1,2)))
        conditionHidden="";
    if("1".equals(dialog.substring(2,3)))
        itemHidden = "";

    if("Y".equals(request.getParameter("hideSave")))
        saveHidden = "none";
%>

<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr>
    </table>
</marquee>
<h:form id="form1">
<h:inputHidden value="#{qry_querySettingBB.initVO}"/>
<c:verbatim>
<table width="100%" border="0" style="margin:0;padding:0;" cellspacing="0" cellpadding="0">
    <tr>
        <td class="td_title"> <img src="/images/tips.gif" >设定查询项目 </td>
    </tr>
</table>
<table width="98%" height="100%" style="margin:0;padding:0;" border="0" align="center">
     <tr height="1" valign="top">
     <td width="230">&nbsp;</td>
     <td align="center" valign="middle">&nbsp;</td>
     <td colspan="3">要查询历史记录的子集：<input type="text" id="historySetName" class="input" name="historySetName" value="<%=historySetName%>"> <input type="button" class="button_select" onclick="fPopUpSet('historySet','historySetName','<%=request.getParameter("setType")%>')"><input id="historySet" type="hidden" name="historySet" value="<%=historySet%>"></td>
    </tr>
    <tr valign="top" height="300">
        <td width="230">
            <iframe height="350" src="/pages/qry/InfoItemList.jsp?setType=<%=request.getParameter("setType")%>"
                    style="width:100%;height:350px;"></iframe>
        </td>
        <td align="center" valign="middle">
        <div>
            <input name="Submit" type="button" style="width:80;" class="button01" value="显示中文" onclick="insertShowItem(0)">
            <input name="Submit2" type="button" style="width:80;" class="button01" value="显示代码" onclick="insertShowItem(1)">
            <br><br>
            <input name="Submit22" type="button" style="width:80;" class="button01" value="删除指标" onclick="deleteItem(showItem)">
        </div>
            <div>
                <br>
                <input name="Submit24" type="button" style="width:80;" class="button01" value="&nbsp;&nbsp;上移&nbsp;&nbsp;" onclick="move(showItem,0)">
                <input name="Submit223" type="button" style="width:80;" class="button01" value="&nbsp;&nbsp;下移&nbsp;&nbsp;" onclick="move(showItem,1)">
            </div>
        </td>

        <td width="230" align="left" valign="top">
            <select name="showItem" size="28" multiple id="showItem" style="width:100%;height:350px;"></select>
        </td>

        <td width="0" align="center" valign="middle">
            <div>
                <input name="Submit3" type="button" class="button01" style="width:80;" value="升 序" onclick="insertOrder(0);">
                <input name="Submit23" type="button" class="button01" style="width:80;" value="降 序" onclick="insertOrder(1);">
                <br><br>
                <input name="Submit222" type="button" class="button01" style="width:80;" value="删 除" onclick="deleteItem(orderItem);">
            </div>

            <div><br>
                <input name="Submit242" type="button" class="button01" style="width:80;" value="上移" onclick="move(orderItem,0);">
                <input name="Submit2232" type="button" class="button01" style="width:80;" value="下移" onclick="move(orderItem,1);">
            </div></td>
        <td width="230" align="left" valign="top">
            <select name="orderItem" id="orderItem" size="28" multiple style="width:100%;height:350px;"></select>
        </td>
    </tr>

    <tr valign="top">
        <td colspan="5" align="right">
        	方案名称：<input id="qryName" name="qryName" value="<%=qryName%>" class="input" style="width: 200px;"/>
            <span style="display:<%=saveHidden%>">
            <input type="button" name="rest2" value="&nbsp;取消&nbsp;" class="button01" onclick="forBack();">
            </span>
            <span style="display:<%=conditionHidden%>">
</c:verbatim>
            <h:commandButton id="toCondition" action="#{qry_querySettingBB.toConditionPage}"
                             onclick="return toSubmit()" value=" 上一步:设置查询条件 "
                             styleClass="button01"/>
<c:verbatim>
            </span>
            <span style="display:<%=saveHidden%>">
</c:verbatim>
            <h:commandButton action="#{qry_querySettingBB.doSave}" value=" 保存 "
                             onclick="return forSave();" styleClass="button01" />
<c:verbatim>
            </span>
</c:verbatim>
            <h:commandButton action="#{qry_querySettingBB.doQuery}" value=" 查询 " id="doQuery" onclick="return forQuery();" styleClass="button01"/></td>
<c:verbatim>
    </tr>
</table>

<input type="hidden" name="qsType" value="<%=qsType%>">
<input type="hidden" name="setType" value="<%=setType%>">
<input type="hidden" name="classId" value="<%=classId%>">
<input type="hidden" name="qryName" value="<%=qryName%>">
<input type="hidden" name="sysFlag" value="<%=sysFlag%>">
<input type="hidden" name="qryId" value="<%=qryId%>">
<input type="hidden" name="unitType" value="<%=unitType%>">
<input type="hidden" name="pop" value="<%=CommonFuns.filterNull(request.getParameter("pop"))%>">
<input type="hidden" name="sessionKey" value="<%=CommonFuns.filterNull(request.getParameter("sessionKey"))%>">
<input type="hidden" name="dialog" value="<%=CommonFuns.filterNull(request.getParameter("dialog"))%>">
<input type="hidden" name="addedCondition" value="<%=CommonFuns.filterNull(request.getParameter("addedCondition"))%>">
<input type="hidden" name="queryFlag" value="<%=CommonFuns.filterNull(request.getParameter("queryFlag"))%>">
<input type="hidden" name="hideSave" value="<%=CommonFuns.filterNull(request.getParameter("hideSave"))%>">
<input type="hidden" name="pageFlag" value="<%=CommonFuns.filterNull(request.getParameter("pageFlag"))%>">
<input type="hidden" name="checkScale" value="<%=CommonFuns.filterNull(request.getParameter("checkScale"))%>">
<input type="hidden" name="operFlag" value="<%=CommonFuns.filterNull(request.getParameter("operFlag"))%>">
<input type="hidden" name="flag" value="item">
</c:verbatim>
</h:form>

<SCRIPT LANGUAGE="JavaScript">
    function forBack(){
        if("Y" == "<%=CommonFuns.filterNull(request.getParameter("pop"))%>"){
            window.returnValue = false;
            window.close();
        }else{
            <%
                 if ("QALEAD".equals(classId)){
                    out.println("location.href = '/qry/QueryIndex.jsf?classID="+classId+"&qsType="+qsType+"&setType="+setType+"&unitType="+unitType+"';");
                 }
                 else{
                    out.println("location.href = '/qry/QueryIndex.jsf?qsType="+qsType+"&setType="+setType+"&unitType="+unitType+"';");
                 }
             %>
        }
    }
        <%
        QueryVO vo = (QueryVO) session.getAttribute("QUERY_VO");
        if(vo != null){
            ArrayList list = new ArrayList();
            QueryItemBO[] bos = vo.getItem();
            if(bos != null && bos.length >0){
                for(int i=0;i<bos.length;i++){
                    list.add("");
                    InfoItemBO item = SysCacheTool.findInfoItem(bos[i].getItemId().substring(0,4),bos[i].getItemId());
                    String itemName = (item != null ? item.getItemName():"");
                    String str = "initShowItem('" + bos[i].getShowId() + "','" + bos[i].getItemId() + "','" + itemName + "');";
                    out.println(str);
                    if(bos[i].getOrderFlag() != null){
                        try{
                           list.add(bos[i].getOrderSeq(),bos[i]);
                        }
                        catch(Exception e){
                            System.out.print("error:"+item.getItemId());
                        }
                    }
                }
                for(int i=0;i<list.size();i++){
                    if(list.get(i) instanceof QueryItemBO){
                        QueryItemBO bo = (QueryItemBO) list.get(i);
                        InfoItemBO item = SysCacheTool.findInfoItem(bo.getItemId().substring(0,4),bo.getItemId());
                        if(item != null){
                            String str = "insertOrderItem('" + bo.getItemId() + "','" + item.getItemName() + "','" + bo.getOrderFlag() + "');";
                            out.println(str);
                        }
                    }
                }
            }
        }
        %>
</SCRIPT>
