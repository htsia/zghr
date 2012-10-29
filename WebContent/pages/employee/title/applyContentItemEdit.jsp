<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
    <script type="text/javascript">
        function removeInputItem() {
            var obj = form1.rsItem;
            var count = obj.options.length;
            for (i = count - 1; i >= 0; i--) {
                if (obj.options[i].selected) {
                      obj.remove(i);
                }
            }
        }
        function checkSave() {
            var valuetype=document.all("form1:valueType").value;
            var obj = form1.rsItem;
            var obj1=document.all("form1:filterValue");
            if(valuetype=="1"){
	            if (obj.options.length ==0) {
	                alert("请选择输入项！");
	                return false;
	            } else {
	            	if (obj1.value != "" && obj1.code != "" && obj1.dict == "yes") {
	                    obj1.value = obj1.code;
	                }
	                selectTotal(obj);
	                return true;
	            }
            }
        }
    </script>

<x:saveState value="#{titleContentSetBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{titleContentSetBB.initItemEdit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 职称评审内容设置"/>
        </h:panelGroup>
    </h:panelGrid>
    <c:verbatim escape="false"><br></c:verbatim>
    <h:panelGrid width="95%" columns="2" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form01,td_form01,td_form01">
            
        	
            <h:panelGroup>
            <h:outputText value="选择指标集"/>
            <h:selectOneMenu id="mType" onchange="submit()" value="#{titleContentSetBB.setId}"
                             valueChangeListener="#{titleContentSetBB.selChanged}">
                <c:selectItems value="#{titleContentSetBB.setList}"/>
            </h:selectOneMenu>
           </h:panelGroup>
        	<h:commandButton value="保存"  action="#{titleContentSetBB.saveItem}" styleClass="button01"  onclick="return checkSave();"/>
    </h:panelGrid>
	<h:panelGrid width="95%" columns="4" align="center" styleClass="table03"
                 columnClasses="td_form01,td_form02,td_form01,td_form02">
               <h:outputText value="项目名称"/>
           	   <h:inputText value="#{titleContentSetBB.itembo.itemName}"></h:inputText>
               <h:outputText value="序号"></h:outputText>
               <h:inputText  id="seq" value="#{titleContentSetBB.itembo.seq}"></h:inputText>
               <h:outputText value="打分模型"></h:outputText>
               <h:selectOneMenu id="valueType" value="#{titleContentSetBB.itembo.valueType}">
               		<c:selectItem itemLabel="主观评断" itemValue="0"/>
               		<c:selectItem itemLabel="量化评断" itemValue="1"/>
               </h:selectOneMenu>
               <h:outputText value="打分高限"></h:outputText>
               <h:inputText  id="hiScore" value="#{titleContentSetBB.itembo.hiScore}"></h:inputText>
               <h:outputText value="打分低限"></h:outputText>
               <h:inputText  id="lowScore" value="#{titleContentSetBB.itembo.lowScore}"></h:inputText>
               <h:outputText value="描述"></h:outputText>
               <h:inputText  id="descrp" value="#{titleContentSetBB.itembo.descrp}"></h:inputText>
               <h:outputText value="编辑方式"></h:outputText>
               <h:selectOneMenu value="#{titleContentSetBB.itembo.allowEdit}">
               		<c:selectItem itemLabel="只读" itemValue="0"/>
               		<c:selectItem itemLabel="可编辑" itemValue="1"/>
               </h:selectOneMenu>
               <h:outputText value="过滤字段"></h:outputText>
               <h:selectOneMenu value="#{titleContentSetBB.itembo.filterField}">
               		<c:selectItems value="#{titleContentSetBB.fieldsList}"/>
               </h:selectOneMenu>
               <h:outputText value="过滤值"></h:outputText>
               <h:panelGroup>
               		<h:inputText styleClass="input" id="filterValue" code="" dict="yes" dict_num="0090"
                     readonly="true" value="#{titleContentSetBB.itembo.filterValue}"
                     alt="是否|1|s|50||"/>
                     <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCodeDlgOneControl('form1:filterValue')" />
               </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="4" align="center" width="95%"
                  styleClass="table03" columnClasses="td_middle,td_middle,td_middle,td_middle">
        <h:outputText value="备选项"/>
        <h:outputText value=" "/>
		<h:outputText value="选择项"/>
        <h:outputText value=" "/>

        <h:selectManyListbox size="15" style="width:250px" id="preTreat">
            <c:selectItems value="#{titleContentSetBB.setItemList}"/>
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
            </select>
        </c:verbatim>
        
        <h:outputText value=" "/>
        
        
    </h:panelGrid>
    	
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>