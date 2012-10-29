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
            if (filename.substr(filename.length - 3).toLowerCase() == 'csv') {
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
                    if (obj.options[i].value == "D001001" || obj.options[i].value == "D001025") {
                        obj.options[i].selected = false;
                        continue;
                    } else {
                        obj.remove(i);
                    }
                }
            }
        }




        //前两个指标项的顺序不可以移动
        function forUpInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == 0 || i == 1 ||i==2) { //向上移动时 如果是前两个指标或者是第三个指标不移动
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    if (i - 1 > 1) {
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
            for (i = count-2; i > 1; i--) {   // 乡下移动  如果 前两个 和最后一个不用移动
                if (obj.options[i].selected) {
                    var op1 = document.createElement("Option");
                    op1.value = obj.options[i].value;
                    op1.text = obj.options[i].text;
                    obj.add(op1, i + 2);
                    obj.remove(i);
                    obj.options[i + 1].selected = true;
                }
            }
            return;
        }

    </script>

<x:saveState value="#{ccp_DataUploadBB}"/>
<h:form id="form1" enctype="multipart/form-data">
<h:inputHidden  value="#{ccp_DataUploadBB.pageInit}"></h:inputHidden>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
            <font color=red>上传文件格式说明： </font><br>
            1. 上传要导入的文件，选择的指标集和需要的导入的数据指标集一致，且按文件中各项的顺序选择系统数据项，查看数据无误后，执行导入。<br>
            2. 导入文件的格式为CSV文件。
            3. 电子表格的第一行为标题行，数据从第二行开始，电子表格的前二列固定为：党组织编号、党组织名称。<br>
            4. 为保证数据准确，请将电子表格的所有列的数据格式设置为文本格式。<br>
            5. 导入数据中，不能出现空行，且员工编号不能为空值。<br>
            6. 如果是代码项，那么必须是代码值而不是代码名称。<br>
            7. 如果是6位日期类型数据，数据格式为6位数字，如"200609",如果是8位日期类型数据，数据格式为8位数字，如"20060918"。<br>
         </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="3" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form02,td_form02">
        <h:outputText value="选择需要上传的指标集"/>
        <h:selectOneMenu id="mType" onchange="submit()" value="#{ccp_DataUploadBB.orgSelSet}" valueChangeListener="#{ccp_DataUploadBB.selChanged}">
            <c:selectItems value="#{ccp_DataUploadBB.orgSetList}"/>
        </h:selectOneMenu>
    </h:panelGrid>
    <h:panelGrid width="95%" align="center" styleClass="table03">
        <h:outputText value="选择需要上传的指标项"/>
    </h:panelGrid>
    <h:panelGrid columns="4" align="center" width="95%"
                    styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:outputText value="备选输入项"/>
        <h:outputText value=" "/>
        <h:outputText value="已选输入项"/>
        <h:outputText value=" "/>
        <h:selectManyListbox size="15" style="width:200" id="preTreat">
            <c:selectItems value="#{ccp_DataUploadBB.orgSetItemList}"/>
        </h:selectManyListbox>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=rightBnt type=button class="button01"
                       onclick="forAddItem(form1.all('rsItem'),form1.all('form1:preTreat'))" value="右移">
                <br>
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="removeInputItem()" value="左移">
            </c:verbatim>
        </h:panelGroup>
        <c:verbatim>
            <select size="15" style="width:200" name="rsItem" multiple="true">
                <option value="D001025">党组织编号(D001025)</option>
                <option value="D001001">党组织名称(D001001)</option>
            </select>
        </c:verbatim>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value="上移">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value="下移">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="95%" styleClass="table03" columnClasses="td_form01,td_form02">
        <h:outputText value="上传导入excel文件:"/>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{ccp_DataUploadBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="上传" action="#{ccp_DataUploadBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>

</h:form>