<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.self.pojo.bo.SelfInfoModiBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doselect(){
            if (form1.all("form1:newselect").dataType=="6"){
              PopUpCodeDlgOneControl('form1:new');
            }
            else if (form1.all("form1:newselect").dataType=="5"){
              PopUpCalendarDialog('form1:new');
            }
            else if (form1.all("form1:newselect").dataType=="15"){
              PopUpCalendarDlg_OnlyMonth('form1:new');
            }
        }
        function beforeSave(){
            if(forsubmit(document.forms(0))){
                return true;
            }
            return false;
        }
        function changeField() {
            //debugger;
            var count = form1.all("form1:modifields").options.length;
            for(var i=0;i<count;i++){
                if (form1.all("form1:modifields").options[i].selected && i!=0){
                    // 格式=项目ID,数据类型,显示数值,数据库值,代码类
                    var values=form1.all("form1:modifields").options[i].value.split(",");
                    form1.all("form1:newselect").dataType=values[1];
                    if (values[1]=="6"){ // 代码字段
                        form1.all("form1:new").dict="yes";
                        form1.all("form1:new").dict_num=values[4];
                        form1.all("form1:new").readOnly=true;
                        form1.all("form1:newselect").enable=true;

                        form1.all("form1:old").dict="yes";
                        form1.all("form1:old").dict_num=values[4];
                        form1.all("form1:old").code=values[3];
                        form1.all("form1:old").value=values[2];
                    }
                    else if (values[1]=="5" || values[1]=="15"){
                        form1.all("form1:new").readOnly=true;
                        form1.all("form1:newselect").enable=true;
                        form1.all("form1:old").value=values[2];
                    }
                    else{
                        form1.all("form1:new").dict="";
                        form1.all("form1:new").dict_num="";
                        form1.all("form1:newselect").enable=false;

                        form1.all("form1:old").dict="";
                        form1.all("form1:old").dict_num="";
                        form1.all("form1:old").code="";
                        form1.all("form1:old").value=values[2];
                    }
                }
            }
            return false;
        }
    </script>

<x:saveState value="#{self_personEditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="init" value="#{self_personEditBB.beginBatchUpdate}"/>
    <c:verbatim>
    <table width=100% align="center" >
    <tr><td>
    </c:verbatim>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{self_personEditBB.SaveBatch}"
                             onclick="return beforeSave();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
     <c:verbatim>
     </td></tr>  
     <tr><td>
     <table width=95% align="center" class="table02">
        <tr>
            <td align="center" class='td_middle'><strong>项目</strong></td>
            <td align="center" class='td_middle'><strong>原值</strong></td>
            <td align="center" class='td_middle'><strong>新值</strong></td>
            <td align="center" class='td_middle'><strong>修改原因</strong></td>
        </tr>
        <%
            List modiList = (List) session.getAttribute("MODILIST");
            for (int i = 0; i < modiList.size(); i++) {
                SelfInfoModiBO selfmodi = (SelfInfoModiBO) modiList.get(i);
                InfoItemBO item = SysCacheTool.findInfoItem("",selfmodi.getFieldID());
                out.println("<tr>");
                if ("1".equals(item.getItemNotNull())){
                   out.println("<td class='td_middle'><font color='red'><strong>" + item.getItemName() + "*</strong></font></td>");
                }
                else{
                   out.println("<td class='td_middle'><strong>" + item.getItemName() + "</strong></td>");
                }
                if (InfoItemBO.DATA_TYPE_CODE.equals(item.getItemDataType())){
                    out.println("<td class='td_middle'>"+CodeUtil.interpertCode(selfmodi.getOldValue())+"</td>");
                    out.println("<td class='td_middle'><input name='"+item.getItemId()+"_new' id='"+item.getItemId()+"_new' type='text' readonly dict=\"yes\" code='' dict_num='"+item.getItemCodeSet()+"'><input type='button' class='button_select' onclick=\"PopUpCodeDlgOneControl('"+item.getItemId()+"_new')\"></td>");
                }
                else if (InfoItemBO.DATA_TYPE_DATE.equals(item.getItemDataType())){
                    out.println("<td class='td_middle'>"+selfmodi.getOldValue()+"</td>");
                    out.println("<td class='td_middle'><input name='"+item.getItemId()+"_new' id='"+item.getItemId()+"_new' type='text' readonly dict=\"yes\" dict_num='"+item.getItemCodeSet()+"'><input type='button' class='button_date' onclick=\"PopUpCalendarDialog('"+item.getItemId()+"_new')\"></td>");
                }
                else if (InfoItemBO.DATA_TYPE_DATE6.equals(item.getItemDataType())){
                    out.println("<td class='td_middle'>"+selfmodi.getOldValue()+"</td>");
                    out.println("<td class='td_middle'><input name='"+item.getItemId()+"_new' id='"+item.getItemId()+"_new' type='text' readonly dict=\"yes\" dict_num='"+item.getItemCodeSet()+"'><input type='button' class='button_date' onclick=\"PopUpCalendarDlg_OnlyMonth('"+item.getItemId()+"_new')\"></td>");
                }
                else if (InfoItemBO.DATA_TYPE_ORG.equals(item.getItemDataType())){
                    out.println("<td class='td_middle'>"+CodeUtil.interpertCode(CodeUtil.TYPE_ORG, selfmodi.getOldValue())+"</td>");
                    out.println("<td class='td_middle'><input name='"+item.getItemId()+"_new' id='"+item.getItemId()+"_new' type='text' dict=\"yes\" dict_num='OU' code='"+selfmodi.getOldValue()+"' value='' readonly>"+
                    	"<input type=\"button\" class=\"button_select\" onclick=\"PopUpOrgDlg('" + item.getItemId()+"_new" + "',1,'')\"></td>");
                }
                else{
                    out.println("<td class='td_middle'>"+selfmodi.getOldValue()+"</td>");
                    out.println("<td class='td_middle'><input type='text' name='"+item.getItemId()+"_new' id='"+item.getItemId()+"_new'></td>");
                }

                out.println("<td class='td_middle'><input type='text' name='"+item.getItemId()+"_Reason' id='"+item.getItemId()+"_Reason'></td>");
                out.println("</tr>");
            }
        %>
    </table>
    </td></tr>
    </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
