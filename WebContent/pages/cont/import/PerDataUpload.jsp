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
                    alert("��ѡ�������")
                    return false;
                } else {
                    selectTotal(obj);
                    obj.options[0].selected = false;
                    obj.options[1].selected = false;
                    return true;
                }
            } else {
                alert("��ѡ��CSV�ļ���");
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
                form1.all('rsItem').options[0].text="��ϵͳԱ�����";
            }
            else {
                form1.all('rsItem').options[0].value="A001735";
                form1.all('rsItem').options[0].text="Ա�����";
            }
        }
    </script>

<x:saveState value="#{cont_contNewSignBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ��ͬ���� ->  ����"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
           <font color=red>�ļ���ʽ˵���� </font><br>
           1. �����ļ��ĸ�ʽΪCSV�ļ�<br>
           2. ѡ���ָ�꼯����Ҫ�ĵ��������ָ�꼯һ�£��Ұ��ļ��и����˳��ѡ��������<br>
           3. ���ӱ��ĵ�һ��Ϊ�����У����ݴӵڶ��п�ʼ�����ӱ���ǰ���й̶�Ϊ��Ա����š�����.Ա����Ų���Ϊ��ֵ<br>
           4. ���ӱ��������е����ݸ�ʽ����Ϊ�ı���ʽ��<br>
           6. ����Ǵ������ô�����Ǵ���ֵ�����Ǵ������ơ�<br>
           7. �����6λ�����������ݣ����ݸ�ʽΪ6λ���֣���"200609",�����8λ�����������ݣ����ݸ�ʽΪ8λ���֣���"20060918"��<br>
         </c:verbatim>
        <h:panelGrid columns="2">
            <h:outputText value="�ϴ�����excel�ļ�:"/>
            <h:panelGroup>
                <h:selectOneRadio value="#{cont_contNewSignBB.codeType}">
                    <c:selectItem itemValue="0" itemLabel="������ʽ"></c:selectItem>
                    <c:selectItem itemValue="1" itemLabel="������ʽ"></c:selectItem>
                </h:selectOneRadio>
            </h:panelGroup>
        </h:panelGrid>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input"  value="#{cont_contNewSignBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="�ϴ�" action="#{cont_contNewSignBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="2" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:outputText value="��ѡ������"/>
        <h:outputText value="���� "/>

        <c:verbatim>
            <select size="15" style="width:250px" name="rsItem" multiple="true">
                <option value="A001735">Ա�����</option>
                <option value="A001001">����</option>
                <option value="A708703">��ͬ���</option>
                <option value="A708701">��ͬ�������</option>
                <option value="A708710">��ʼʱ��</option>
                <option value="A708715">��ֹʱ��</option>
            </select>
        </c:verbatim>

        <h:panelGroup>
            <h:selectBooleanCheckbox id="useold" value="false"  onclick="doSetUseOld()" /> <h:outputText value="ʹ�þ�ϵͳ���"></h:outputText>
            <c:verbatim escape="false">
                <br>
                <br>
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value="����">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value="����">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>
</h:form>