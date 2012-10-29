<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addSupply(){
             if (document.all("form1:orgId").value==null || document.all("form1:orgId").value==""){
                 alert("请选择机构!");
                 return false;
             }
             window.showModalDialog("/lain/LainStockEdit.jsf?orgId="+document.all("form1:orgId").value, "", "dialogWidth:315px; dialogHeight:415px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/lain/LainStockEdit.jsf?stockId="+id, "", "dialogWidth:315px; dialogHeight:415px; status:0;resizable:yes");
            return true;
        }
        function stockItem(id){
            window.showModalDialog("/lain/StockDrawItem.jsf?stockId="+id, "", "dialogWidth:600px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
    </script>

<x:saveState value="#{lain_StockBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{lain_StockBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="orgId" value="#{lain_StockBB.orgId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="100%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{lain_StockBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            
            <h:panelGroup>
                <h:outputText value="记录数:#{lain_StockBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{lain_StockBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{lain_StockBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{lain_StockBB.pagevo.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{lain_StockBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{lain_StockBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{lain_StockBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{lain_StockBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addSupply();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
	
    <h:dataTable value="#{lain_StockBB.stockList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center ,td_middle_center,td_middle_left,td_middle_center"
                 styleClass="table03" width="98%" id="dateList">
        <h:column>
            <c:facet name="header"><h:outputText value="物资名称"/></c:facet>
            <h:outputText value="#{list.stockName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="物资类别"/></c:facet>
            <h:outputText value="#{list.stockType}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="库存单位"/></c:facet>
            <h:outputText value="#{list.stockUnit}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="库存数量"/></c:facet>
            <h:outputText value="#{list.stockSum}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="编辑" onclick="return modify('#{list.stockId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{lain_EditStockBB.deleteStockBO}" styleClass="button01">
                  <x:updateActionListener property="#{lain_EditStockBB.stockBO.stockId}" value="#{list.stockId}"/>
            </h:commandButton>
             <h:commandButton value="物资明细" onclick="return stockItem('#{list.stockId}')" styleClass="button01"></h:commandButton>
        </h:column>
    </h:dataTable>
     <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
