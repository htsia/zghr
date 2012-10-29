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
                    if (obj.options[i].value == "D001001" || obj.options[i].value == "D001025") {
                        obj.options[i].selected = false;
                        continue;
                    } else {
                        obj.remove(i);
                    }
                }
            }
        }




        //ǰ����ָ�����˳�򲻿����ƶ�
        function forUpInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == 0 || i == 1 ||i==2) { //�����ƶ�ʱ �����ǰ����ָ������ǵ�����ָ�겻�ƶ�
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
            for (i = count-2; i > 1; i--) {   // �����ƶ�  ��� ǰ���� �����һ�������ƶ�
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
            <font color=red>�ϴ��ļ���ʽ˵���� </font><br>
            1. �ϴ�Ҫ������ļ���ѡ���ָ�꼯����Ҫ�ĵ��������ָ�꼯һ�£��Ұ��ļ��и����˳��ѡ��ϵͳ������鿴���������ִ�е��롣<br>
            2. �����ļ��ĸ�ʽΪCSV�ļ���
            3. ���ӱ��ĵ�һ��Ϊ�����У����ݴӵڶ��п�ʼ�����ӱ���ǰ���й̶�Ϊ������֯��š�����֯���ơ�<br>
            4. Ϊ��֤����׼ȷ���뽫���ӱ��������е����ݸ�ʽ����Ϊ�ı���ʽ��<br>
            5. ���������У����ܳ��ֿ��У���Ա����Ų���Ϊ��ֵ��<br>
            6. ����Ǵ������ô�����Ǵ���ֵ�����Ǵ������ơ�<br>
            7. �����6λ�����������ݣ����ݸ�ʽΪ6λ���֣���"200609",�����8λ�����������ݣ����ݸ�ʽΪ8λ���֣���"20060918"��<br>
         </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="3" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form02,td_form02">
        <h:outputText value="ѡ����Ҫ�ϴ���ָ�꼯"/>
        <h:selectOneMenu id="mType" onchange="submit()" value="#{ccp_DataUploadBB.orgSelSet}" valueChangeListener="#{ccp_DataUploadBB.selChanged}">
            <c:selectItems value="#{ccp_DataUploadBB.orgSetList}"/>
        </h:selectOneMenu>
    </h:panelGrid>
    <h:panelGrid width="95%" align="center" styleClass="table03">
        <h:outputText value="ѡ����Ҫ�ϴ���ָ����"/>
    </h:panelGrid>
    <h:panelGrid columns="4" align="center" width="95%"
                    styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:outputText value="��ѡ������"/>
        <h:outputText value=" "/>
        <h:outputText value="��ѡ������"/>
        <h:outputText value=" "/>
        <h:selectManyListbox size="15" style="width:200" id="preTreat">
            <c:selectItems value="#{ccp_DataUploadBB.orgSetItemList}"/>
        </h:selectManyListbox>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=rightBnt type=button class="button01"
                       onclick="forAddItem(form1.all('rsItem'),form1.all('form1:preTreat'))" value="����">
                <br>
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="removeInputItem()" value="����">
            </c:verbatim>
        </h:panelGroup>
        <c:verbatim>
            <select size="15" style="width:200" name="rsItem" multiple="true">
                <option value="D001025">����֯���(D001025)</option>
                <option value="D001001">����֯����(D001001)</option>
            </select>
        </c:verbatim>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value="����">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value="����">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="2" align="center" width="95%" styleClass="table03" columnClasses="td_form01,td_form02">
        <h:outputText value="�ϴ�����excel�ļ�:"/>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{ccp_DataUploadBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="�ϴ�" action="#{ccp_DataUploadBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>

</h:form>