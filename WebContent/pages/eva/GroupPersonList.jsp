<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAdd(){
    	window.showModalDialog("/eva/addGoupPerson.jsf?groupId="+document.all("form1:groupId").value, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function selectPerson(){
    	var str=" |";
        chk=document.forms(0).selectItem;
        if (checkMutilSelect(chk)){
            var size = chk.length;
            if (size == null) {
                if (chk.checked) {
                    str+=chk.value;
                }
            } else {
                for (var i = 0; i < size; i++) {
                    if (chk[i].checked) {
                        if (i==0){
                            str+=chk[i].value;
                        }
                        else{
                            str+=","+chk[i].value;
                        }
                    }
                }
            }
           if(str != null && str!=""){
          	 var vars=str.split("|");
          	 document.all("form1:personStr").value = vars[1];
          	 
            }
        }
    }
</script>

<x:saveState value="#{evaauitGroupMgrBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{evaauitGroupMgrBB.initGroup}"></h:inputHidden>
      <h:inputHidden id="groupId" value="#{evaauitGroupMgrBB.groupId}"></h:inputHidden>
       <h:inputHidden id="personStr" value=""/>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF">
                <h:panelGroup>
       			<h:graphicImage value="/images/tips.gif" />
        		<h:outputText value=" 绩效管理 -> 评审团管理"/>
        </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid columns="1" align="right">
                 <h:panelGroup>
                 	 <h:commandButton value="增加" styleClass="button01" onclick="doAdd();"></h:commandButton>
                 	 <h:outputText value=" "></h:outputText>
	          		 <h:commandButton value="批量删除" styleClass="button01" onclick="selectPerson();" action="#{evaauitGroupMgrBB.deletePersons}"></h:commandButton>
	          		 <h:outputText value=" "></h:outputText>
	          		 <h:outputText value="姓名或简称："></h:outputText>
	          		 <h:inputText value="#{evaauitGroupMgrBB.queryValue}"></h:inputText>
	          		 <h:commandButton value="查询" styleClass="button01" action="#{evaauitGroupMgrBB.queryPerson}"></h:commandButton>
                 </h:panelGroup>
          </h:panelGrid>
          <x:dataTable value="#{evaauitGroupMgrBB.personList}" 
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
				 <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{briefList.itemId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="序号" />
					</f:facet>
                    <h:outputText value="#{index+1}" ></h:outputText>
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="姓名" />
					</f:facet>
                    <h:outputText value="#{briefList.personId}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="考核人员类别" />
					</f:facet>
                    <h:outputText value="#{briefList.masterType}" ></h:outputText>
                </h:column>
                <h:column rendered="#{evaauitGroupMgrBB.isPurview=='0'}">
					<f:facet name="header">
						<h:outputText value="权重(%)" />
					</f:facet>
                    <h:outputText value="#{briefList.purview}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
					<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{evaauitGroupMgrBB.deletePerson}" styleClass="button01">
                  		<x:updateActionListener property="#{evaauitGroupMgrBB.itemId}" value="#{briefList.itemId}"/>
            		</h:commandButton>
				</h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>


