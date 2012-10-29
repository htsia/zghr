<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function showQryInfo(id) {
            window.showModalDialog("/xys/eva/Person360ScoreQryInfo.jsf?objId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{person_360AuditCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{person_360AuditCtrBB.initQry}"></h:inputHidden>
     <c:verbatim>
    <br>
       <table height=90% width=100% align="center">
       <tr><td height=8>
       </c:verbatim>
    <h:panelGrid width="98%" columns="2">
    	  <h:panelGrid align="center">
		  <h:panelGroup>
                  <h:outputText value="姓名或员工编号:"></h:outputText>
                  <h:inputText value="#{person_360AuditCtrBB.queryValue}" styleClass="input"></h:inputText>
                  <h:commandButton value="查询" action="#{person_360AuditCtrBB.queryObj}" styleClass="button01"></h:commandButton>
              </h:panelGroup>
		  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{person_360AuditCtrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{person_360AuditCtrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{person_360AuditCtrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{person_360AuditCtrBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{person_360AuditCtrBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{person_360AuditCtrBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{person_360AuditCtrBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{person_360AuditCtrBB.last1}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
      &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{person_360AuditCtrBB.objList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
         <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="总人数"/></c:facet>
            <h:outputText value="#{list.allCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="打分人数"/></c:facet>
            <h:outputText value="#{list.signCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="未打分人数"/></c:facet>
            <h:outputText value="#{list.noSignCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="打分情况" onclick="showQryInfo('#{list.objId}')" styleClass="button01" type="button"></h:commandButton>
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
