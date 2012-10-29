<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>	
<script type="text/javascript">
    function doShowDeatail(id){
        window.showModalDialog("/train/TrainDetailDemand.jsf?demandID="+id, null, "dialogWidth:540px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
</script>

<x:saveState value="#{train_demandlistbb}"></x:saveState>
<h:form id="form1">
    <h:inputHidden  value="#{train_demandlistbb.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{train_demandlistbb.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{train_demandlistbb.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{train_demandlistbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{train_demandlistbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{train_demandlistbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{train_demandlistbb.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{train_demandlistbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{train_demandlistbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{train_demandlistbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{train_demandlistbb.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{train_demandlistbb.demandList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_left,td_middle,td_middle_left,td_middle,td_middle,td_middle_left,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        
        <h:column>
            <c:facet name="header"><h:outputText value="申请人"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="培训需求类型"/></c:facet>
            <h:outputText value="#{list.demandTypeDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="申请人部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="希望培训形式"/></c:facet>
            <h:outputText value="#{list.demandStyleDes}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="希望培训时间"/></c:facet>
            <h:outputText value="#{list.demandTimeDes}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="申请日期"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="是否锁定"/></c:facet>
          <h:outputText id="demandLocked" value="#{list.demandLockedDes}"/> 
        </h:column>
      
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>           
         <h:commandButton type="button" value="查看" onclick="doShowDeatail('#{list.demandID}');" styleClass="button01"></h:commandButton>
            <h:commandButton id="lock"  value="锁定" styleClass="button01" onclick="return confirm('确定要锁定吗？')" action="#{train_demandlistbb.locked}" rendered="#{list.demandLocked=='0'}">
            	  <x:updateActionListener property="#{train_demandlistbb.demandID}" value="#{list.demandID}"/>
            </h:commandButton>     
            <h:commandButton id="unlock" value="解锁" styleClass="button01" onclick="return confirm('确定要解锁吗?');" action="#{train_demandlistbb.unlocked}" rendered="#{list.demandLocked=='1'}">
                  <x:updateActionListener property="#{train_demandlistbb.demandID}" value="#{list.demandID}"/>
            </h:commandButton>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
