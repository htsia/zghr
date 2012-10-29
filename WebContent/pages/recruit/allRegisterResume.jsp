<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script>
   function doQuery(id){
       window.open("/recruit/resumeDetail2.jsf?personId="+id, "", "height="+screen.height*0.8+", width="+screen.width*0.8+", toolbar= no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no,top=50,left=100");
       return true;
   }
   function showTable(personId){
		url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+personId+"&ORGUID=&Parameter=&Title=";
		window.open(url);
	}
</script>


<x:saveState value="#{recu_resumeInfoBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{recu_resumeInfoBB.initAllPerson}"/>
    <h:panelGrid columns="1" align="center" width="98%">
         <h:panelGrid align="right" columns="2">
            <h:panelGroup>
            	<h:outputText value="表格："/>
    	  		<h:selectOneMenu id="ReportID" style="width:190px">
               		<c:selectItems value="#{recu_resumeInfoBB.regTableList}"/>
           	    </h:selectOneMenu>
           	    <h:outputText value="  "></h:outputText>
                <h:outputText value="记录数:#{recu_resumeInfoBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recu_resumeInfoBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recu_resumeInfoBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recu_resumeInfoBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{recu_resumeInfoBB.firstPage}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recu_resumeInfoBB.prePage}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recu_resumeInfoBB.nextPage}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recu_resumeInfoBB.lastPage}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
       
        <x:dataTable value="#{recu_resumeInfoBB.resumeList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03">
        <h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.a001001}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="性别"/></c:facet>
            <h:outputText value="男" rendered="#{list.a001007=='01001'}"/>
            <h:outputText value="女" rendered="#{list.a001007=='01002'}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="出生日期"/></c:facet>
            <h:outputText value="#{list.a001011}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="身份证号"/></c:facet>
            <h:outputText value="#{list.a001077}"/>
        </h:column>
        
         <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="简历浏览" styleClass="button01"
							onclick="return doQuery('#{list.id}');"></h:commandButton>
				<h:commandButton value="删除" styleClass="button01"
							onclick="return confirm('确定删除吗?');"
							action="#{recu_resumeInfoBB.deletePerson}">
							<x:updateActionListener property="#{recu_resumeInfoBB.personId}"
								value="#{list.id}" />
						</h:commandButton>
			    <h:commandButton value="显示表格" styleClass="button01" onclick="return showTable('#{list.id}');"/>     
        </h:column>
    </x:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>