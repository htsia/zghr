<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@page import="com.hr319wg.custom.emp.pojo.bo.EmpQueryItemBO"%>
<%@page import="com.hr319wg.sys.pojo.vo.CellVO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>

<%@ include file="/pages/include/taglib.jsp" %>

<%
	CellVO[]tableItem=(CellVO[])session.getAttribute("tableItem");	
	List<EmpQueryItemBO> queryItemList=(List<EmpQueryItemBO>)session.getAttribute("queryItemList");
	EmpQueryItemBO queryItem=new EmpQueryItemBO();
	if(queryItemList!=null && queryItemList.size()==1){
		queryItem=queryItemList.get(0);
	}
%>
<script language="javascript">
function forSave(){
	var len=form1.showItem.options.length;
	if(len==0){
		alert("请选择显示项");
		return false;
	}
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

function insertOrderItem(type) {
	var options=form1.showItem.options;
	var index=options.selectedIndex;
	if(index!=-1){
		var itemId=options[index].value;
		var itemName=options[index].text;
	    for (var n = 0; n < form1.orderItem.options.length; n++) {
	        tmp = form1.orderItem.options[n];
	        if (tmp.value.indexOf(itemId)>-1 ) {
	            return;
	        }
	    }
	    tmp = document.createElement("option");
	    tmp.value = itemId+"-"+type;
	    if (0 == type)
	        tmp.text = itemName + "    升序";
	    else
	        tmp.text = itemName + "    降序";
	    form1.orderItem.add(tmp);
	}
}

function insertShowItem() {
	var showoptions=form1.showItem.options;
	var alloptions=form1.allItem.options;
	var index=alloptions.selectedIndex;
	var itemId=alloptions[index].value;
	var itemName=alloptions[index].text;
	
    for (var n = 0; n < showoptions.length; n++) {
        tmp = showoptions[n].value;
        if (tmp.indexOf(itemId) != -1) {
            return;
        }
    }

    tmp = document.createElement("option");
    tmp.value = itemId;
    tmp.text = itemName;
    form1.showItem.add(tmp);
}
</script>

<h:form id="form1">
<c:verbatim>
<table width="100%" border="0" style="margin:0;padding:0;" cellspacing="0" cellpadding="0">
    <tr>
        <td class="td_title"> <img src="/images/tips.gif" >设定显示项目 </td>
    </tr>
</table>
<table width="98%" height="100%" style="margin:0;padding:0;" border="0" align="center">
    <tr valign="top" height="300">
        <td width="230">
        	待选项目
            <select name="allItem" id="allItem" size="20" multiple style="width:100%;height:400px;" ondblclick="insertShowItem();">
            <%
            	if(tableItem!=null){
            		for(CellVO cell : tableItem){
            			if("ID".equals(cell.getItemId())){
            				continue;
            			}
            			%>
            			<option value="<%=cell.getItemId()%>"><%=cell.getItemName() %></option>
            			<%
            		}
            	}
            %>
            </select>            
        </td>
        <td align="center" valign="middle">
        <div>
            <input name="Submit22" type="button" style="width:80;" class="button01" value="删除指标" onclick="deleteItem(showItem)">
        </div>
            <div>
                <br>
                <input name="Submit24" type="button" style="width:80;" class="button01" value="&nbsp;&nbsp;上移&nbsp;&nbsp;" onclick="move(showItem,0)">
                <input name="Submit223" type="button" style="width:80;" class="button01" value="&nbsp;&nbsp;下移&nbsp;&nbsp;" onclick="move(showItem,1)">
            </div>
        </td>

        <td width="230" align="left" valign="top">
        	已选项目
            <select name="showItem" size="20" multiple id="showItem" style="width:100%;height:400px;">
            <%
            	if(queryItem.getShowItem()==null || "".equals(queryItem.getShowItem())){
            		if(tableItem!=null){
                		for(CellVO cell : tableItem){
                			if("ID".equals(cell.getItemId())){
                				continue;
                			}
                			%>
                			<option value="<%=cell.getItemId()%>"><%=cell.getItemName() %></option>
                			<%
                		}
                	}
            	}else{
            		String[]itemIDs=queryItem.getShowItem().split(",");
            		for(int i=0;i<itemIDs.length;i++){
            			InfoItemBO item=SysCacheTool.findInfoItem(itemIDs[i].substring(0, 4), itemIDs[i]);
            			if(item!=null){
            			%>
                		<option value="<%=itemIDs[i]%>"><%=item.getItemName() %></option>
            			<%
            			}
            		}
            	}
            %>
            </select>
        </td>

        <td width="0" align="center" valign="middle">
            <div>
                <input name="Submit3" type="button" class="button01" style="width:80;" value="升 序" onclick="insertOrderItem(0);">
                <input name="Submit23" type="button" class="button01" style="width:80;" value="降 序" onclick="insertOrderItem(1);">
                <br>
                <input name="Submit222" type="button" class="button01" style="width:80;" value="删 除" onclick="deleteItem(orderItem);">
            </div>

            <div><br>
                <input name="Submit242" type="button" class="button01" style="width:80;" value="上移" onclick="move(orderItem,0);">
                <input name="Submit2232" type="button" class="button01" style="width:80;" value="下移" onclick="move(orderItem,1);">
            </div></td>
        <td width="230" align="left" valign="top">
        	排序项目
            <select name="orderItem" id="orderItem" size="20" multiple style="width:100%;height:400px;">
            <%
            	if(queryItem.getOrderItem()!=null && !"".equals(queryItem.getOrderItem())){
            		String[]orderFlags=queryItem.getOrderItem().split(",");
            		for(int i=0;i<orderFlags.length;i++){
            			String order=orderFlags[i].substring(8, 9);
            			order="0".equals(order)?"升序":"降序";
            			InfoItemBO item=SysCacheTool.findInfoItem(orderFlags[i].substring(0, 4), orderFlags[i].substring(0, 7));
            			if(item!=null){
            			%>
                		<option value="<%=orderFlags[i]%>"><%=item.getItemName()+"    "+order %></option>
            			<%
            			}
            		}
            	}
            %>
            </select>
        </td>
    </tr>

    <tr valign="top">
        <td colspan="5" align="right">
</c:verbatim>
            <h:commandButton action="#{emp_personListBB2.saveItem}" value=" 保存 "
                             onclick="return forSave();" styleClass="button01" />
<c:verbatim>
            </span>
    </tr>
</table>

</c:verbatim>
</h:form>