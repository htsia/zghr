<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
	
    <script type="text/javascript">
         function addRule(){
             window.showModalDialog("/wage/adjust/adjRuleEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:400px; dialogHeight:400px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/wage/adjust/adjRuleEdit.jsf?adjId="+id, "", "dialogWidth:400px; dialogHeight:400px; status:0;resizable:yes");
            return true;
        }
        function query(id){
            window.showModalDialog("/train/TrainClassAuditQuery.jsf?adjId="+id, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wage_nomalAdjListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_nomalAdjListBB.initRuleList}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{wage_nomalAdjListBB.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=100% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 薪酬管理 -> 晋级晋档</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{wage_nomalAdjListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{wage_nomalAdjListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{wage_nomalAdjListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{wage_nomalAdjListBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{wage_nomalAdjListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{wage_nomalAdjListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{wage_nomalAdjListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{wage_nomalAdjListBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addRule();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{wage_nomalAdjListBB.adjustRultList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建单位"/></c:facet>
            <h:outputText value="#{list.adjCreateOrg}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="适用范围"/></c:facet>
            <h:outputText value="#{list.adjOrgId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="晋级范围1"/></c:facet>
            <h:outputText value="#{list.scopeValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="晋级范围2"/></c:facet>
            <h:outputText value="#{list.scopeValue2}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="晋级时间"/></c:facet>
            <h:outputText value="#{list.timeField}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="晋级时间低限"/></c:facet>
            <h:outputText value="#{list.timeValueLow}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="晋级时间高限"/></c:facet>
            <h:outputText value="#{list.timeValueHigh}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="晋级结果"/></c:facet>
            <h:outputText value="#{list.resultValue}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.adjId}')" styleClass="button01" rendered="#{list.ownOrg=='1'}"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{wage_nomalAdjListBB.delete}" styleClass="button01" rendered="#{list.ownOrg=='1'}">
                  <x:updateActionListener property="#{wage_nomalAdjListBB.adjId}" value="#{list.adjId}"/>
            </h:commandButton>
 	   </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
