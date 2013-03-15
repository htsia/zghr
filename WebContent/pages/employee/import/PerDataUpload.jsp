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
    // �Ƴ�������Ŀ
    function removeAll(){
        var obj = form1.rsItem;
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
                    return true;
                }
            } else {
                alert("��ѡ��XLS�ļ���");
                return false;
            }
        }
        function removeInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = count - 1; i >= 0; i--) {
                if (obj.options[i].selected) {
                    if (obj.options[i].value == "A001735" || obj.options[i].value == "A001001" ) {
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
                    if (i == 0 || i == 1 ||i==2) {
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
            for (i = count-2; i > 1; i--) {   // ǰ���� ���һ�������ƶ�
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
        
    function checkAddSave(){
        document.all("form1:configID").value="";
        return checkSave();
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

    </script>

<x:saveState value="#{emp_DataUploadBB}"/>
<h:form id="form1" enctype="multipart/form-data">
<f:verbatim>
<table height=100% width=100% align="center">
<tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
</f:verbatim>
    <h:inputHidden value="#{emp_DataUploadBB.pageInit}"/>
    <h:inputHidden value="#{emp_DataUploadBB.moduleid}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
          <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-0318","��������")%>  
            </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
             <strong>�ϴ��ļ���ʽ˵���� </strong><br>
            1. �����ļ��ĸ�ʽΪXLS�ļ���<br>
            2. ���ӱ��ĵ�һ��Ϊ�����У����ݴӵڶ��п�ʼ��<br>
            3. ���ӱ��ĵ�һ�й̶�Ϊ��Ա�����,�����Ҳ���Ϊ�ա�<br>
            4. Ϊ��֤����׼ȷ���뽫���ӱ��������е����ݸ�ʽ����Ϊ�ı���ʽ��<br>
            5. ��ϵͳ����ѡ�����Ŀ�������ļ���׼������Ŀ������˳��һ�£�����ϵͳ����׼ȷ���롣<br>
        	6. �����ֶ������ָ�ʽ��������ʽ��������ʽ������ȷѡ��
        </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="2" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form01,td_form01">
        <h:panelGroup>
           <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-A002","ѡ����Ҫ�ϴ���ָ�꼯")%> 
           </f:verbatim>
            <h:selectOneMenu id="mType" onchange="submit()" value="#{emp_DataUploadBB.perSelSet}"
                             valueChangeListener="#{emp_DataUploadBB.selChanged}">
                <c:selectItems value="#{emp_DataUploadBB.perSetList}"/>
            </h:selectOneMenu>
        </h:panelGroup>
        <h:panelGroup>
            <h:selectOneRadio value="#{emp_DataUploadBB.codeType}">
                <c:selectItem itemValue="1" itemLabel="������ʽ"></c:selectItem>
                <c:selectItem itemValue="0" itemLabel="������ʽ"></c:selectItem>
            </h:selectOneRadio>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="4" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
         <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-A004","��ѡ������")%> 
           </f:verbatim>
        <h:outputText value=" "/>

        <h:panelGroup>
            <h:selectOneMenu id="importconfig" onchange="forselect();">
                <f:selectItems value="#{emp_DataUploadBB.selitem}"/>
            </h:selectOneMenu>
        </h:panelGroup>
        <h:outputText value=" "/>

        <h:selectManyListbox size="15" style="width:250px" id="preTreat">
            <c:selectItems value="#{emp_DataUploadBB.perSetItemList}"/>
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
                <option value="A001735"> <%=LanguageSupport.getResource("RYGL-2122","��Ա���")%> </option>
                <option value="A001001"> <%=LanguageSupport.getResource("RYGL-1016","����")%> </option>
            </select>
        </c:verbatim>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input name=upbnt type=button class="button01" onclick="forUpInputItem();" value="<%=LanguageSupport.getResource("RYGL-1017","����")%> ">
                <br>
                <br>
                <INPUT name=downbnt type=button class="button01" onclick="forDownInputItem();" value="<%=LanguageSupport.getResource("RYGL-1018","����")%> ">
            </c:verbatim>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="2" align="center" width="95%" styleClass="table03" columnClasses="td_form01,td_form02">
         <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2245","�ϴ�����excel�ļ�")%>:
           </f:verbatim>
        <h:panelGrid columns="3" cellspacing="3">
            <x:inputFileUpload id="excelFile" styleClass="input" value="#{emp_DataUploadBB.excelFile}" storage="file" size="40"/>
            <h:commandButton styleClass="button01" value="�ϴ�" action="#{emp_DataUploadBB.uploadFile}"
                             onclick="return checkSubmit();"/>
            <h:panelGroup>
                <f:verbatim>
                <%=LanguageSupport.getResource("RYGL-2248","��������")%>
                </f:verbatim>
                <h:inputText  id="configname" value="#{emp_DataUploadBB.configname}"/>
                <h:inputHidden  id="configID" value="#{emp_DataUploadBB.configID}"/>
                <h:commandButton value="����" styleClass="button01" onclick="return checkAddSave();" action="#{emp_DataUploadBB.saveconfig}"/>
                <h:commandButton value="����" styleClass="button01" onclick="return checkSave();" action="#{emp_DataUploadBB.saveconfig}"/>
                <h:commandButton value="ɾ��" styleClass="button01" onclick="return checkDelete();" action="#{emp_DataUploadBB.deleteconfig}"/>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>
    <f:verbatim>
		</div></td></tr></table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
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

