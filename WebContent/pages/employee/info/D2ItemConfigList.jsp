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
                 <h:commandButton value="增加数值区间" rendered="#{emp_d2AnaBB.numField}" styleClass="button01" onclick="doAddNumItem();"></h:commandButton>
                 <h:commandButton value="增加代码定义" rendered="#{!emp_d2AnaBB.numField}" styleClass="button01" onclick="doAddCodeItem();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{emp_d2AnaBB.allItems}"      id="setlist"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="100%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

              <h:column>
                  <f:facet name="header">
                       <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1157","顺序")%>
               </f:verbatim>
                  </f:facet>
                  <h:outputText value="#{briefList.seq}" ></h:outputText>
              </h:column>

				<h:column>
					<f:facet name="header">
					         <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1105","标题")%>
               </f:verbatim>
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </h:column>

                <h:column rendered="#{emp_d2AnaBB.numField}">
                    <f:facet name="header">
                         <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2294","数值低限")%>
               </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{briefList.lowValue}" ></h:outputText>
                </h:column>

              <h:column rendered="#{emp_d2AnaBB.numField}">
                  <f:facet name="header">
                          <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2295","数值高限")%>
               </f:verbatim>
                  </f:facet>
                  <h:outputText value="#{briefList.highValue}" ></h:outputText>
              </h:column>

              <h:column rendered="#{emp_d2AnaBB.numField==false}">
                  <f:facet name="header">
                    <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1272","关系符号")%>
               </f:verbatim>
                  </f:facet>
                  <h:selectOneRadio value="#{briefList.op}" readonly="true">
                      <c:selectItem itemValue="0" itemLabel="等于"></c:selectItem>
                      <c:selectItem itemValue="1" itemLabel="属于"></c:selectItem>
                      <c:selectItem itemValue="2" itemLabel="不等于"></c:selectItem>
                  </h:selectOneRadio>
              </h:column>

              <h:column rendered="#{emp_d2AnaBB.numField==false}">
                  <f:facet name="header">
               <f:verbatim>
                   <%=LanguageSupport.getResource("RYGL-2252","代码值")%>
               </f:verbatim>
                  </f:facet>
                  <h:outputText value="#{briefList.codeDes}" ></h:outputText>
              </h:column>


              <h:column>
                    <f:facet name="header">
                          <f:verbatim>
                   <%=LanguageSupport.getResource("YXGL-1026","操作")%>
               </f:verbatim>
                    </f:facet>
                      <h:commandButton styleClass="button01" value="删除" action="#{emp_d2AnaBB.DeleteDetail}">
                          <x:updateActionListener property="#{emp_d2AnaBB.detailID}" value="#{briefList.itemID}"/>
                      </h:commandButton>
                      <h:commandButton value="修改数值区间" rendered="#{emp_d2AnaBB.numField}" styleClass="button01" onclick="doModifyNumItem('#{briefList.itemID}');"></h:commandButton>
                      <h:commandButton value="修改代码定义" rendered="#{!emp_d2AnaBB.numField}" styleClass="button01" onclick="doModifyCodeItem('#{briefList.itemID}');"></h:commandButton>
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


