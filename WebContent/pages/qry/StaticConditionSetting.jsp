<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.qry.pojo.bo.QueryConditionBO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ page import="com.hr319wg.qry.pojo.vo.StaticVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../include/taglib.jsp" %>
<c:verbatim>
    <script type="text/javascript" language="javascript" src="/pages/qry/StaticConditionSetting.js"></script>
</c:verbatim>
<script type="text/javascript">
    function forSave() {
        rt = window.prompt("请输入查询名称", document.all('qryName').value);
        if (rt == "" || rt == null)
            return false;
        document.all("qryName").value = rt;
        //验证输入
        return toSubmit();
    }
    function check() {
        valuec = null;
        oper = null;
        itemId = null;
        if (document.all("itemId") != null) {
            if (document.all("itemId").length == undefined) {
                valuec = document.all("operValue");
                oper = document.all("operId");
                itemId = document.all("itemId");
                if(oper.value == "isnull" || oper.value == "notisnull" || oper.value == "allvalue"){
                    return true;
                }
                if ((valuec.value == "" || valuec.value == null) && (oper.value != "isnull" || oper.value != "notisnull" || oper.value != "allvalue")) {
                    alert("请输入查询条件");
                    return false;
                }
                if ((itemId.dict == "1" || itemId.dict == "2" || itemId.dict == "9") && isNaN(valuec.value)) {
                    alert("请输入数字");
                    valuec.focus();
                    return false;
                }
                if(itemId.dict == "5"){
                    if(dateCheck(valuec.value)== false){
                        alert("请输入正确日期");
                        valuec.focus();
                        return false;
                    }
                }
                if(itemId.dict == "15"){
                    if(dateCheck(valuec.value + "-01")== false){
                        alert("请输入正确日期");
                        valuec.focus();
                        return false;
                    }
                }
            } else {
                for (pos = 0; pos < document.all("itemId").length; pos++) {
                    valuec = document.all("operValue")[pos];
                    oper = document.all("operId")[pos];
                    itemId = document.all("itemId")[pos];
                    if(oper.value == "isnull" || oper.value == "notisnull" || oper.value == "allvalue"){
                        continue;
                    }

                    if ((valuec.value == "" || valuec.value == null) && (oper.value != "isnull" || oper.value != "notisnull" || oper.value != "allvalue")) {
                        alert("请输入查询条件");
                        return false;
                    }
                    if ((itemId.dict == "1" || itemId.dict == "2" || itemId.dict == "9") && isNaN(valuec.value)) {
                        alert("请输入数字");
                        valuec.focus();
                        return false;
                    }
                    if(itemId.dict == "5"){
                        if(dateCheck(valuec.value)== false){
                            alert("请输入正确日期");
                            valuec.focus();
                            return false;
                        }
                    }
                    if(itemId.dict == "15"){
                        if(dateCheck(valuec.value + "-01")== false){
                            alert("请输入正确日期");
                            valuec.focus();
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }
    var src1=null;
    function groupChange(src) {
        if (src.spanType == 'logic') {
        	src1=null;
            if (src.innerText == '与')
                src.innerText = '或';
            else
                src.innerText = '与';
        } else {
        	src1=src;
        	$("#setCond").show();
        	$("#condValue").val(src.innerText);
        }
    }
    function setCond(){
    	var tmp = tmp=$("#condValue").val();
        if (tmp == null)
            tmp = "";
        //过滤全角括号
        while (tmp != tmp.replace("（", "(")) {
            tmp = tmp.replace("（", "(");
        }
        while (tmp != tmp.replace("）", ")")) {
            tmp = tmp.replace("）", ")");
        }
        if (src1.spanType == "left_bracket") {
            while (tmp != tmp.replace(")", "")) {
                tmp = " " + tmp.replace(")", "");
            }
        }
        if (src1.spanType == "right_bracket") {
            while (tmp != tmp.replace("(", "")) {
                tmp = tmp.replace("(", "");
            }
        }
        src1.innerText = tmp;
        src1=null;
        $("#setCond").hide();
    }
    var node = null;
</script>
<h:form id="form1">
<h:inputHidden value="#{qry_staticSettingBB.staticConditionPageInit}"/>
<%
    String qsType = CommonFuns.filterNull(request.getParameter("qsType"));
    String setType = CommonFuns.filterNull(request.getParameter("setType"));
    String qryName = CommonFuns.filterNull(request.getParameter("qryName"));
    String sysFlag = CommonFuns.filterNull(request.getParameter("sysFlag"));
    String classId = CommonFuns.filterNull(request.getParameter("classId"));
    String qryId = CommonFuns.filterNull(request.getParameter("qryId"));
    String unitType = CommonFuns.filterNull(request.getParameter("unitType"));
    QueryVO queryvo = (QueryVO) session.getAttribute("QUERY_VO");
    qsType = (queryvo != null && queryvo.getQsType() != null ? queryvo.getQsType() : qsType);
    setType = (queryvo != null && queryvo.getSetType() != null ? queryvo.getSetType() : setType);
    qryName = (queryvo != null && queryvo.getName() != null ? queryvo.getName() : qryName);
    sysFlag = (queryvo != null && queryvo.getSysFlag() != null ? queryvo.getSysFlag() : sysFlag);
    classId = (queryvo != null && queryvo.getClassId() != null ? queryvo.getClassId() : classId);
    qryId = (queryvo != null && queryvo.getQryId() != null ? queryvo.getQryId() : qryId);
    unitType = (queryvo != null && queryvo.getUnitType() != null ? queryvo.getUnitType() : unitType);

    String staticId = "";
    String staticName= "";

    staticId = request.getParameter("staticId");
    if(staticId == null)
        staticId = (String) request.getAttribute("staticId");

%>

<c:verbatim>
<table width="100%" border="0" cellspacing="6" cellpadding="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">设定统计条件</td>
    </tr>
</table>

<table width="98%" height="33%" border="0" align="center">
    <tr valign="top">
        <td width="25%" rowspan="2">
            <iframe src="/pages/qry/InfoItemList.jsp?setType=<%=setType%>" style="width:100%;height:100%;"></iframe>
        </td>
        <td width="75%" align="left" valign="top">
            <table width="100%" border="0" align="left" cellpadding="5" cellspacing="1" class="td02">
            	<tr id="setCond" class="td_top" align=center style="display:none;">
                    <td width="65" height="25">输入括号</td>
                    <td align="left" valign="middle">
                    	<input id="condValue" value="" class="input" />
                    	<input type="button" onclick="setCond();" value="确定" class="button01"/>
                    </td>
                </tr>
                <tr class="td_top" align=center>
                    <td width="65"><strong>条件组合</strong></td>
                    <td align="left" id="groupField" valign="middle"></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top">
            <div style="height:350px; overflow-y:scroll;">
                <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" class="td02" id=PLList>
                    <tr class="td_top">
                        <td colspan="6" class="F08"><strong>设置查询条件</strong></td>
                    </tr>
                    <tr class="td_top" align="center">
                        <td width=10%><strong>编号</strong></td>
                        <td><strong>指标项名称</strong></td>
                        <td width=9%><strong>条件</strong></td>
                        <td width=26%><strong>关键字</strong></td>
                        <td width=15%><strong>操作</strong></td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="right">
</c:verbatim>
            <h:commandButton action="#{qry_staticSettingBB.doReturnList}" value="取消"styleClass="button01"/>
            <h:commandButton action="#{qry_staticSettingBB.doSaveStaticCondition}" value=" 确定 "
                             onclick="return toSubmit();" styleClass="button01"/>
<c:verbatim>
        </td>
    </tr>
</table>
    <input type="hidden" name="staticId" value="<%=CommonFuns.filterNull(staticId)%>">
    <input type="hidden" name="staticName" value="<%=CommonFuns.filterNull(staticName)%>">
    <input type="hidden" name="group" value="">
    <input type="hidden" name="groupShow" value="">
    <input type="hidden" name="qsType" value="<%=qsType%>">
    <input type="hidden" name="setType" value="<%=setType%>">
    <input type="hidden" name="classId" value="<%=classId%>">
    <input type="hidden" name="qryName" value="<%=qryName%>">
    <input type="hidden" name="sysFlag" value="<%=sysFlag%>">
    <input type="hidden" name="qryId" value="<%=qryId%>">
    <input type="hidden" name="unitType" value="<%=unitType%>">
    <input type="hidden" name="pop" value="<%=CommonFuns.filterNull(request.getParameter("pop"))%>">
    <input type="hidden" name="flag" value="condition">
    <input type="hidden" name="operFlag" value="<%=CommonFuns.filterNull(request.getParameter("flag"))%>">
</c:verbatim>
<script type="text/javascript">
    <%
      try{
            QueryVO qvo = (QueryVO) session.getAttribute("QUERY_VO");
            StaticVO vo = new StaticVO();

            for(int i=0;i<qvo.getStatics().length;i++){
                if(staticId.equalsIgnoreCase(qvo.getStatics()[i].getStatics().getStaticId())){
                    vo = qvo.getStatics()[i];
                    break;
                }
            }

            QueryConditionBO[] cbo = vo.getCondi();
            if(cbo != null && cbo.length >0){
                    for(int i=0;i<cbo.length;i++){
                        String itemId = cbo[i].getItemId();
                        if(itemId == null) continue;
                        InfoItemBO item = SysCacheTool.findInfoItem(itemId.substring(0,4),itemId);
                        out.println("insertConditionRow('" + cbo[i].getItemId() + "', '" + item.getItemName() + "','" + item.getItemDataType() + "','" + item.getItemCodeSet() + "','" + cbo[i].getOperator() + "','" + CommonFuns.filterNull(cbo[i].getValue()) + "','" + CommonFuns.filterNull(cbo[i].getText()) + "','" + CommonFuns.filterNull(cbo[i].getValue2()) + "','" + CommonFuns.filterNull(cbo[i].getText2()) + "');");
                    }
            }
            out.println("groupField.innerHTML = '" + CommonFuns.filterNull(vo.getStatics().getGroupShow()) + "';");
          }catch(Exception e){

         }
    %>
   </script>

</h:form>
