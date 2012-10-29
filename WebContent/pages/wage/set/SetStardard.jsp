<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript">
        function checkInput(){
            //debugger;
            if (document.all('data')==undefined){
                alert("没有要保存的数据！");
                return false;
            }
            return forsubmit(document.forms(0));
        }
        function DoSelectAll(isSelect){
            var size = document.all('form1:inputField').length;
            for (var i = 0; i < size; i++) {
                document.all('form1:inputField')[i].checked=isSelect;
            }
        }
        function forInput(){
            if (document.all('form1:inputField').value==""){
                alert("请选择项目！");
                return false;
            }
            return true;
        }
       function viewStandard(){
           if (document.all('form1:inputField').value.indexOf(",")>0){
               var list=document.all('form1:inputField').value.split(",");
               window.showModalDialog("/wage/base/StandardEditValueDlg.jsf?StandardID=" + list[1], null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
           }
           return false;
       }
       function selectCode(obj){
           //debugger;
           PopUpCodeDlgOneControl(obj);
       }
    </script>

<x:saveState value="#{wage_setStandardBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setStandardBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_setStandardBB.setId}"/>
    <h:inputHidden id="unitId" value="#{wage_setStandardBB.unitId}"/>
    <h:inputHidden id="setName" value="#{wage_setStandardBB.setName}"/>
    <h:inputHidden id="unitName" value="#{wage_setStandardBB.unitName}"/>
    <h:inputHidden id="isTry" value="#{wage_setStandardBB.isTry}"/>
<c:verbatim>
    <table width="98%"  align="center" >
        <tr>
           <td colspan=2>
</c:verbatim>
               <h:outputText value="发薪单位:#{wage_setStandardBB.unitName}"/>
               <h:outputText value="        "></h:outputText>
               <h:outputText value="账套名称:#{wage_setStandardBB.setName}"/>
<c:verbatim>
           </td>
        </tr>

        <tr>
        <td width=50%>
</c:verbatim>
            <h:outputText value="选择标准项："/>
            <h:selectOneMenu value="#{wage_setStandardBB.inputField}"  style="width:150px" id="inputField">
                <c:selectItems value="#{wage_setStandardBB.inputList}"/>
            </h:selectOneMenu>
            <h:commandButton value="开始修改" styleClass="button01" action="#{wage_setStandardBB.beginInput}" onclick="return forInput();"></h:commandButton>
<c:verbatim>
        </td>
        <td >
</c:verbatim>
            <h:commandButton value="查看标准定义" styleClass="button01" type="button" onclick="return viewStandard();"></h:commandButton>
            <h:panelGroup>
                <h:selectBooleanCheckbox value="#{wage_setStandardBB.executeCalc}"></h:selectBooleanCheckbox>
                <h:outputText value="保存后计算结果"></h:outputText>
            </h:panelGroup>
            <h:commandButton styleClass="button01" value="保存" action="#{wage_setStandardBB.saveAddPersonInput}"
                             onclick="return checkInput();"/>
            <h:commandButton styleClass="button01" type="button" value="关闭" onclick="window.close()"/>
<c:verbatim>
        </td>
        </tr>
    </table>
    <br>
    <br>
    <br>
    <table id='data' width="98%" align="center" class='table03' border=0 cellpadding=0 cellspacing=0>
    <%
        String[] persId = (String[]) session.getAttribute("persId");
        String[] field = (String[]) session.getAttribute("field");
        Hashtable rs = (Hashtable) session.getAttribute("RfileValue");
        Hashtable hrs = (Hashtable) session.getAttribute("HfileValue");
        Hashtable vrs = (Hashtable) session.getAttribute("VfileValue");
        InfoItemBO rf = null;
        InfoItemBO hf = null;
        InfoItemBO vf = null;
        if (field != null) {
            rf = SysCacheTool.findInfoItem("", field[0]);
        }
        if (field != null && field.length >= 2) {
            vf = SysCacheTool.findInfoItem("", field[1]);
        }
        if (field != null && field.length >= 3) {
            hf = SysCacheTool.findInfoItem("", field[2]);
        }

        if (persId != null && persId.length > 0 && field != null && field.length >= 2) {
            out.println("<tr>");
            out.println("<td class=td_form01 >员工编号</td>");
            out.println("<td class=td_form01  >姓名</td>");
            out.println("<td class=td_form01 >" + rf.getItemName() + "</td>");
            out.println("<td class=td_form01 >" + vf.getItemName() + "</td>");
            if (hf != null)
                out.println("<td  class=td_form01>" + hf.getItemName() + "</td>");
            out.println("</tr>");
            for (int j = 0; j < persId.length; j++) {
                out.println("<tr>");
                PersonBO pb = SysCacheTool.findPersonById(persId[j]);
                out.println("<td class=td_middle>" + pb.getPersonCode() + "</td>");
                out.println("<td class=td_middle>" + pb.getName() + "</td>");
                out.println("<td class=td_middle>" + rs.get(persId[j]).toString() + "</td>");

                out.println("<td class=td_middle>");
                if (vf!=null && InfoItemBO.DATA_TYPE_CODE.equals(vf.getItemDataType())) {
                    String codevalue=CodeUtil.interpertCode(vf.getItemCodeSet(),vrs.get(persId[j]).toString());
                    out.println("<input type='text' styleClass='input' name='" + persId[j]+vf.getItemId() + "' code='"+vrs.get(persId[j]).toString()+"' dict='yes' dict_num='" + vf.getItemCodeSet() + "'" +
                                 " readonly='true'  value='"+codevalue+"' />");
                    out.println("<input type = 'button'  class='button_select' onclick = \"selectCode('"+persId[j]+vf.getItemId()+"')\" >");
                }
                out.println("</td>");
                if (hf != null){
                    out.println("<td class=td_middle>");
                    String codevalue=CodeUtil.interpertCode(hf.getItemCodeSet(),hrs.get(persId[j]).toString());
                    out.println("<input type='text' styleClass='input' name='" + persId[j]+hf.getItemId() + "' code='"+hrs.get(persId[j]).toString()+"' dict='yes' dict_num='" + hf.getItemCodeSet() + "'" +
                                 " readonly='true'  value='"+codevalue+"' />");
                    out.println("<input type = 'button'  class='button_select' onclick = \"selectCode('"+persId[j]+hf.getItemId()+"')\" >");
                    out.println("</td>");
                }
                out.println("</tr>");
            }
        }
    %>
    </table>
</c:verbatim>
</h:form>
