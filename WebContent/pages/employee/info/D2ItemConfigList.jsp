<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddNumItem(){
            window.showModalDialog("/employee/info/AddD2ItemDetail_Num.jsf?currentID="+document.all('form1:currentID').value, null, "dialogWidth:500px; dialogHeight:180px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
    }
    function doModifyNumItem(detailID){
            window.showModalDialog("/employee/info/AddD2ItemDetail_Num.jsf?detailID="+detailID, null, "dialogWidth:500px; dialogHeight:180px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
    }

    function doAddCodeItem(){
            window.showModalDialog("/employee/info/AddD2ItemDetail_Code.jsf?currentID="+document.all('form1:currentID').value, null, "dialogWidth:500px; dialogHeight:220px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
    }
    function doModifyCodeItem(detailID){
            window.showModalDialog("/employee/info/AddD2ItemDetail_Code.jsf?detailID="+detailID, null, "dialogWidth:500px; dialogHeight:220px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
    }

</script>

<x:saveState value="#{emp_d2AnaBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{emp_d2AnaBB.initList}"></h:inputHidden>
      <h:inputHidden id="currentID" value="#{emp_d2AnaBB.currentID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="2" align="right">
                 <h:commandButton value="������ֵ����" rendered="#{emp_d2AnaBB.numField}" styleClass="button01" onclick="doAddNumItem();"></h:commandButton>
                 <h:commandButton value="���Ӵ��붨��" rendered="#{!emp_d2AnaBB.numField}" styleClass="button01" onclick="doAddCodeItem();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{emp_d2AnaBB.allItems}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

              <h:column>
                  <f:facet name="header">
                       <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1157","˳��")%>
               </f:verbatim>
                  </f:facet>
                  <h:outputText value="#{briefList.seq}" ></h:outputText>
              </h:column>

				<h:column>
					<f:facet name="header">
					         <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1105","����")%>
               </f:verbatim>
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </h:column>

                <h:column rendered="#{emp_d2AnaBB.numField}">
                    <f:facet name="header">
                         <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2294","��ֵ����")%>
               </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{briefList.lowValue}" ></h:outputText>
                </h:column>

              <h:column rendered="#{emp_d2AnaBB.numField}">
                  <f:facet name="header">
                          <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2295","��ֵ����")%>
               </f:verbatim>
                  </f:facet>
                  <h:outputText value="#{briefList.highValue}" ></h:outputText>
              </h:column>

              <h:column rendered="#{emp_d2AnaBB.numField==false}">
                  <f:facet name="header">
                    <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1272","��ϵ����")%>
               </f:verbatim>
                  </f:facet>
                  <h:selectOneRadio value="#{briefList.op}" readonly="true">
                      <c:selectItem itemValue="0" itemLabel="����"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                      <c:selectItem itemValue="2" itemLabel="������"></c:selectItem>
                  </h:selectOneRadio>
              </h:column>

              <h:column rendered="#{emp_d2AnaBB.numField==false}">
                  <f:facet name="header">
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2252","����ֵ")%>
               </f:verbatim>
                  </f:facet>
                  <h:outputText value="#{briefList.codeDes}" ></h:outputText>
              </h:column>


              <h:column>
                    <f:facet name="header">
                          <f:verbatim>
                   <%=LanguageSupport.getResource("YXGL-1026","����")%>
               </f:verbatim>
                    </f:facet>
                      <h:commandButton styleClass="button01" value="ɾ��" action="#{emp_d2AnaBB.DeleteDetail}">
                          <x:updateActionListener property="#{emp_d2AnaBB.detailID}" value="#{briefList.itemID}"/>
                      </h:commandButton>
                      <h:commandButton value="�޸���ֵ����" rendered="#{emp_d2AnaBB.numField}" styleClass="button01" onclick="doModifyNumItem('#{briefList.itemID}');"></h:commandButton>
                      <h:commandButton value="�޸Ĵ��붨��" rendered="#{!emp_d2AnaBB.numField}" styleClass="button01" onclick="doModifyCodeItem('#{briefList.itemID}');"></h:commandButton>
                </h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
    <script type="text/javascript">
       setDataTableOver("form1:setlist");
    </script>
    </h:form>


