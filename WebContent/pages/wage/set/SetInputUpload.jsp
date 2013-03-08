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
                    alert("��ѡ�������")
                    return false;
                } else {
                    selectTotal(obj);
                    obj.options[0].selected = false;
                    obj.options[1].selected = false;
                    document.all("form1:disp").style.display="block";
                    return true;
                }
            } else {
                alert("��ѡ��xls�ļ���");
                return false;
            }
        }
        function checkSave() {
            if (document.all("form1:configname").value==""){
                alert("��¼���������ƣ�")
                return false;
            }
            var obj = form1.rsItem;
            if (obj.options.length < 3) {
                alert("��ѡ�������")
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
                alert("��¼���������ƣ�")
                return false;
            }
            return true; 
        }
        // �Ƴ�������Ŀ
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
             form1.all('rsItem').options[0].text="��ϵͳԱ�����";
         }
         else {
             form1.all('rsItem').options[0].value="A001735";
             form1.all('rsItem').options[0].text="Ա�����";
         }
     }
        function doSetUseID(){
            if (document.all("form1:useid").checked){
                form1.all('rsItem').options[0].value="A001077";
                form1.all('rsItem').options[0].text="���֤";
                document.all("form1:useold").checked=false;
            }
            else {
                form1.all('rsItem').options[0].value="A001735";
                form1.all('rsItem').options[0].text="Ա�����";
            }
        }

    </script>

<x:saveState value="#{wage_setInputBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{wage_setInputBB.pageInit}"/>
    <h:inputHidden value="#{wage_setInputBB.isTry}"/>
    <h:panelGrid width="95%" columns="2" align="center">
        <h:outputText escape="false" value="<strong>��н��λ:</strong>#{wage_setInputBB.unitName}"/>
        <h:outputText escape="false" value="<strong>��������:</strong>#{wage_setInputBB.setName}"/>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid columns="1" align="center" width="95%"  styleClass="table03" columnClasses="td_middle">
        <h:panelGroup>
                <h:outputText value="�ϴ�xls�ļ�:"/>
                <x:inputFileUpload id="excelFile" styleClass="input" value="#{wage_setInputBB.excelFile}" storage="file" size="40"/>
                <h:commandButton styleClass="button01" value="�ϴ�" action="#{wage_setInputBB.uploadFile}" onclick="return checkSubmit();"/>
                <h:commandButton styleClass="button01" type="button" value="ȡ��" onclick="window.close()"/>
                <h:outputText id="disp" escape="false" value="<font color=red>��ʼ�������Ե�....</font>" style="display:none"/>
        </h:panelGroup>

        <h:outputText escape="false">
            <c:verbatim escape="false">
                 <strong>�ϴ��ļ���ʽ˵���� </strong><br>
                1. �����ļ��ĸ�ʽΪXLS�ļ���<br>
                2. ���ӱ��ĵ�һ��Ϊ�����У����ݴӵڶ��п�ʼ��<br>
                3. ���ӱ��ĵ�һ�й̶�Ϊ��Ա�����,�����Ҳ���Ϊ�ա�<br>
                4. Ϊ��֤����׼ȷ���뽫���ӱ��������е����ݸ�ʽ����Ϊ�ı���ʽ��<br>
                5. ��ϵͳ����ѡ�����Ŀ�������ļ���׼������Ŀ������˳��һ�£�����ϵͳ����׼ȷ���롣<br>
            </c:verbatim>
        </h:outputText>
    </h:panelGrid>

    <h:panelGrid columns="4" align="center" width="95%"
                    styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:panelGroup>
           <h:outputText value="��ѡ������"/>
           <h:selectBooleanCheckbox value="true" onclick="submit()"  valueChangeListener="#{wage_setInputBB.outputitem}" rendered="#{wage_setInputBB.showOnlyCheck}"/> <h:outputText value="��ѡ��¼����Ŀ" rendered="#{wage_setInputBB.showOnlyCheck}"></h:outputText>
        </h:panelGroup>
        <h:outputText value=""/>
        <h:panelGroup>
             <h:outputText value="��ѡ������"/>
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
                <option value="A001735">Ա�����</option>
                <option value="A001001">����</option>
            </select>
         </c:verbatim>
         <h:panelGroup>
             <h:outputText value="��������"></h:outputText>
             <h:inputText  id="configname" value="#{wage_setInputBB.configname}"/>
             <h:selectBooleanCheckbox id="ispublic" value="#{wage_setInputBB.isPublic}"/>
             <h:outputText value="��������"></h:outputText>
             <h:commandButton value="����" styleClass="button01" onclick="return checkSave();" action="#{wage_setInputBB.saveconfig}"/>
             <h:commandButton value="ɾ��" styleClass="button01" onclick="return checkDelete();" action="#{wage_setInputBB.deleteconfig}"/>
          </h:panelGroup>
        </h:panelGrid>

        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value="����">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value="����">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
