<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function modify(id){
        window.showModalDialog("/wage/adjust/CommonWageItemEdit.jsf?adjustID="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }

  
</script>
<c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{empTitleChangeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{empTitleChangeBB.initWageItem}"></h:inputHidden>
    <h:inputHidden id="titleChangeId" value="#{empTitleChangeBB.titleChangeId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr>
                <td class=td_title height=8>
     </c:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 人员管理 -> 职称变动"/>
      				<c:verbatim>
               </td>
            </tr>
       <tr><td height=8 align="right"> 
        </tr>
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{empTitleChangeBB.wageItemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="指标项"/></c:facet>
            <h:outputText value="#{list.fieldID}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="指标名称"/></c:facet>
            <h:outputText value="#{list.fieldName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="原值"/></c:facet>
            <h:outputText value="#{list.oldValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="新值"/></c:facet>
            <h:outputText value="#{list.newValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="录入新值" onclick="return modify('#{list.adjustID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{empTitleChangeBB.deleteItem}" styleClass="button01">
                  <x:updateActionListener property="#{empTitleChangeBB.itemId}" value="#{list.adjustID}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>

	<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
