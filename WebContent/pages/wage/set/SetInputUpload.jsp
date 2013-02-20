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
            if (filename.substr(filename.length - 3).toLowerCase() == 'xls') {
                if (obj.options.length < 3) {
                    alert("请选择输入项！")
                    return false;
                } else {
                    selectTotal(obj);
                    obj.options[0].selected = false;
                    obj.options[1].selected = false;
                    document.all("form1:disp").style.display="block";
                    return true;
                }
            } else {
                alert("请选择xls文件！");
                return false;
            }
        }
        function checkSave() {
            if (document.all("form1:configname").value==""){
                alert("请录入配置名称！")
                return false;
            }
            var obj = form1.rsItem;
            if (obj.options.length < 3) {
                alert("请选择输入项！")
                return false;
            } else {
                selectTotal(obj);
                obj.options[0].selected = false;
                obj.options[1].selected = false;
                document.all("form1:disp").style.display="block";
                return true;
            }
        }
        function checkDelete(){
            if (document.all("form1:configname").value==""){
                alert("请录入配置名称！")
                return false;
            }
            return true; 
        }
        // 移出所有项目
        function removeAll(){
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = count - 1; i >= 0; i--) {
                 obj.remove(i);
            }
        }
        function removeInputItem() {
            var obj = form1.rsItem;
            //all("form1:inputField");
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
            //all("form1:inputField");
            var count = obj.options.length;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == 0 || i == 1) {
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    if (i - 1 > 1) {
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
                    break;
                }
            }
            return;
        }
     function forselect(){
         removeAll();
         var fl=document.all("form1:importconfig").value.split("|");
         for(var i=0;i<fl.length;i++){
             var va=fl[i].split(",");
             addOptionItem(form1.all('rsItem'), va[0], va[1]);
             if (i==0){
                 if (va[0]=="A001999"){
                    document.all("form1:useold").checked=true;
                 }
//                  else if (va[0]=="A001735"){
//                      document.all("form1:useold").checked=false;
//                  }
             }
         }
         document.all("form1:configname").value=document.all("form1:importconfig").options(document.all("form1:importconfig").selectedIndex).text;
     }
     function doSetUseOld(){
         if (document.all("form1:useold").checked){
             form1.all('rsItem').options[0].value="A001999";
             form1.all('rsItem').options[0].text="旧系统员工编号";
         }
         else {
             form1.all('rsItem').options[0].value="A001735";
             form1.all('rsItem').options[0].text="员工编号";
         }
     }
        function doSetUseID(){
            if (document.all("form1:useid").checked){
                form1.all('rsItem').options[0].value="A001077";
                form1.all('rsItem').options[0].text="身份证";
                document.all("form1:useold").checked=false;
            }
            else {
                form1.all('rsItem').options[0].value="A001735";
                form1.all('rsItem').options[0].text="员工编号";
            }
        }

    </script>

<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{wage_setInputBB.pageInit}"/>
    <h:inputHidden value="#{wage_setInputBB.isTry}"/>
    <h:panelGrid width="95%" columns="2" align="center">
        <h:outputText escape="false" value="<strong>发薪单位:</strong>#{wage_setInputBB.unitName}"/>
        <h:outputText escape="false" value="<strong>账套名称:</strong>#{wage_setInputBB.setName}"/>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="1" align="center" width="95%"  styleClass="table03" columnClasses="td_middle">
        <h:panelGroup>
                <h:outputText value="上传xls文件:"/>
                <x:inputFileUpload id="excelFile" styleClass="input" value="#{wage_setInputBB.excelFile}" storage="file" size="40"/>
                <h:commandButton styleClass="button01" value="上传" action="#{wage_setInputBB.uploadFile}" onclick="return checkSubmit();"/>
                <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
                <h:outputText id="disp" escape="false" value="<font color=red>开始处理，请稍等....</font>" style="display:none"/>
        </h:panelGroup>

        <h:outputText escape="false">
            <c:verbatim escape="false">
                 <strong>上传文件格式说明： </strong><br>
                1. 导入文件的格式为XLS文件。<br>
                2. 电子表格的第一行为标题行，数据从第二行开始。<br>
                3. 电子表格的第一列固定为：员工编号,姓名且不能为空。<br>
                4. 为保证数据准确，请将电子表格的所有列的数据格式设置为文本格式。<br>
                5. 在系统中所选择的项目必须与文件中准备的项目个数、顺序一致，否则系统不能准确导入。<br>
            </c:verbatim>
        </h:outputText>
    </h:panelGrid>

    <h:panelGrid columns="4" align="center" width="95%"
                    styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:panelGroup>
           <h:outputText value="备选输入项"/>
           <h:selectBooleanCheckbox value="true" onclick="submit()"  valueChangeListener="#{wage_setInputBB.outputitem}" rendered="#{wage_setInputBB.showOnlyCheck}"/> <h:outputText value="仅选择录入项目" rendered="#{wage_setInputBB.showOnlyCheck}"></h:outputText>
        </h:panelGroup>
        <h:outputText value=""/>
        <h:panelGroup>
             <h:outputText value="已选输入项"/>
             <h:selectOneMenu id="importconfig" onchange="forselect()">
                 <f:selectItems value="#{wage_setInputBB.selitem}"/>
             </h:selectOneMenu>
             <h:selectBooleanCheckbox id="useold" value="false"  onclick="doSetUseOld()" rendered="false"/>
             <h:selectBooleanCheckbox id="useid" value="false"  onclick="doSetUseID()" rendered="false"/>
        </h:panelGroup>
        <h:outputText value=" "/>

        <h:selectManyListbox size="15" style="width:250px;height:400px" id="preTreat">
            <c:selectItems value="#{wage_setInputBB.inputList}"/>
        </h:selectManyListbox>

        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=rightBnt type=button class="button01"
                       onclick="forAddItem(form1.all('rsItem'),form1.all('form1:preTreat'))" value="->>">
                <br>
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="removeInputItem()" value="<<-">
            </c:verbatim>
        </h:panelGroup>

        <h:panelGrid columns="1" align="center">
          <c:verbatim>
            <select size="15" style="width:250;height:350" name="rsItem" multiple="true">
                <option value="A001735">员工编号</option>
                <option value="A001001">姓名</option>
            </select>
         </c:verbatim>
         <h:panelGroup>
             <h:outputText value="配置名称"></h:outputText>
             <h:inputText  id="configname" value="#{wage_setInputBB.configname}"/>
             <h:selectBooleanCheckbox id="ispublic" value="#{wage_setInputBB.isPublic}"/>
             <h:outputText value="公用配置"></h:outputText>
             <h:commandButton value="保存" styleClass="button01" onclick="return checkSave();" action="#{wage_setInputBB.saveconfig}"/>
             <h:commandButton value="删除" styleClass="button01" onclick="return checkDelete();" action="#{wage_setInputBB.deleteconfig}"/>
          </h:panelGroup>
        </h:panelGrid>

        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value="上移">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value="下移">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
