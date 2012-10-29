<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<f:verbatim>
    <script type="text/javascript">
        function doPersonQuery(itemid) {
            window.showModalDialog("/recruit/interViewPerson.jsf?itemId="+itemid, null, "dialogWidth:700px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }

        function doPageQuery(itemid) {
            window.showModalDialog("/recruit/interViewPage.jsf?itemId="+itemid, null, "dialogWidth:600px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        
    </script>
</f:verbatim>
<x:saveState value="#{recu_interviewResultBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{recu_interviewResultBB.initPage}"></h:inputHidden>
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr><td height="8"> 
    </c:verbatim>
    
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="记录数:#{recu_interviewResultBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recu_interviewResultBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recu_interviewResultBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recu_interviewResultBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{recu_interviewResultBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recu_interviewResultBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recu_interviewResultBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recu_interviewResultBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id='datatable'>
	</c:verbatim>
    <x:dataTable value="#{recu_interviewResultBB.postList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" >
             <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
            </h:column>
        	<h:column rendered="#{recu_interviewResultBB.postMode=='0'}">
                <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
                <h:outputText value="#{list.postName}"/>
            </h:column>
            <h:column rendered="#{recu_interviewResultBB.postMode=='1'}">
                <c:facet name="header"><h:outputText value="岗位类型"/></c:facet>
                <h:outputText value="#{list.postType}"/>
            </h:column>
            <h:column rendered="#{recu_interviewResultBB.postMode=='1'}">
                <c:facet name="header"><h:outputText value="专业"/></c:facet>
                <h:outputText value="#{list.majorType}"/>
            </h:column>
            <h:column rendered="#{recu_interviewResultBB.haveTest=='1'}">
                <c:facet name="header"><h:outputText value="试卷"/></c:facet>
                <h:outputText value="#{list.paperID}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="面试人"/></c:facet>
                <h:outputText value="#{list.interviewPID}"/>
            </h:column>
            
           <h:column>
                 <c:facet name="header"><h:outputText value="操作"/></c:facet>
                 <h:commandButton value="设置试卷" styleClass="button01" onclick="return doPageQuery('#{list.itemId}');" rendered="#{recu_interviewResultBB.haveTest=='1'}"></h:commandButton>
                 <h:commandButton value="设置面试人" styleClass="button01" onclick="return doPersonQuery('#{list.itemId}');"></h:commandButton>
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