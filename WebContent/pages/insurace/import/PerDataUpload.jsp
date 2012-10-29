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
        function doSetUseOld(){
            if (document.all("form1:useold").checked){
                form1.all('rsItem').options[0].value="A001999";
                form1.all('rsItem').options[0].text="��ϵͳ��Ա���";
                document.all("form1:useid").checked=false;
            }
            else {
                form1.all('rsItem').options[0].value="A001735";
                form1.all('rsItem').options[0].text="��Ա���";
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
                form1.all('rsItem').options[0].text="��Ա���";
            }
        }

    </script>
	
<x:saveState value="#{emp_DataUploadBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{emp_DataUploadBB.pageInit}"/>
    <h:inputHidden value="#{emp_DataUploadBB.moduleid}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
          <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-0318","��������")%>  
            </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
     <c:verbatim><br></c:verbatim>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03" columnClasses="td_form01">
        <c:verbatim escape="false">
           <font color=red> <%=LanguageSupport.getResource("RYGL-1006","�ļ���ʽ˵��")%>  �� </font><br>
           <%=LanguageSupport.getResource("RYGL-2240","1. �����ļ��ĸ�ʽΪCSV�ļ�(Excel��,ѡcsv��ʽ���Ϊ����)")%> 
           <br>
           <%=LanguageSupport.getResource("RYGL-1008"," 2. ѡ���ָ�꼯����Ҫ�ĵ��������ָ�꼯һ�£��Ұ��ļ��и����˳��ѡ��������")%> 
          <br>
           <%=LanguageSupport.getResource("RYGL-2241"," 3. ���ӱ��ĵ�һ��Ϊ�����У����ݴӵڶ��п�ʼ�����ӱ���ǰ���й̶�Ϊ����Ա��š�����.��Ա��Ų���Ϊ��ֵ")%> 
          <br>
           <%=LanguageSupport.getResource("RYGL-1010"," 4. ���ӱ��������е����ݸ�ʽ����Ϊ�ı���ʽ")%> 
              <br>
           <%=LanguageSupport.getResource("RYGL-1011","  6. ����Ǵ������ô�����Ǵ���ֵ�����Ǵ������ơ�")%> 
         <br>
           <%=LanguageSupport.getResource("RYGL-1012", "7. �����6λ�����������ݣ����ݸ�ʽΪ6λ���֣���'200609',�����8λ�����������ݣ����ݸ�ʽΪ8λ���֣���'20060918'��")%> 
           <br>
         </c:verbatim>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="1" align="center" styleClass="table03"
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
    </h:panelGrid>

    <h:panelGrid columns="4" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
         <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-A004","��ѡ������")%> 
           </f:verbatim>
        <h:outputText value=" "/>

        <h:panelGroup>
            <h:selectBooleanCheckbox id="useold" value="false"  onclick="doSetUseOld()" /> 
            <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2244","ʹ�þ�ϵͳ���")%> 
           </f:verbatim>
            <h:selectBooleanCheckbox id="useid" value="false"  onclick="doSetUseID()" /> 
           <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2243","ʹ�����֤")%> 
           </f:verbatim>
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
        </h:panelGrid>
    </h:panelGrid>
</h:form>

<script type="text/javascript">
	    var ops=[];
		var setSel = document.getElementById("form1:mType");		
		for(var i=0;i<setSel.length;i++){
			var selValue = setSel.options[i].value;
			if(selValue.lastIndexOf("A754")!=-1 //Ա�����ջ������
				|| selValue.lastIndexOf("A755")!=-1 //�������ϱ��ղ����Ӽ�
			    || selValue.lastIndexOf("A760")!=-1 //����ҽ�Ʊ��ղ����Ӽ�
				|| selValue.lastIndexOf("A765")!=-1 //���˱��ղ����Ӽ�
				|| selValue.lastIndexOf("A775")!=-1 //�������ղ����Ӽ�
				|| selValue.lastIndexOf("A770")!=-1 //ʧҵ���ղ����Ӽ�
				|| selValue.lastIndexOf("A755")!=-1 //�������ϱ��ղ����Ӽ�
				|| selValue.lastIndexOf("A786")!=-1 //���ҽ�ƻ���
				|| selValue.lastIndexOf("A780")!=-1 //ס������������Ӽ�
				|| selValue.lastIndexOf("A755")!=-1 //�������ϱ��ղ����Ӽ�
				|| selValue.lastIndexOf("A785")!=-1 //��ҵ�������Ӽ�
				){
					ops.push(setSel.options[i]);
				}
		}		
		setSel.options.length=0;
		for(var i=0;i<ops.length;i++){
			setSel.options.add(ops[i]);
		}
	</script>