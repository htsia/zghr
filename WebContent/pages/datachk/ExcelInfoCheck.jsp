<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
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
                        continue;
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
                        continue;
                    }
                }
            }
            return;
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
            return;
        }
    </script>

<x:saveState value="#{chk_DataCheckBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 数据对比"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
           <font color=red>文件格式说明： </font><br>
           1. 对比文件的格式为CSV文件<br>
           2. 选择的指标集和需要的对比的数据指标集一致，且按文件中各项的顺序选择数据项<br>
           3. 电子表格的第一行为标题行，数据从第二行开始，电子表格的前两列固定为：身份证号、姓名.<br>
           4. 电子表格的所有列的数据格式设置为文本格式。<br>
           6. 如果是代码项，那么必须是代码值而不是代码名称。<br>
           7. 如果是6位日期类型数据，数据格式为6位数字，如"200609",如果是8位日期类型数据，数据格式为8位数字，如"20060918"。<br>
         </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form01,td_form01">
        <h:panelGroup>
            <h:outputText value="选择需要对比的指标集"/>
            <h:selectOneMenu id="mType" onchange="submit()" value="#{chk_DataCheckBB.perSelSet}"
                             valueChangeListener="#{chk_DataCheckBB.selChanged}">
                <c:selectItems value="#{chk_DataCheckBB.perSetList}"/>
            </h:selectOneMenu>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="4" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:outputText value="备选项"/>
        <h:outputText value=" "/>

        <h:outputText value="已选项"/>
        <h:outputText value=" "/>

       <h:selectManyListbox size="15" style="width:250px" id="preTreat">
            <c:selectItems value="#{chk_DataCheckBB.perSetItemList}"/>
        </h:selectManyListbox>

        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=rightBnt type=button class="button01"
                       onclick="forAddItem(form1.all('rsItem'),form1.all('form1:preTreat'))" value=">>">
                <br>
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="removeInputItem()" value="<<">
            </c:verbatim>
        </h:panelGroup>

        <c:verbatim>
            <select size="15" style="width:250px" name="rsItem" multiple="true">
                <option value="A001735">身份证号</option>
                <option value="A001001">姓名</option>
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
        <h:outputText value="检查项目:"/>
        <h:selectManyCheckbox value="#{chk_DataCheckBB.items}">
            <c:selectItem itemLabel="已存在该数据" itemValue="0"></c:selectItem>
            <c:selectItem itemLabel="数据库不存在该人员" itemValue="1"></c:selectItem>
            <c:selectItem itemLabel="对比数据" itemValue="2"></c:selectItem>
        </h:selectManyCheckbox>

        <h:outputText value="上传excel文件:"/>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{chk_DataCheckBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="对比" action="#{chk_DataCheckBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>


</h:form>
