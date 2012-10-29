<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function showPerson(planId){
    window.showModalDialog("/recruit/showInterViewPersonList.jsf?planId="+planId, null, "dialogWidth:500px; dialogHeight:500px; status:0;resizable:yes");
    return false;
   }
  
</script>
<c:verbatim><base target="_self"></c:verbatim>

<x:saveState value="#{onlineviewlistBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{onlineviewlistBB.initPage}"/>
    <h:panelGrid columns="1" align="center" width="98%">
        <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{onlineviewlistBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{onlineviewlistBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{onlineviewlistBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{onlineviewlistBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{onlineviewlistBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{onlineviewlistBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{onlineviewlistBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{onlineviewlistBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
       
        <h:dataTable value="#{onlineviewlistBB.planList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03">
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="创建人"/></c:facet>
            <h:outputText value="#{list.createID}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="创建时间"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="审批人"/></c:facet>
            <h:outputText value="#{list.approveID}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="审批时间"/></c:facet>
            <h:outputText value="#{list.approveDate}"/>
        </h:column>
  
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="开始面试"  styleClass="button01" onclick="return showPerson('#{list.planID}')">
                </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>