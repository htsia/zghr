<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function additem(){
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
    	 document.all("form1:proIds").value = vars[1];
    }
  }
}
</script>

<x:saveState value="#{ReceriveProdouctMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="initProList" value="#{ReceriveProdouctMgrBB.initProList}"/>
    <h:inputHidden id="proIds"/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 数据交换平台 -> 订阅产品"/>
     <f:verbatim>
               </td>
               <td align="right" class=td_title >
               </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="left"> 
</f:verbatim>
				<h:outputText value="接收sql:" rendered="#{ReceriveProdouctMgrBB.showSql=='1'}"></h:outputText>
				<h:inputText value="#{ReceriveProdouctMgrBB.sql}" rendered="#{ReceriveProdouctMgrBB.showSql=='1'}"></h:inputText>
<f:verbatim>            	      
            </td>
            <td align="right">
</f:verbatim>

	            <h:selectOneMenu value="#{ReceriveProdouctMgrBB.method}" onchange="submit();" valueChangeListener="#{ReceriveProdouctMgrBB.changeMethod}">
	            	<c:selectItem itemLabel="通知消费者" itemValue="1"/>
	            	<c:selectItem itemLabel="EXCEL表" itemValue="2"/>
	            	<c:selectItem itemLabel="直接写入消费者库" itemValue="3"/>
	            </h:selectOneMenu>
	            <h:commandButton value="保存"  styleClass="button01" onclick="additem()" action="#{ReceriveProdouctMgrBB.saveReceive}"/>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{ReceriveProdouctMgrBB.proList}" var="list" align="center"  id="dateList" 
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            
           <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.proId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="产品名称"/></c:facet>
                <h:outputText value="#{list.proName}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="产品类型"/></c:facet>
                <h:outputText value="#{list.protype}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="通知消费者信息"/></c:facet>
                <h:outputText value="#{list.sendMsg}"/>
            </h:column>
        </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>