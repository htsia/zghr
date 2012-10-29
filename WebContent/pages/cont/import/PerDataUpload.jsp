<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
    <script type="text/javascript">
        function checkSubmit() {
            var filename = form1.all("form1:excelFile").value;
            var obj = form1.rsItem;
            if (filename.substr(filename.length - 3) == 'csv') {
                if (obj.options.length < 3) {
                    alert("请选择输入项！")
                    return false;
                } else {
                    selectTotal(obj);
                    obj.options[0].selected = false;
                    obj.options[1].selected = false;
                    return true;
                }
            } else {
                alert("请选择CSV文件！");
                return false;
            }
        }
        function removeInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = count - 1; i >= 0; i--) {
                if (obj.options[i].selected) {
                    if (obj.options[i].value == "A001735" || obj.options[i].value == "A001001" || obj.options[i].value == "A001705") {
                        obj.options[i].selected = false;
                    } else {
                        obj.remove(i);
                    }
                }
            }
        }
        function forUpInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == 0 || i == 1 || i == 2) {
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    if (i - 1 > 2) {
                        op1.value = obj.options[i].value;
                        op1.text = obj.options[i].text;
                        obj.add(op1, i - 1);
                        obj.remove(i + 1);
                        obj.options[i - 1].selected = true;
                    }
                }
            }
        }
        function forDownInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == count - 1 || i == 0 || i == 1 || i == 2) {
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    op1.value = obj.options[i].value;
                    op1.text = obj.options[i].text;
                    obj.add(op1, i + 2);
                    obj.remove(i);
                    obj.options[i + 1].selected = true;
                }
            }
        }
        function doSetUseOld(){
            //debugger;
            if (document.all("form1:useold").checked){
                form1.all('rsItem').options[0].value="A001999";
                form1.all('rsItem').options[0].text="旧系统员工编号";
            }
            else {
                form1.all('rsItem').options[0].value="A001735";
                form1.all('rsItem').options[0].text="员工编号";
            }
        }
    </script>

<x:saveState value="#{cont_contNewSignBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 合同管理 ->  导入"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
           <font color=red>文件格式说明： </font><br>
           1. 导入文件的格式为CSV文件<br>
           2. 选择的指标集和需要的导入的数据指标集一致，且按文件中各项的顺序选择数据项<br>
           3. 电子表格的第一行为标题行，数据从第二行开始，电子表格的前两列固定为：员工编号、姓名.员工编号不能为空值<br>
           4. 电子表格的所有列的数据格式设置为文本格式。<br>
           6. 如果是代码项，那么必须是代码值而不是代码名称。<br>
           7. 如果是6位日期类型数据，数据格式为6位数字，如"200609",如果是8位日期类型数据，数据格式为8位数字，如"20060918"。<br>
         </c:verbatim>
        <h:panelGrid columns="2">
            <h:outputText value="上传导入excel文件:"/>
            <h:panelGroup>
                <h:selectOneRadio value="#{cont_contNewSignBB.codeType}">
                    <c:selectItem itemValue="0" itemLabel="代码形式"></c:selectItem>
                    <c:selectItem itemValue="1" itemLabel="描述形式"></c:selectItem>
                </h:selectOneRadio>
            </h:panelGroup>
        </h:panelGrid>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input"  value="#{cont_contNewSignBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="上传" action="#{cont_contNewSignBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="2" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:outputText value="备选输入项"/>
        <h:outputText value="操作 "/>

        <c:verbatim>
            <select size="15" style="width:250px" name="rsItem" multiple="true">
                <option value="A001735">员工编号</option>
                <option value="A001001">姓名</option>
                <option value="A708703">合同编号</option>
                <option value="A708701">合同期限类别</option>
                <option value="A708710">起始时间</option>
                <option value="A708715">终止时间</option>
            </select>
        </c:verbatim>

        <h:panelGroup>
            <h:selectBooleanCheckbox id="useold" value="false"  onclick="doSetUseOld()" /> <h:outputText value="使用旧系统编号"></h:outputText>
            <c:verbatim escape="false">
                <br>
                <br>
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value="上移">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value="下移">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>
</h:form>