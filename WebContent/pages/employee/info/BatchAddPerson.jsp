<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <c:verbatim>
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

        function removeInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = count - 1; i >= 0; i--) {
                if (obj.options[i].selected) {
                    if (obj.options[i].value == "A001735" ||
                        obj.options[i].value == "A001001" || 
                        obj.options[i].value == "A001705" ||
                        obj.options[i].value == "A001077" ||
                        obj.options[i].value == "A016010" ||
                        obj.options[i].value == "A016020" ) {
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
                    if (i<7) {
                        continue;
                    }
                    var op1 = document.createElement("Option");
                    if (i - 1 >= 7) {
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
                    if (i == count - 1 || i<7) {
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
            var obj = form1.rsItem;
            if (obj.options.length < 3) {
                alert("��ѡ�������")
                return false;
            } else {
                selectTotal(obj);
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
    </c:verbatim>

<x:saveState value="#{emp_DataAddBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ����������Ա"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
           <font color=red><%=LanguageSupport.getResource("RYGL-1006","�ļ���ʽ˵��")%>��</font><br>
           <%=LanguageSupport.getResource("RYGL-2240","1. �����ļ��ĸ�ʽΪCSV�ļ�(Excel��,ѡcsv��ʽ���Ϊ����)")%> <br>
           <%=LanguageSupport.getResource("RYGL-1008","2. ѡ���ָ�꼯����Ҫ�ĵ��������ָ�꼯һ�£��Ұ��ļ��и����˳��ѡ��������")%> <br>
           <%=LanguageSupport.getResource("RYGL-2272","3. ���ӱ��ĵ�һ��Ϊ�����У����ݴӵڶ��п�ʼ�����ӱ���ǰ���й̶�")%>  <br>
           <%=LanguageSupport.getResource("RYGL-1010","4. ���ӱ��������е����ݸ�ʽ����Ϊ�ı���ʽ��")%>  <br>
           <%=LanguageSupport.getResource("RYGL-1011","5. ����Ǵ������ô�����Ǵ���ֵ�����Ǵ������ơ�")%> <br>
           <%=LanguageSupport.getResource("RYGL-1012","6. �����6λ�����������ݣ����ݸ�ʽΪ6λ���֣���'200609',�����8λ�����������ݣ����ݸ�ʽΪ8λ���֣���'20060918'��")%>
           <br>
         </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>

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
            <select size="15" style="width:250px" name="rsItem" multiple="true">
                <option value="A001735">Ա�����</option>
                <option value="A001054">Ա�����</option>
                <option value="A001001">����</option>
                <option value="A001705">���ڲ���</option>
                <option value="A001077">���֤��</option>
                <option value="B730702"><%=CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"B730702")%></option>
                <option value="B730701"><%=CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"B730701")%></option>
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

     <script type="text/javascript">
        function checkSubmit() {
            var filename = form1.all("form1:excelFile").value;
            var obj = form1.rsItem;
            if (filename.substr(filename.length - 3) == 'csv') {
                selectTotal(obj);
                return true;
            } else {
                alert("��ѡ��CSV�ļ���");
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
</h:form>
