<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addPlace(){
             if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
                 alert("请选择机构!");
                 return false;
             }
             window.showModalDialog("/train/TrainPlaceEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:315px; dialogHeight:255px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/train/TrainPlaceEdit.jsf?placeuid="+id, "", "dialogWidth:315px; dialogHeight:255px; status:0;resizable:yes");
            return true;
        }
    </script>

<x:saveState value="#{train_placelistbb}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{train_placelistbb.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{train_placelistbb.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{train_placelistbb.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             
            <h:panelGroup>
                <h:outputText value="记录数:#{train_placelistbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{train_placelistbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{train_placelistbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{train_placelistbb.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{train_placelistbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{train_placelistbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{train_placelistbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{train_placelistbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addPlace();" styleClass="button01"></h:commandButton>
            </h:panelGroup>          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{train_placelistbb.placeList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="培训场所名称"/></c:facet>
            <h:outputText value="#{list.placeName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="培训场所地点"/></c:facet>
            <h:outputText value="#{list.placeLocate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="培训场所介绍"/></c:facet>
            <h:outputText value="#{list.placeMemo}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="应用范围"/></c:facet>
            <h:outputText value="#{list.placeOrg}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="编辑" styleClass="button01" onclick="return modify('#{list.placeID}')"></h:commandButton>
            <h:commandButton value="删除" styleClass="button01" onclick="return confirm('确定要删除吗?');" action="#{train_placelistbb.delete}">
                  <x:updateActionListener property="#{train_placelistbb.placeID}" value="#{list.placeID}"/>
            </h:commandButton>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
