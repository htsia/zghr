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
        <h:outputText value=" ���ݶԱ�"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
           <font color=red>�ļ���ʽ˵���� </font><br>
           1. �Ա��ļ��ĸ�ʽΪCSV�ļ�<br>
           2. ѡ���ָ�꼯����Ҫ�ĶԱȵ�����ָ�꼯һ�£��Ұ��ļ��и����˳��ѡ��������<br>
           3. ���ӱ��ĵ�һ��Ϊ�����У����ݴӵڶ��п�ʼ�����ӱ���ǰ���й̶�Ϊ�����֤�š�����.<br>
           4. ���ӱ��������е����ݸ�ʽ����Ϊ�ı���ʽ��<br>
           6. ����Ǵ������ô�����Ǵ���ֵ�����Ǵ������ơ�<br>
           7. �����6λ�����������ݣ����ݸ�ʽΪ6λ���֣���"200609",�����8λ�����������ݣ����ݸ�ʽΪ8λ���֣���"20060918"��<br>
         </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form01,td_form01">
        <h:panelGroup>
            <h:outputText value="ѡ����Ҫ�Աȵ�ָ�꼯"/>
            <h:selectOneMenu id="mType" onchange="submit()" value="#{chk_DataCheckBB.perSelSet}"
                             valueChangeListener="#{chk_DataCheckBB.selChanged}">
                <c:selectItems value="#{chk_DataCheckBB.perSetList}"/>
            </h:selectOneMenu>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="4" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:outputText value="��ѡ��"/>
        <h:outputText value=" "/>

        <h:outputText value="��ѡ��"/>
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
                <option value="A001735">���֤��</option>
                <option value="A001001">����</option>
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
        <h:outputText value="�����Ŀ:"/>
        <h:selectManyCheckbox value="#{chk_DataCheckBB.items}">
            <c:selectItem itemLabel="�Ѵ��ڸ�����" itemValue="0"></c:selectItem>
            <c:selectItem itemLabel="���ݿⲻ���ڸ���Ա" itemValue="1"></c:selectItem>
            <c:selectItem itemLabel="�Ա�����" itemValue="2"></c:selectItem>
        </h:selectManyCheckbox>

        <h:outputText value="�ϴ�excel�ļ�:"/>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{chk_DataCheckBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="�Ա�" action="#{chk_DataCheckBB.uploadFile}"
                             onclick="return checkSubmit();"/>
        </h:panelGrid>
    </h:panelGrid>


</h:form>
