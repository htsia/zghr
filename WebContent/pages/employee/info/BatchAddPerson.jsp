<%@page import="javax.faces.model.SelectItem"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
     <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
     <script type="text/javascript">
     // �Ƴ�������Ŀ
     function removeAll(){
         var obj = document.getElementById("rsItem");
         var count = obj.options.length;
         for (i = count - 1; i >= 0; i--) {
              obj.remove(i);
         }
     }
         
     function forselect(){
         if (document.all("form1:importconfig").selectedIndex>0){
             removeAll();
             var fl=document.all("form1:importconfig").value.split("|");
             document.all("form1:configID").value=fl[0];
             for(var i=1;i<fl.length;i++){
                 var va=fl[i].split(",");
                 addOptionItem(form1.all('rsItem'), va[0], va[1]);
             }
             document.all("form1:configname").value=document.all("form1:importconfig").options(document.all("form1:importconfig").selectedIndex).text;
         }
     }

        function removeInputItem() {
            var obj = document.getElementById("rsItem");
            var count = obj.options.length;
            var size = document.getElementById("form1:fieldSize").value;
            for (i = count - 1; i >= 0; i--) {
                if (obj.options[i].selected) {
                    if (obj.selectedIndex<size) {
                        obj.options[i].selected = false;
                        continue;
                    } else {
                        obj.remove(i);
                    }
                }
            }
        }
        function forUpInputItem() {
            var obj = document.getElementById("rsItem");
            var count = obj.options.length;
            var size = document.getElementById("form1:fieldSize").value;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i<size) {
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    if (i - 1 >= size) {
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
            var obj = document.getElementById("rsItem");
            var count = obj.options.length;
            var size = document.getElementById("form1:fieldSize").value;
            for (i = 0; i < count; i++) {
                if (obj.options[i].selected) {
                    if (i == count - 1 || i<size) {
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
        function checkAddSave(){
            document.all("form1:configID").value="";
            return checkSave();
        }
        function checkSave() {
            if (document.all("form1:configname").value==""){
                alert("��¼���������ƣ�")
                return false;
            }
            var obj = document.getElementById("rsItem");
            selectTotal(obj);
            return true;
        }
        function checkDelete(){
            if (document.all("form1:configname").value==""){
                alert("��¼���������ƣ�")
                return false;
            }
            return true;
        }
        function checkSubmit() {
            var filename = form1.all("form1:excelFile").value;
            var obj = document.getElementById("rsItem");
            if (filename.substr(filename.length - 3).toLowerCase() == 'xls') {
                selectTotal(obj);
                return true;
            } else {
                alert("��ѡ��XLS�ļ�");
                return false;
            }
        }

        if (document.all("form1:configname").value!=""){   // �㱣���ط�
            var importconfig=document.all("form1:importconfig");
            for (var j = 0; j < importconfig.options.length; j++) {
                if (importconfig.options[j].text==document.all("form1:configname").value) {
                    importconfig.selectedIndex=j;
                    forselect();
                    break;
                }
            }
        }
    </script>

<x:saveState value="#{emp_DataAddBB}"/>
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden value="#{emp_DataAddBB.pageInit}"/>
	<h:inputHidden id="fieldSize" value="#{emp_DataAddBB.fieldSize}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ����������Ա"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
             <strong>�ϴ��ļ���ʽ˵���� </strong><br>
            1. �����ļ��ĸ�ʽΪXLS�ļ���<br>
            2. ���ӱ��ĵ�һ��Ϊ�����У����ݴӵڶ��п�ʼ��<br>
            3. ���ӱ��ĵ�һ�й̶�Ϊ��Ա�����,�����Ҳ���Ϊ�ա�<br>
        	4. �����ֶ������ָ�ʽ��������ʽ��������ʽ������ȷѡ��<br>
            5. Ϊ��֤����׼ȷ���뽫���ӱ��������е����ݸ�ʽ����Ϊ�ı���ʽ��<br>
        	6. ���ڸ�ʽ�����Ϊ��λ���ڸ�ʽΪ��yyyy-MM,���Ϊ��λ��ʽΪ��yyyy-MM-dd��<br>
            7. ��ϵͳ����ѡ�����Ŀ�������ļ���׼������Ŀ������˳��һ�£�����ϵͳ����׼ȷ���롣
        </c:verbatim>
    </h:panelGrid>
    <h:panelGrid columns="4" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <f:verbatim>
        <%=LanguageSupport.getResource("RYGL-A004","��ѡ������")%>
        </f:verbatim>
        <h:outputText value=" "/>

        <h:panelGroup>
            <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-A005","��ѡ������")%>
            </f:verbatim>
            <h:selectOneMenu id="importconfig" onchange="forselect();">
                <f:selectItems value="#{emp_DataAddBB.selitem}"/>
            </h:selectOneMenu>
        </h:panelGroup>
        <h:outputText value=" "/>

        <h:selectManyListbox size="15" style="width:250px" id="preTreat">
            <c:selectItems value="#{emp_DataAddBB.perSetItemList}"/>
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
			<select size="15" style="width:250px" id="rsItem" name="rsItem" multiple="multiple">
				<%
					List<SelectItem> list =(List<SelectItem>)session.getAttribute("fieldList");
					for(SelectItem s : list){
						%>
						<option value="<%=s.getValue()%>" ><%=s.getLabel() %></option>
						<%
					}
				%>
			</select>
		</c:verbatim>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=upbnt type=button class="button01" onclick="forUpInputItem()" value=" <%=LanguageSupport.getResource("RYGL-1017","����")%>">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem()" value=" <%=LanguageSupport.getResource("RYGL-1018","����")%>">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="2" align="center" width="95%" styleClass="table03" columnClasses="td_form01,td_form02">
          <%=LanguageSupport.getResource("RYGL-2245","�ϴ�����excel�ļ�")%>��
        <h:panelGrid columns="5" cellspacing="3">
            <h:outputText value="�����ֶ�������ʽ"></h:outputText>
            <h:panelGroup>
                <h:selectOneRadio value="#{emp_DataAddBB.codeType}">
                    <c:selectItem itemValue="0" itemLabel="������ʽ"></c:selectItem>
                    <c:selectItem itemValue="1" itemLabel="������ʽ"></c:selectItem>
                </h:selectOneRadio>
            </h:panelGroup>
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{emp_DataAddBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="�ϴ�" action="#{emp_DataAddBB.uploadFile}" onclick="return checkSubmit();"/>

            <h:panelGroup>
                <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2248","��������")%>
                </f:verbatim>
                <h:inputText  id="configname" value="#{emp_DataAddBB.configname}"/>
                <h:inputHidden  id="configID" value="#{emp_DataAddBB.configID}"/>
                <h:commandButton value="����" styleClass="button01" onclick="return checkAddSave();" action="#{emp_DataAddBB.saveconfig}"/>
                <h:commandButton value="����" styleClass="button01" onclick="return checkSave();" action="#{emp_DataAddBB.saveconfig}"/>
                <h:commandButton value="ɾ��" styleClass="button01" onclick="return checkDelete();" action="#{emp_DataAddBB.deleteconfig}"/>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
