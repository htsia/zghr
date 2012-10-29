<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<script type="text/javascript">
        function audit(id){
            window.showModalDialog("/recruit/auditInnerPerson.jsf?detailId="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
    </script>
<x:saveState value="#{innerRecuResultBB}"></x:saveState>

<h:form id="form1">
    <h:inputHidden value="#{innerRecuResultBB.initResult}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{innerRecuResultBB.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{innerRecuResultBB.mypage2.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{innerRecuResultBB.mypage2.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{innerRecuResultBB.mypage2.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{innerRecuResultBB.mypage2.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{innerRecuResultBB.first2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{innerRecuResultBB.pre2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{innerRecuResultBB.next2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{innerRecuResultBB.last2}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{innerRecuResultBB.detialList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index">
     
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.pid}"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="应聘岗位"/></c:facet>
            <h:outputText value="#{list.postname}"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="应聘时间"/></c:facet>
            <h:outputText value="#{list.applyDate}"/>
       </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="应聘结果"/></c:facet>
            <h:outputText value="#{list.resultDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="审批" onclick="return audit('#{list.detailid}')" styleClass="button01" rendered="#{list.isAudit=='0'}"></h:commandButton>
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
