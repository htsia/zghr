<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function supplyItem(stoId){
  	  window.showModalDialog("/lain/StockAcceptItem.jsf?stoId="+stoId, "", "dialogWidth:600px; dialogHeight:600px; status:0;resizable:yes");
        return true;   
			}
    </script>

  <x:saveState value="#{lain_StockAcceptGatherBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{lain_StockAcceptGatherBB.pageInit}"/>
      <h:inputHidden id="str" value=""/>
     <f:verbatim>
      <table  width="100%" border="0" height="98%"   bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title" height=8>
                      <img src="/images/tips.gif" >物资入库汇总
              </td>
          </tr>

          <tr>
               <td  align="left" height=8>
     </f:verbatim>
                   <h:outputText value="开始时间"></h:outputText>
                   <h:inputText readonly="true" id="beginDate" value="#{lain_StockAcceptGatherBB.beginDate}"  alt="开始时间|0|d"></h:inputText>
                   <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:beginDate')"/>

                   <h:outputText value="结束时间"></h:outputText>
                   <h:inputText readonly="true" id="endDate" value="#{lain_StockAcceptGatherBB.endDate}" alt="结束时间|0|d"></h:inputText>
                   <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:endDate')"/>

                   <h:commandButton  styleClass="button01" value="查询" action="#{lain_StockAcceptGatherBB.queryByDate}" 
                                     onclick="return forsubmit(document.forms(0))"/>
       <f:verbatim>
               </td>
          </tr>

          <tr>
              <td  valign="top">
                 </f:verbatim>
                  <h:dataTable value="#{lain_StockAcceptGatherBB.stockAceptList}" var="list" align="center"    id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center, td_middle_left,td_middle_center,
                                                     td_middle_left,td_middle_left,td_middle_center"
                 styleClass="table03" width="92%"  ondblclick="return supplyItem() ;" >
        <h:column>
            <c:facet name="header"><h:outputText value="货品编号"/></c:facet>
            <h:outputText id="supId" value="#{list.stockId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="货品名称"/></c:facet>
            <h:outputText value="#{list.stockName}"/>
        </h:column>
         
          <h:column>
            <c:facet name="header"><h:outputText value="货品单位"/></c:facet>
            <h:outputText value="#{list.stockUnit}"/>
        </h:column>
        
		 <h:column>
            <c:facet name="header"><h:outputText value="入库总量"/></c:facet>
            <h:outputText value="#{list.drawCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="入库总额(￥)"/></c:facet>
            <h:outputText value="#{list.totalMany}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
             <h:commandLink value="明细查看" onclick="return supplyItem('#{list.stockId}');">
             </h:commandLink>
        </h:column>
    </h:dataTable>
                 <f:verbatim>
              </td>
          </tr>
      </table>
      </f:verbatim>
  </h:form>
  <script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
