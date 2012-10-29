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
             window.showModalDialog("/lain/LainSupplyEdit.jsf?orgId="+document.all("form1:orgId").value, "", "dialogWidth:315px; dialogHeight:415px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/lain/LainSupplyEdit.jsf?supplyId="+id, "", "dialogWidth:315px; dialogHeight:415px; status:0;resizable:yes");
            return true;
        }
        function supplyStockItem(id){
            window.showModalDialog("/lain/SupplyStockItem.jsf?supplyId="+id, "", "dialogWidth:600px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
    </script>

<x:saveState value="#{lain_SupplyBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{lain_SupplyBB.initEdit}"></h:inputHidden>
    <h:inputHidden id="orgId" value="#{lain_SupplyBB.orgId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="100%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{lain_SupplyBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            
            <h:panelGroup>
                <h:outputText value="记录数:#{lain_SupplyBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{lain_SupplyBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{lain_SupplyBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{lain_SupplyBB.pagevo.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{lain_SupplyBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{lain_SupplyBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{lain_SupplyBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{lain_SupplyBB.last}" styleClass="button01"></h:commandButton>
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
    <h:dataTable value="#{lain_SupplyBB.supplyList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle,td_middle,td_middle,td_middle,td_middle"
                 styleClass="table03" width="98%" id="dateList">
        <h:column>
            <c:facet name="header"><h:outputText value="供应商名称"/></c:facet>
            <h:outputText value="#{list.supName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="机构范围"/></c:facet>
            <h:outputText value="#{list.orgScoppe}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="显示顺序"/></c:facet>
            <h:outputText value="#{list.showSeq}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="联系人"/></c:facet>
            <h:outputText value="#{list.contactPerson}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="联系电话"/></c:facet>
            <h:outputText value="#{list.contactTel}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="联系地址"/></c:facet>
            <h:outputText value="#{list.contactAdres}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="邮政编码"/></c:facet>
            <h:outputText value="#{list.postCode}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="网址"/></c:facet>
            <h:outputText value="#{list.webSite}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="eMail"/></c:facet>
            <h:outputText value="#{list.email}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="传真"/></c:facet>
            <h:outputText value="#{list.fax}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="编辑" onclick="return modify('#{list.supId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{lain_EditSupplyBB.deleteSupplyBO}" styleClass="button01">
                  <x:updateActionListener property="#{lain_EditSupplyBB.supplyBO.supId}" value="#{list.supId}"/>
            </h:commandButton>
             <h:commandButton value="供货明细" onclick="return supplyStockItem('#{list.supId}')" styleClass="button01"></h:commandButton>
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
