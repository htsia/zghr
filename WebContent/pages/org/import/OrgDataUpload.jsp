<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
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
        function forUpInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == 0 || i == 1) {
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    if (i  > 2) {
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
                    if (i == count - 1 || i == 0 || i == 1) {
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

<x:saveState value="#{org_DataUploadBB}"/>
<h:inputHidden  value="#{org_DataUploadBB.pageInit}"></h:inputHidden>
<h:form id="form1" enctype="multipart/form-data">
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
            <font color=red>
               <%=LanguageSupport.getResource("JGGL-1126","上传文件格式说明：")%>
            </font><br>
             <%=LanguageSupport.getResource("JGGL-1127"," 1. 导入文件的格式为CSV文件。")%> <br>
             <%=LanguageSupport.getResource("JGGL-1128"," 2. 上传要导入的文件，选择的指标集和需要的导入的数据指标集一致，且按文件中各项的顺序选择系统数据项，查看数据无误后，执行导入。")%> <br>
             <%=LanguageSupport.getResource("JGGL-1129"," 3. 电子表格的第一行为标题行，数据从第二行开始，电子表格的前二列固定为：机构代码、机构名称。")%> <br>
             <%=LanguageSupport.getResource("JGGL-1130"," 4. 为保证数据准确，请将电子表格的所有列的数据格式设置为文本格式。")%> <br>
             <%=LanguageSupport.getResource("JGGL-1131"," 5. 导入数据中，不能出现空行，且机构代码不能为空值。")%> <br>
             <%=LanguageSupport.getResource("JGGL-1132"," 6. 如果是代码项，那么必须是代码值而不是代码名称。")%> <br>
             <%=LanguageSupport.getResource("JGGL-1133"," 7. 如果是6位日期类型数据，数据格式为6位数字，如'200609',如果是8位日期类型数据，数据格式为8位数字，如'20060918'。")%> <br>
         </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="3" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form02,td_form02">
         <f:verbatim>
           <%=LanguageSupport.getResource("RYGL-A002","选择需要上传的指标集")%> 
         </f:verbatim>
        <h:selectOneMenu id="mType" onchange="submit()" value="#{org_DataUploadBB.orgSelSet}" valueChangeListener="#{org_DataUploadBB.selChanged}">
            <c:selectItems value="#{org_DataUploadBB.orgSetList}"/>
        </h:selectOneMenu>
    </h:panelGrid>
    <h:panelGrid width="95%" align="center" styleClass="table03">
         <f:verbatim>
           <%=LanguageSupport.getResource("RYGL-A003","选择需要上传的指标项")%> 
         </f:verbatim>
    </h:panelGrid>
    <h:panelGrid columns="4" align="center" width="95%"
                    styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
          <f:verbatim>
           <%=LanguageSupport.getResource("RYGL-A004","备选输入项")%> 
         </f:verbatim>
        <h:outputText value=" "/>
          <f:verbatim>
           <%=LanguageSupport.getResource("RYGL-A005","已选输入项")%> 
         </f:verbatim>
        <h:outputText value=" "/>
        <h:selectManyListbox size="15" style="width:200" id="preTreat">
            <c:selectItems value="#{org_DataUploadBB.orgSetItemList}"/>
        </h:selectManyListbox>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=rightBnt type=button class="button01"
                       onclick="forAddItem(form1.all('rsItem'),form1.all('form1:preTreat'))" value="<%=LanguageSupport.getResource("BUTTON-011","右移")%> ">
                <br>
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="removeInputItem()" value="<%=LanguageSupport.getResource("BUTTON-012","左移")%> ">
            </c:verbatim>
        </h:panelGroup>
        <c:verbatim>
            <select size="15" style="width:200" name="rsItem" multiple="true">
                <option value="B001010">
                <%=LanguageSupport.getResource("JGGL-1001","机构代码")%> 
                </option>
                <option value="B001005">
                <%=LanguageSupport.getResource("JGGL-1002","机构名称")%> 
                </option>
            </select>
        </c:verbatim>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value="<%=LanguageSupport.getResource("RYGL-1017","上移")%>">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value="<%=LanguageSupport.getResource("RYGL-1018","下移")%>">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="95%" styleClass="table03" columnClasses="td_form01,td_form02">
        <f:verbatim>
         <%=LanguageSupport.getResource("RYGL-1021","上传导入excel文件:")%> 
        </f:verbatim>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{org_DataUploadBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="上传" action="#{org_DataUploadBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>

</h:form>